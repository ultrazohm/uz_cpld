from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from cpld_vhdl_generator import GeneratorError, check, generate, load_config, source_entries


class GeneratorTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='generator test ')
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.config = self.root / 'generator.toml'
        self.output = self.root
        self.config.write_text('''schema_version = 3
name = "example"
routing = "routing.csv"
contract = "s3c_power_on_debounce_v1"
clock = "external"
pilot_policy = "required"
''')
        (self.root / 'routing.csv').write_text('''output,normal_state,safe_state
d_00,fpga_00,0
fpga_01,d_01,d_01
''')

    def profile(self, mode, ready='unused'):
        (self.root / 'profile.toml').write_text(f'''id = "test_contract"
compatible_s3c = ["test_s3c"]
implementation = "level_signals"
request_mode = "{mode}"
carrier_ready = "{ready}"
slotok = [1, 0]
reqoe = [1, 1]
''')
        self.config.write_text(self.config.read_text().replace('"s3c_power_on_debounce_v1"', '"profile.toml"'))

    def test_shared_sources_and_selected_contract(self):
        sources = generate(self.config, self.output)
        entries = source_entries(load_config(self.config), self.output)
        self.assertEqual([s.library for s in entries], ['s3c', 's3c', 'work'])
        self.assertEqual([s.path for s in entries], sources)
        self.assertFalse((self.output / 's3c_logic.vhdl').exists())
        top = sources[-1].read_text()
        self.assertIn('controller: entity s3c.s3c_logic(level_signals)', top)
        self.assertIn("REQUEST_SAFE_LEVEL => '1'", top)
        check(self.config, self.output)
        self.profile('active_low', 'active_high')
        generate(self.config, self.output)
        top = sources[-1].read_text()
        self.assertIn("REQUEST_SAFE_LEVEL => '0'", top)
        self.assertIn('USE_CARRIER_READY => true', top)

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_select_alternative_shared_architecture(self):
        config = load_config(self.config)
        library = self.root / 'shared'
        shutil.copytree(config.s3c_library, library)
        alternate = (library / 'level_signals.vhdl').read_text().replace('architecture level_signals', 'architecture alternate')
        alternate = alternate.replace('slotok <= SLOTOK_NORMAL', "slotok <= '0'")
        (library / 'alternate.vhdl').write_text(alternate)
        self.profile('active_high')
        profile = self.root / 'profile.toml'
        profile.write_text(profile.read_text().replace('"level_signals"', '"alternate"'))
        self.config.write_text(self.config.read_text() + 's3c_library = "shared"\n')
        self.simulate("reqsafestate <= '0'; src <= '1'; cycles(8); assert outp = '1' and slotok = '0' severity failure;")
        entries = source_entries(load_config(self.config), self.output)
        self.assertEqual(entries[1].path, library / 'alternate.vhdl')
        check(self.config, self.output)
        with (library / 'alternate.vhdl').open('a') as stream:
            stream.write('\n-- shared implementation changed\n')
        with self.assertRaisesRegex(GeneratorError, 'inputs changed'):
            check(self.config, self.output)

    def test_deterministic_generation_and_relocation(self):
        generate(self.config, self.output)
        first = {p.name: p.read_bytes() for p in self.output.iterdir()}
        generate(self.config, self.output)
        self.assertEqual(first, {p.name: p.read_bytes() for p in self.output.iterdir()})
        check(self.config, self.output)
        moved = self.root / 'relocated'
        shutil.copytree(self.root, moved, ignore=shutil.ignore_patterns('relocated'))
        check(moved / 'generator.toml', moved)

    def test_changed_input_and_edited_generated_file_rejected(self):
        generate(self.config, self.output)
        self.config.write_text(self.config.read_text() + '\n# authored change\n')
        with self.assertRaisesRegex(GeneratorError, 'inputs changed'):
            check(self.config, self.output)
        generate(self.config, self.output)
        top = self.output / 'example.vhdl'
        top.write_text(top.read_text() + '\n-- manual edit\n')
        with self.assertRaisesRegex(GeneratorError, 'Stale'):
            check(self.config, self.output)
        with self.assertRaisesRegex(GeneratorError, 'edited or unowned'):
            generate(self.config, self.output)

    def test_reject_invalid_routing(self):
        routing = self.root / 'routing.csv'
        original = routing.read_text()
        invalid = [original.replace('d_00,fpga_00,0', 'd_00,fpga_00,'),
                   original + 'd_00,fpga_00,0\n',
                   original.replace('d_00,fpga_00', 'd_00,d_00'),
                   original.replace('d_00,fpga_00', 'd_00,fpga_01'),
                   original.replace('d_00,fpga_00', 'd_00,fpga_00 AND d_01'),
                   original.replace('d_00,fpga_00', 'd_00,custom.missing'),
                   original + 'd_02,0,0,extra\n',
                   original.replace('output,normal_state,safe_state', 'pin,direction,normal,safe,error')]
        for bad in ('fpga_000', 'fpga_0', 'fpga_30', 'd_0', 'd_30', 'D_00', 'FPGA_00',
                    'pilot_in', 'i2c_scl', 'typo', '-', 'X', 'z'):
            invalid += [original.replace('d_00,fpga_00', f'{bad},fpga_00'),
                        original.replace('d_00,fpga_00', f'd_00,{bad}')]
        for text in invalid:
            with self.subTest(text=text):
                routing.write_text(text)
                with self.assertRaises(GeneratorError):
                    load_config(self.config)
        routing.write_text(original)

    def test_contract_status_requires_two_levels(self):
        self.profile('active_high')
        profile = self.root / 'profile.toml'
        original = profile.read_text()
        for field, levels in [('slotok', '[1, 0]'), ('reqoe', '[1, 1]')]:
            with self.subTest(field=field):
                profile.write_text(original.replace(f'{field} = {levels}', f'{field} = [1, 0, 0]'))
                with self.assertRaisesRegex(GeneratorError, 'two bits'):
                    load_config(self.config)

    def test_heartbeat_is_not_implemented(self):
        self.profile('heartbeat', 'active_high')
        with self.assertRaisesRegex(GeneratorError, 'heartbeat is not implemented'):
            load_config(self.config)

    def test_reject_removed_features_and_unknown_keys(self):
        original = self.config.read_text()
        for extra in ('unrecognized = true', 'fault_recovery = "safe_cycle"', 'heartbeat_timeout_cycles = 8', 'heartbeat_edges = 2',
                      '[custom]\npath = "custom.vhdl"\nsignals = ["processed"]'):
            with self.subTest(extra=extra):
                self.config.write_text(original + extra + '\n')
                with self.assertRaises(GeneratorError):
                    load_config(self.config)
        self.config.write_text(original.replace('"example"', '"s3c_logic"'))
        with self.assertRaisesRegex(GeneratorError, 'reserved'):
            load_config(self.config)

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_active_high_safe_and_automatic_pilot_recovery(self):
        self.simulate('''
        cycles(8); assert slotok = '0' and outp = '0' and rx = '1' severity failure;
        reqsafestate <= '0'; cycles(3);
        assert slotok = '1' and outp = '0' and reqoe = '1' severity failure;
        src <= '1'; wait for 1 ns; assert outp = '1' severity failure;
        reqsafestate <= '1'; cycles(3);
        assert slotok = '0' and outp = '0' and rx = '1' severity failure;
        reqsafestate <= '0'; cycles(3); assert slotok = '1' and outp = '1' severity failure;
        pilot_in <= '0'; cycles(3);
        assert slotok = '0' and outp = '0' and rx = '1' and reqoe = '1' severity failure;
        pilot_in <= '1'; cycles(3); assert slotok = '1' and outp = '1' severity failure;
        pilot_in <= 'X'; cycles(3); assert slotok = '0' and outp = '0' severity failure;
        pilot_in <= '1'; cycles(3); assert slotok = '1' severity failure;
        pilot_in <= '0'; cycles(3); reqsafestate <= '1'; cycles(3);
        pilot_in <= '1'; cycles(3); assert slotok = '0' and outp = '0' severity failure;
        reqsafestate <= '0'; cycles(3); assert slotok = '1' and outp = '1' severity failure;
        ''')

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_active_low_and_enable_pattern(self):
        self.profile('active_low')
        self.config.write_text(self.config.read_text() + 'enable = { fpga_02 = 1 }\n')
        self.simulate('''
        reqsafestate <= '0'; cycles(8); assert slotok = '0' severity failure;
        reqsafestate <= '1'; cycles(5); assert slotok = '0' severity failure;
        enablepin <= '1'; cycles(3); assert slotok = '1' severity failure;
        reqsafestate <= '0'; cycles(3); assert slotok = '0' and outp = '0' severity failure;
        reqsafestate <= '1'; cycles(3); assert slotok = '1' severity failure;
        enablepin <= '0'; cycles(3); assert slotok = '0' severity failure;
        ''')

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_carrier_ready_polarities(self):
        for mode, active, inactive in [('active_high', '1', '0'), ('active_low', '0', '1')]:
            with self.subTest(mode=mode):
                self.profile('active_high', mode)
                self.simulate(f'''
        carrierrdy <= '{inactive}'; reqsafestate <= '0'; cycles(8);
        assert slotok = '0' and outp = '0' severity failure;
        carrierrdy <= '{active}'; cycles(3); assert slotok = '1' severity failure;
        carrierrdy <= '{inactive}'; cycles(3); assert slotok = '0' severity failure;
        carrierrdy <= 'X'; cycles(3); assert slotok = '0' severity failure;
        carrierrdy <= '{active}'; cycles(3); assert slotok = '1' severity failure;
        ''')

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_unknown_request_reset_and_tristate(self):
        routing = self.root / 'routing.csv'
        routing.write_text(routing.read_text().replace('d_00,fpga_00,0', 'd_00,fpga_00,Z'))
        self.simulate('''
        cycles(8); assert outp = 'Z' severity failure;
        reqsafestate <= '0'; cycles(3); assert outp = '0' and slotok = '1' severity failure;
        reqsafestate <= 'X'; cycles(3); assert outp = 'Z' and slotok = '0' severity failure;
        reqsafestate <= '0'; cycles(3); assert slotok = '1' severity failure;
        pilot_in <= '0'; cycles(3); assert outp = 'Z' and slotok = '0' severity failure;
        reset <= '1'; cycles(1); assert outp = 'Z' severity failure;
        pilot_in <= '1'; reset <= '0'; cycles(8); assert slotok = '1' severity failure;
        ''')

    def test_full_interface_and_unused_pins(self):
        config = load_config(self.config)
        pins = {p.name: p for p in config.pins}
        expected = {f'{bank}_{i:02d}' for bank in ('d', 'fpga') for i in range(30)}
        self.assertEqual(set(pins), expected)
        self.assertEqual({p.name for p in config.pins if p.direction == 'out'}, {'d_00', 'fpga_01'})
        self.assertEqual(pins['d_29'].direction, 'in')
        self.assertEqual(pins['fpga_29'].direction, 'in')
        self.assertEqual(pins['d_29'].actions, ('', ''))
        self.config.write_text(self.config.read_text() + 'enable = {fpga_29 = 1}\n')
        self.assertEqual(load_config(self.config).enable, {'fpga_29': 1})
        for invalid in ('d_00', 'fpga_30', 'fpga_0', 'i2c_scl'):
            self.config.write_text(self.config.read_text().split('enable =')[0] + f'enable = {{{invalid} = 1}}\n')
            with self.assertRaises(GeneratorError):
                load_config(self.config)

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_ungated_fanout_constants_and_unused_inputs(self):
        routing = self.root / 'routing.csv'
        routing.write_text(routing.read_text() + 'd_02,fpga_00,fpga_00\nd_03,1,0\n')
        self.simulate('''
        cycles(8); assert always_out = '0' and constant_out = '0' severity failure;
        src <= '1'; wait for 1 ns; assert always_out = '1' and outp = '0' severity failure;
        reqsafestate <= '0'; cycles(3);
        assert always_out = '1' and outp = '1' and constant_out = '1' severity failure;
        pilot_in <= '0'; cycles(3);
        assert always_out = '1' and constant_out = '0' severity failure;
        src <= '0'; wait for 1 ns; assert always_out = '0' severity failure;
        ''')

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_empty_routing_retains_all_pins_as_inputs(self):
        (self.root / 'routing.csv').write_text('output,normal_state,safe_state\n')
        config = load_config(self.config)
        self.assertEqual(len(config.pins), 60)
        self.assertTrue(all(p.direction == 'in' for p in config.pins))
        self.simulate("cycles(8); assert slotok = '0' severity failure;")

    def simulate(self, body):
        sources = generate(self.config, self.output)
        config = load_config(self.config)
        signals = {'fpga_00': 'src', 'd_01': 'feedback', 'fpga_02': 'enablepin',
                   'd_00': 'outp', 'fpga_01': 'rx', 'd_02': 'always_out', 'd_03': 'constant_out'}
        mappings = []
        for pin in config.pins:
            default = 'open' if pin.direction == 'out' else "'0'"
            mappings.append(f'{pin.name} => {signals.get(pin.name, default)}')
        bench = self.root / 'bench.vhdl'
        bench.write_text('''library ieee;
use ieee.std_logic_1164.all;
entity bench is end entity;
architecture test of bench is
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal pilot_in : std_logic := '1';
    signal reqsafestate : std_logic := '1';
    signal carrierrdy : std_logic := '0';
    signal feedback : std_logic := '1';
    signal src, enablepin : std_logic := '0';
    signal outp, rx, slotok, reqoe, always_out, constant_out : std_logic;
begin
    dut: entity work.example port map (
        clk => clk, reset => reset, pilot_in => pilot_in, reqsafestate => reqsafestate,
        carrierrdy => carrierrdy, slotok => slotok, reqoe => reqoe,
        i2c_scl => '0', i2c_sda => '0',
''' + ',\n'.join(mappings) + ''');
    process
        procedure cycles(n : positive) is
        begin
            for i in 1 to n loop
                clk <= '0'; wait for 5 ns; clk <= '1'; wait for 5 ns;
            end loop;
        end procedure;
    begin
        cycles(1); reset <= '0';
''' + body + '''
        report "CONTRACT PASSED";
        wait;
    end process;
end architecture;
''')
        commands = [['ghdl', '-a', '--std=93', '-P.', f'--work={source.library}', str(source.path)]
                    for source in source_entries(config, self.output)]
        commands += [['ghdl', '-a', '--std=93', '-P.', str(bench)],
                     ['ghdl', '-e', '--std=93', '-P.', 'bench'],
                     ['ghdl', '-r', '--std=93', '-P.', 'bench', '--assert-level=error']]
        for command in commands:
            result = subprocess.run(command, cwd=self.root, capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn('CONTRACT PASSED', result.stdout + result.stderr)
