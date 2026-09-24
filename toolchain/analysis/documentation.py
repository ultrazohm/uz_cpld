"""Generate program pages from fresh RTL schematics and passing simulations."""
import json
from pathlib import Path
import shutil
import subprocess
import sys

from toolchain.analysis.netlist import ROOT, export_netlist
from toolchain.analysis.waveform import write_waveform
from toolchain.buildsystem.model import BuildError, load_build
from toolchain.buildsystem.workflow import digest, write_json


def generate(root=ROOT):
    """Build documentation assets for every program manifest, including clones."""
    generated = root / 'docs/_generated'
    if generated.is_symlink():
        raise BuildError('Generated documentation directory must not be a symlink')
    if generated.exists():
        shutil.rmtree(generated)
    pages = generated / 'programs'
    pages.mkdir(parents=True)
    names = sorted(p.parent.name for p in (root / 'programs').glob('*/*.toml')
                   if p.stem == p.parent.name)
    if not names:
        raise BuildError('No program manifests found')
    for name in names:
        build = load_build(root, name)
        netlist = export_netlist(build)
        before = {str(p.relative_to(root)): digest(p) for p in (*[s.path for s in build.sources], build.testbench)}
        subprocess.run([sys.executable, '-m', 'pytest', 'toolchain/simulation/test_simulation.py',
                        '--program', name, '--wave-format', 'vcd', '--seed', '1', '-q'], cwd=root, check=True)
        if before != {str(p.relative_to(root)): digest(p) for p in (*[s.path for s in build.sources], build.testbench)}:
            raise BuildError(f'{name}: sources changed while generating documentation')
        net_inputs = json.loads((netlist / 'metadata/netlist.json').read_text())['inputs']
        if any((before[path] if path in before else digest(root / path)) != value
               for path, value in net_inputs.items()):
            raise BuildError(f'{name}: netlist and simulation use different HDL')
        simulation = build.build_root / 'simulation'
        run = json.loads((simulation / 'metadata/run.json').read_text())
        info = write_waveform(simulation / 'waves.vcd', simulation / 'waveform.html',
                              f'{name} — RTL waveform', run['simulation_duration_ns'])
        write_json(simulation / 'metadata/waveform.json', {**info, 'inputs': before,
                   'vcd_sha256': digest(simulation / 'waves.vcd'), 'seed': 1})
        assets = generated / 'static/program-assets' / name
        assets.mkdir(parents=True)
        for src in [netlist / 'netlist.svg', netlist / 'netlist.pdf', netlist / 'metadata/netlist.json',
                    simulation / 'waveform.html', simulation / 'waves.vcd',
                    simulation / 'metadata/waveform.json', simulation / 'metadata/run.json']:
            destination = assets / 'metadata' if src.suffix == '.json' else assets
            destination.mkdir(exist_ok=True)
            shutil.copy2(src, destination / src.name)
        intro = root / 'programs' / name / 'description.rst'
        description = (f'.. include:: ../../../programs/{name}/description.rst\n\n' if intro.is_file()
                       else 'This page is generated from the program manifest, HDL and cocotb testbench.\n\n')
        page = f'''{name}
{'=' * len(name)}

{description}Target: ``{build.target}``; top entity: ``{build.top}``.

RTL netlist
-----------

The schematic shows generic RTL before device mapping, placement and routing; see :doc:`/program-documentation` for interpretation and limitations.

.. image:: ../static/program-assets/{name}/netlist.svg
   :alt: Generic RTL netlist for {name}
   :width: 100%
   :target: ../../program-assets/{name}/netlist.svg

Download :download:`SVG <../static/program-assets/{name}/netlist.svg>`, :download:`PDF <../static/program-assets/{name}/netlist.pdf>` or :download:`netlist provenance <../static/program-assets/{name}/metadata/netlist.json>`.

Simulation waveform
-------------------

The passing cocotb regression produces **{info['duration_ns']:g} ns** of simulated time across **{info['signal_count']} signals**.
Select a channel and time range, drag to zoom, and hover to read values.
Unknown and high-impedance values appear at mid-level.

.. only:: html

   .. raw:: html

      <iframe src="../../program-assets/{name}/waveform.html" title="{name} simulation waveform" style="width:100%;height:800px;border:1px solid #ddd" loading="lazy"></iframe>

Download the :download:`interactive waveform <../static/program-assets/{name}/waveform.html>`, :download:`VCD trace <../static/program-assets/{name}/waves.vcd>`, :download:`simulation provenance <../static/program-assets/{name}/metadata/run.json>` or :download:`waveform provenance <../static/program-assets/{name}/metadata/waveform.json>`.
The trace represents regression stimulus at RTL, with timestamped values rather than VHDL delta cycles.
The waveform viewer works offline.

Testbench
---------

Download the :download:`cocotb testbench <../../../programs/{name}/{name}_tb.py>`.
'''
        (pages / f'program-{name}.rst').write_text(page)
    (pages / 'index.rst').write_text('Programs\n========\n\n'
        'Each page combines the authored description with freshly generated netlist and simulation evidence.\n\n'
        '.. toctree::\n   :maxdepth: 1\n\n' + ''.join(f'   program-{name}\n' for name in names))
    return pages


def main():
    try:
        print(generate())
    except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'Program documentation failed: {exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
