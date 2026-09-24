from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

from cpld_vhdl_generator import GeneratorError, check, generate, load_config, render


class GeneratorTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='generator test ')
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.config = self.root / 'generator.toml'
        self.output = self.root
        self.config.write_text('''schema_version = 1
name = "example"
routing = "routing.csv"
contract = "s3c_power_on_debounce_v1"
clock = "external"
pilot_policy = "required"
fault_recovery = "safe_cycle"
''')
        (self.root / 'routing.csv').write_text('''pin,direction,normal,safe,error
src,in,,,
feedback,in,,,
enablepin,in,,,
outp,out,src,0,1
rx,out,feedback,feedback,0
''')

    def profile(self, mode, ready='unused'):
        (self.root / 'profile.toml').write_text(f'''id = "test_contract"
compatible_s3c = ["test_s3c"]
request_mode = "{mode}"
carrier_ready = "{ready}"
slotok = [1, 0, 0]
reqoe = [1, 1, 1]
''')
        self.config.write_text(self.config.read_text().replace('"s3c_power_on_debounce_v1"', '"profile.toml"'))

    def test_two_sources_and_only_selected_contract(self):
        sources = generate(self.config, self.output)
        self.assertEqual(sources, [self.output / 's3c_logic.vhdl', self.output / 'example.vhdl'])
        logic = sources[0].read_text()
        self.assertIn("request_sync = '0'", logic)
        self.assertNotIn('ready_meta', logic)
        self.assertNotIn('generic', logic)
        self.assertNotIn('heartbeat', logic.lower())
        self.assertNotIn('custom', logic.lower())
        self.assertIn('controller: entity work.s3c_logic', sources[1].read_text())
        check(self.config, self.output)
        self.profile('active_low', 'active_high')
        generate(self.config, self.output)
        logic = sources[0].read_text()
        self.assertIn("request_sync = '1'", logic)
        self.assertIn("ready_sync = '1'", logic)
        self.assertNotIn("request_sync = '0'", logic)

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
        invalid = [original.replace('outp,out,src,0,1', 'outp,out,src,,1'),
                   original + 'outp,out,src,0,0\n',
                   original.replace('outp,out,src', 'outp,out,' + 'outp'),
                   original.replace('outp,out,src', 'outp,out,' + 'src AND feedback'),
                   original.replace('outp,out,src', 'outp,out,' + 'custom.missing'),
                   original.replace('src,in,,,', 'src,in,1,0,0'),
                   original.replace('src,in,,,', 'src,inout,,,'),
                   original.replace('enablepin', 'reqoe'),
                   original.replace('enablepin', 'end'),
                   original + 'x,out,0,0,0,extra\n']
        for text in invalid:
            with self.subTest(text=text):
                routing.write_text(text)
                with self.assertRaises(GeneratorError):
                    load_config(self.config)
        routing.write_text(original)

    def test_heartbeat_is_not_implemented(self):
        self.profile('heartbeat', 'active_high')
        with self.assertRaisesRegex(GeneratorError, 'heartbeat is not implemented'):
            load_config(self.config)

    def test_reject_removed_features_and_unknown_keys(self):
        original = self.config.read_text()
        for extra in ('unrecognized = true', 'heartbeat_timeout_cycles = 8', 'heartbeat_edges = 2',
                      '[custom]\npath = "custom.vhdl"\nsignals = ["processed"]'):
            with self.subTest(extra=extra):
                self.config.write_text(original + extra + '\n')
                with self.assertRaises(GeneratorError):
                    load_config(self.config)
        self.config.write_text(original.replace('"safe_cycle"', '"custom_ack"'))
        with self.assertRaisesRegex(GeneratorError, 'fault_recovery'):
            load_config(self.config)
        self.config.write_text(original.replace('"example"', '"s3c_logic"'))
        with self.assertRaisesRegex(GeneratorError, 'reserved'):
            load_config(self.config)

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_active_high_safe_and_latched_error(self):
        self.simulate('''
        cycles(8); assert slotok = '0' and outp = '0' and rx = '1' severity failure;
        reqsafestate <= '0'; cycles(5);
        assert slotok = '1' and outp = '0' and reqoe = '1' severity failure;
        src <= '1'; wait for 1 ns; assert outp = '1' severity failure;
        src <= '0'; reqsafestate <= '1'; cycles(3);
        assert slotok = '0' and outp = '0' and rx = '1' severity failure;
        reqsafestate <= '0'; cycles(3); assert slotok = '1' severity failure;
        pilot_in <= '0'; cycles(3);
        assert slotok = '0' and outp = '1' and rx = '0' and reqoe = '1' severity failure;
        reqsafestate <= '1'; cycles(5); reqsafestate <= '0'; cycles(5);
        pilot_in <= '1'; cycles(6); assert outp = '1' and slotok = '0' severity failure;
        reqsafestate <= '1'; cycles(5); reqsafestate <= '0'; cycles(5);
        assert slotok = '1' and outp = '0' severity failure;
        ''')

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL is needed for HDL behavioral checks')
    def test_active_low_and_enable_pattern(self):
        self.profile('active_low')
        self.config.write_text(self.config.read_text() + 'enable = { enablepin = 1 }\n')
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
        routing.write_text(routing.read_text().replace('outp,out,src,0,1', 'outp,out,src,Z,1'))
        self.simulate('''
        cycles(8); assert outp = 'Z' severity failure;
        reqsafestate <= '0'; cycles(3); assert outp = '0' and slotok = '1' severity failure;
        reqsafestate <= 'X'; cycles(3); assert outp = 'Z' and slotok = '0' severity failure;
        reqsafestate <= '0'; cycles(3); assert slotok = '1' severity failure;
        pilot_in <= '0'; cycles(3); assert outp = '1' and slotok = '0' severity failure;
        reset <= '1'; cycles(1); assert outp = 'Z' severity failure;
        pilot_in <= '1'; reset <= '0'; cycles(8); assert slotok = '1' severity failure;
        ''')

    def simulate(self, body):
        sources = generate(self.config, self.output)
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
    signal outp, rx, slotok, reqoe : std_logic;
begin
    dut: entity work.example port map (
        clk => clk, reset => reset, pilot_in => pilot_in, reqsafestate => reqsafestate,
        carrierrdy => carrierrdy, slotok => slotok, reqoe => reqoe, src => src,
        feedback => feedback,
        enablepin => enablepin, outp => outp, rx => rx);
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
        for command in (['ghdl', '-a', '--std=93', *map(str, sources), str(bench)],
                        ['ghdl', '-e', '--std=93', 'bench'],
                        ['ghdl', '-r', '--std=93', 'bench', '--assert-level=error']):
            result = subprocess.run(command, cwd=self.root, capture_output=True, text=True, timeout=30)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn('CONTRACT PASSED', result.stdout + result.stderr)
