"""Repository integration for independently generated VHDL programs."""
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import unittest

from toolchain.buildsystem import workflow
from toolchain.buildsystem.model import BuildError, load_build

ROOT = Path(__file__).resolve().parents[2]


class GeneratedProgramTests(unittest.TestCase):
    def test_clone_regenerates_names_and_checks_sources(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            for folder in ('programs', 'toolchain'):
                shutil.copytree(ROOT / folder, root / folder,
                                ignore=shutil.ignore_patterns('build', '__pycache__'))
            new = workflow.scaffold(root, 'stateful_clone', 'tx30_stateful')
            build = load_build(root, 'stateful_clone')
            self.assertEqual(build.top, 'stateful_clone')
            self.assertFalse((new / 'tx30_stateful.vhdl').exists())
            self.assertFalse((new / 'generated').exists())
            self.assertEqual([s.path for s in build.sources],
                             [new / 's3c_logic.vhdl', new / 'stateful_clone.vhdl'])
            routing = new / 'routing.csv'
            self.assertEqual(routing.read_bytes(), (ROOT / 'programs/tx30_stateful/routing.csv').read_bytes())
            routing.write_text(routing.read_text().replace('d_00,fpga_00,0', 'd_00,fpga_00,1'))
            with self.assertRaisesRegex(BuildError, 'Stale'):
                load_build(root, 'stateful_clone')

    @unittest.skipUnless(shutil.which('ghdl'), 'GHDL required')
    def test_actual_s3c_startup_soft_stop_and_enable(self):
        """Use the real S3C debounce and startup counters with a faster simulation clock."""
        s3c = load_build(ROOT, 's3c_power_on_debounce')
        slot = load_build(ROOT, 'tx30_stateful')
        with tempfile.TemporaryDirectory(prefix='s3c slot pair ') as temp:
            temp = Path(temp)
            oscillator = temp / 'osch.vhdl'
            oscillator.write_text('''library ieee;
use ieee.std_logic_1164.all;
entity OSCH is
    generic (NOM_FREQ : string := "2.08");
    port (STDBY : in std_logic; OSC, SEDSTDBY : out std_logic);
end entity;
architecture simulation of OSCH is
begin
    process begin
        OSC <= '0'; wait for 5 ns; OSC <= '1'; wait for 5 ns;
    end process;
    SEDSTDBY <= '0';
end architecture;
''')
            source = re.sub(r'--[^\n]*', '', s3c.sources[0].path.read_text()).split('end Waiting_for_Powerbutton_pressed_V0;')[0]
            ports = re.findall(r'(\w+)\s*:\s*(inout|out|in)\s+(STD_LOGIC(?:_VECTOR\s*\([^)]*\))?)', source, re.I)
            self.assertGreater(len(ports), 60)
            special = {'syssw_pwr_nc': 'power_button', 'fp_usrsw3': 'stop_button', 'fp_usrsw1': 'enable_button',
                       'digs3c_shared_reqsafestate': 'safe_request', 'digs3c_shared_carrierready': 'carrier_ready',
                       'digs3c_slotd_slotoe': 'slot_oe', 'digs3c_slotd_reqoe': 'reqoe_bus',
                       'digs3c_slotd_slotok': 'slotok_bus'}
            assignments = []
            for name, direction, kind in ports:
                value = special.get(name.lower())
                if value is None:
                    value = 'open' if direction.lower() != 'in' else ("(others => '1')" if 'VECTOR' in kind.upper() else "'1'")
                assignments.append(f'{name} => {value}')
            slot_ports = [ "pilot_in => '0'", 'reqsafestate => safe_request',
                          'carrierrdy => carrier_ready', 'slotok => slotok', 'reqoe => reqoe',
                          "i2c_scl => '0'", "i2c_sda => '0'"]
            slot_ports += [f"fpga_{i:02d} => '1'" for i in range(30)]
            slot_ports += [f'd_{i:02d} => outputs({i})' for i in range(30)]
            bench = temp / 'pair.vhdl'
            bench.write_text('''configuration simulated_s3c of Waiting_for_Powerbutton_pressed_V0 is
    for behavior
        for OSCInst0 : OSCH
            use entity work.OSCH(simulation);
        end for;
    end for;
end configuration;
configuration simulated_slot of tx30_stateful is
    for rtl
        for oscillator : OSCH
            use entity work.OSCH(simulation);
        end for;
    end for;
end configuration;
library ieee;
use ieee.std_logic_1164.all;
entity pair is end entity;
architecture test of pair is
    signal power_button, stop_button, enable_button : std_logic := '1';
    signal safe_request, carrier_ready, slotok, reqoe : std_logic;
    signal slot_oe, reqoe_bus, slotok_bus : std_logic_vector(5 downto 1);
    signal outputs : std_logic_vector(29 downto 0);
begin
    reqoe_bus <= (others => reqoe);
    slotok_bus <= (others => slotok);
    s3c: configuration work.simulated_s3c port map (
''' + ',\n'.join(assignments) + ''');
    slot: configuration work.simulated_slot port map (
''' + ',\n'.join(slot_ports) + ''');
    process
    begin
        wait for 150 ns;
        assert safe_request = '1' and slot_oe = "00000" and outputs = (outputs'range => '0')
            report "startup" severity failure;
        power_button <= '0'; wait for 210 us;
        power_button <= '1'; wait for 22 ms;
        assert safe_request = '0' and slot_oe = "11111" and outputs = (outputs'range => '1')
            report "ready" severity failure;
        stop_button <= '0'; wait for 210 us;
        assert safe_request = '1' and slot_oe = "11111" and outputs = (outputs'range => '0')
            report "soft stop must gate data even with physical OE asserted" severity failure;
        stop_button <= '1'; enable_button <= '0'; wait for 210 us;
        assert safe_request = '0' and slot_oe = "11111" and outputs = (outputs'range => '1')
            report "enable after soft stop" severity failure;
        report "S3C PAIR PASSED";
        wait;
    end process;
end architecture;
''')
            commands = [
                ['ghdl', '-a', '--std=93', str(oscillator), str(s3c.sources[0].path),
                 *(str(s.path) for s in slot.sources), str(bench)],
                ['ghdl', '-e', '--std=93', 'pair'],
                ['ghdl', '-r', '--std=93', 'pair', '--assert-level=error', '--stop-time=23ms'],
            ]
            for command in commands:
                result = subprocess.run(command, cwd=temp, capture_output=True, text=True, timeout=60)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn('S3C PAIR PASSED', result.stdout + result.stderr)
