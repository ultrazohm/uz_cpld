"""Exercise simulation isolation with real GHDL analysis and cocotb runs."""
from importlib.util import find_spec
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[3]


@unittest.skipUnless(shutil.which('ghdl') and find_spec('cocotb') and find_spec('pytest'),
                     'GHDL, cocotb and pytest required')
class SimulationTests(unittest.TestCase):
    def test_removed_source_cannot_be_reused_from_compiled_libraries(self):
        for library in ('work', 'helpers'):
            with self.subTest(library=library), tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                shutil.copytree(ROOT / 'cpld_toolchain/toolchain', root / 'cpld_toolchain/toolchain',
                                ignore=shutil.ignore_patterns('build', '__pycache__'))
                program = root / 'programs/original/probe'
                program.mkdir(parents=True)
                (root / 'programs/releases.toml').write_text('current = "original"\n')
                (program.parent / 'catalog.toml').write_text('programs = ["probe"]\n')
                (program / 'probe_constraints.lpf').write_text('# Simulation only\n')
                (program / 'helper.vhdl').write_text('''library ieee;
use ieee.std_logic_1164.all;
entity helper is port (i: in std_logic; o: out std_logic); end;
architecture rtl of helper is begin o <= i; end;
''')
                (program / 'probe.vhdl').write_text(f'''library ieee, {library};
use ieee.std_logic_1164.all;
entity probe is port (i: in std_logic; o: out std_logic); end;
architecture rtl of probe is begin
    dep: entity {library}.helper port map (i => i, o => o);
end;
''')
                (program / 'probe_tb.py').write_text('''import cocotb
from cocotb.triggers import Timer
@cocotb.test()
async def route(dut):
    dut.i.value = 1
    await Timer(1, unit="ns")
    assert int(dut.o.value) == 1
''')
                helper = f'{{path="helper.vhdl", library="{library}"}}, '
                manifest = program / 'probe.toml'
                original = f'''name = "probe"
top = "probe"
standard = "1993"
targets = ["uz_dslot_xo2"]
constraints = ["probe_constraints.lpf"]
sources = [{helper}{{path="probe.vhdl", library="work"}}]
testbench = "probe_tb.py"
'''
                manifest.write_text(original)

                def simulate():
                    return subprocess.run(
                        [sys.executable, '-m', 'pytest', 'cpld_toolchain/toolchain/simulation/test_simulation.py',
                         '--program', 'probe', '-q'], cwd=root, capture_output=True,
                        text=True, timeout=30)

                first = simulate()
                self.assertEqual(first.returncode, 0, first.stdout + first.stderr)
                output = program / 'build/simulation'
                self.assertTrue((output / 'waves.vcd').is_file())
                # The file still exists; only the manifest stops declaring it.
                manifest.write_text(original.replace(helper, ''))
                second = simulate()
                self.assertNotEqual(second.returncode, 0, second.stdout + second.stderr)
                self.assertIn('helper', second.stdout + second.stderr)
                self.assertFalse((output / 'waves.vcd').exists())
                self.assertFalse(list(output.glob('*.result.xml')))
                run = json.loads((output / 'metadata/run.json').read_text())
                self.assertNotIn('simulation_duration_ns', run)
                manifest.write_text(original)
                recovered = simulate()
                self.assertEqual(recovered.returncode, 0, recovered.stdout + recovered.stderr)

                # A passing HDL test must not publish success if its authored input changes mid-run.
                testbench = program / 'probe_tb.py'
                testbench.write_text(testbench.read_text() +
                    '    from pathlib import Path\n'
                    '    source = Path(__file__).with_name("helper.vhdl")\n'
                    '    source.write_text(source.read_text() + "\\n-- changed during simulation\\n")\n')
                changed = simulate()
                self.assertNotEqual(changed.returncode, 0, changed.stdout + changed.stderr)
                self.assertIn('Simulation inputs changed', changed.stdout + changed.stderr)
                run = json.loads((output / 'metadata/run.json').read_text())
                self.assertNotIn('simulation_duration_ns', run)
