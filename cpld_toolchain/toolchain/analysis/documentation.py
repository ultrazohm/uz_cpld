"""Generate program pages from fresh RTL schematics and passing simulations."""
import argparse
from contextlib import contextmanager
from concurrent.futures import ProcessPoolExecutor, as_completed
import multiprocessing
from functools import partial
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys

from cpld_toolchain.toolchain.analysis.netlist import ROOT, export_netlist
from cpld_toolchain.toolchain.analysis.rtl_viewer import write_rtl_viewer
from cpld_toolchain.toolchain.analysis.state_diagram import export_state_diagrams
from cpld_toolchain.toolchain.analysis.waveform import waveform_frame, write_waveform
from cpld_toolchain.toolchain.buildsystem.model import BuildError, discover_programs, load_build, release_cycles, resolve_release, program_targets
from cpld_toolchain.toolchain.buildsystem.workflow import digest, write_json, workspace_lock, locked


def generate(root=ROOT, jobs=4, release_cycle=None, program=None, target=None):
    """Build each program independently, then publish the complete page index."""
    if jobs < 1:
        raise BuildError('jobs must be a positive integer')
    root = Path(root).resolve()
    with documentation_lock(root):
        return _generate(root, jobs, release_cycle, program, target)


@contextmanager
def documentation_lock(root):
    """Protect documentation inputs and outputs through the entire operation."""
    with workspace_lock(root):
        docs = root / 'docs'
        if docs.is_symlink():
            raise BuildError('Documentation directory must not be a symlink')
        docs.mkdir(exist_ok=True)
        with workspace_lock(docs, exclusive=True):
            yield


def build_site(root=ROOT, jobs=4, release_cycle=None, program=None, target=None):
    """Generate, render and validate a site under one documentation lock."""
    from . import sitecheck
    if jobs < 1:
        raise BuildError('jobs must be a positive integer')
    root = Path(root).resolve()
    with documentation_lock(root):
        _generate(root, jobs, release_cycle, program, target)
        output = root / 'docs/_build/html'
        sitecheck.clean(output)
        subprocess.run([sys.executable, '-m', 'sphinx', '-W', '--keep-going',
                        '-b', 'html', 'docs', 'docs/_build/html'],
                       cwd=root, env={**os.environ, 'LC_ALL': 'C.UTF-8'}, check=True)
        print(f'Pages site verified: {sitecheck.check(output)} HTML files')
        return output


def _generate(root, jobs, release_cycle, program=None, target=None):
    cycles = release_cycles(root) if release_cycle == 'all' else [resolve_release(root, release_cycle)]
    names = [f'{cycle}/{name}' for cycle in cycles for name in discover_programs(root, cycle)
             if (program is None or program in (name, f'{cycle}/{name}'))
             and (target is None or target in program_targets(root, name, cycle))]
    if not names and (program is not None or target is not None):
        raise BuildError('No complete programs match the requested program, target and release')
    worker = partial(generate_program, target=target) if target else generate_program
    generated = root / 'docs/_generated'
    if generated.is_symlink():
        raise BuildError('Generated documentation directory must not be a symlink')
    if generated.exists():
        shutil.rmtree(generated)
    pages = generated / 'programs'
    pages.mkdir(parents=True)
    if jobs == 1:
        for name in names:
            worker(root, generated, name)
            print(f'Documentation ready: {name}', flush=True)
    elif names:
        with ProcessPoolExecutor(max_workers=min(jobs, len(names)),
                                 mp_context=multiprocessing.get_context('spawn')) as pool:
            pending = {pool.submit(worker, root, generated, name): name for name in names}
            try:
                for future in as_completed(pending):
                    future.result()
                    print(f'Documentation ready: {pending[future]}', flush=True)
            except Exception:
                for future in pending:
                    future.cancel()
                raise
    index = ('Programs\n========\n\n'
             'Each page combines the authored description with simulation evidence and RTL schematics where supported.\n\n')
    for cycle in cycles:
        index += f'{cycle}\n{"-" * len(cycle)}\n\n'
        description = root / 'programs' / cycle / 'description.rst'
        if description.is_file():
            index += f'.. include:: ../../../programs/{cycle}/description.rst\n\n'
        entries = [name.replace('/', '-') for name in names if name.startswith(cycle + '/')]
        if entries:
            index += '.. toctree::\n   :maxdepth: 1\n\n' + ''.join(f'   program-{name}\n' for name in entries) + '\n'
        else:
            index += 'No complete program manifests in this cycle.\n\n'
    (pages / 'index.rst').write_text(index)
    return pages


def generate_program(root, generated, name, target=None):
    """Run one program's analysis, simulation and page generation in order."""
    pages = generated / 'programs'
    try:
        build = load_build(root, name, target)
        name = build.qualified_name
        page_name = name.replace('/', '-')
        netlist = None if build.netlist_skip_reason else export_netlist(build)
        state_diagrams = export_state_diagrams(build)
        before = {str(p.relative_to(root)): digest(p) for p in (*[s.path for s in build.sources], build.testbench)}
        subprocess.run([sys.executable, '-m', 'pytest', 'cpld_toolchain/toolchain/simulation/test_simulation.py',
                        '--program', build.name, '--target', build.target, '--release-cycle', build.release_cycle, '--wave-format', 'vcd', '--seed', '1', '-q', '-p', 'no:cacheprovider'],
                       cwd=root, check=True, capture_output=True, text=True)
        with locked(build):
            if before != {str(p.relative_to(root)): digest(p) for p in (*[s.path for s in build.sources], build.testbench)}:
                raise BuildError(f'{name}: sources changed while generating documentation')
            if netlist:
                net_inputs = json.loads((netlist / 'metadata/netlist.json').read_text())['inputs']
                if any((before[path] if path in before else digest(root / path)) != value
                       for path, value in net_inputs.items()):
                    raise BuildError(f'{name}: netlist and simulation use different HDL')
            state_info = None
            if state_diagrams:
                state_info = json.loads((state_diagrams / 'metadata/state-diagrams.json').read_text())
                if any(before[path] != value for path, value in state_info['inputs'].items()):
                    raise BuildError(f'{name}: state diagrams and simulation use different HDL')
            simulation = build.build_root / 'simulation'
            run = json.loads((simulation / 'metadata/run.json').read_text())
            info = write_waveform(simulation / 'waves.vcd', simulation / 'waveform.html',
                                  f'{name} — RTL waveform', run['simulation_duration_ns'])
            write_json(simulation / 'metadata/waveform.json', {**info, 'inputs': before,
                       'vcd_sha256': digest(simulation / 'waves.vcd'), 'seed': 1})
            assets = generated / 'static/program-assets' / name
            assets.mkdir(parents=True)
            net_assets = []
            if netlist:
                write_rtl_viewer(netlist / 'netlist.svg', assets / 'netlist-viewer.html',
                                 f'{name} — RTL schematic')
                net_assets = [netlist / 'netlist.svg', netlist / 'netlist.pdf', netlist / 'metadata/netlist.json']
            for src in [*net_assets, simulation / 'waveform.html', simulation / 'waves.vcd',
                        simulation / 'metadata/waveform.json', simulation / 'metadata/run.json']:
                destination = assets / 'metadata' if src.suffix == '.json' else assets
                destination.mkdir(exist_ok=True)
                shutil.copy2(src, destination / src.name)
            state_section = ''
            if state_info:
                shutil.copy2(state_diagrams / 'metadata/state-diagrams.json',
                             assets / 'metadata/state-diagrams.json')
                state_section = ('State diagrams\n--------------\n\n'
                                 'These diagrams show possible state assignments and their conditions extracted from the VHDL. '
                                 'Conditions on ``elsif`` and ``else`` paths include the earlier guards being false. '
                                 'Implicit state holds are omitted.\n\n')
                for diagram in state_info['diagrams']:
                    stem = diagram['stem']
                    for fmt in ('svg', 'pdf'):
                        shutil.copy2(state_diagrams / f'{stem}.{fmt}', assets / f'{stem}.{fmt}')
                    state_section += (f'``{diagram["name"]}`` from ``{diagram["source"]}``\n\n'
                                      f'.. image:: ../static/program-assets/{name}/{stem}.svg\n'
                                      f'   :alt: Possible state transitions for {diagram["name"]}\n'
                                      '   :width: 100%\n\n'
                                      f'Download :download:`SVG <../static/program-assets/{name}/{stem}.svg>` '
                                      f'or :download:`PDF <../static/program-assets/{name}/{stem}.pdf>`.\n\n')
                state_section += (f'Download :download:`state diagram provenance '
                                  f'<../static/program-assets/{name}/metadata/state-diagrams.json>`.\n\n')
            intro = root / 'programs' / name / 'description.rst'
            description = (f'.. include:: ../../../programs/{name}/description.rst\n\n' if intro.is_file()
                           else 'This page is generated from the program manifest, HDL and cocotb testbench.\n\n')
            waveform_embed = waveform_frame(f'../../program-assets/{name}/waveform.html',
                                            f'{name} simulation waveform').replace('\n', '\n      ')
            netlist_section = f'''RTL netlist
-----------

The schematic shows generic RTL before device mapping, placement and routing; see :doc:`/program-documentation` for interpretation and limitations.

Search for a signal or cell, use the mouse wheel to zoom, drag to pan, or open the viewer full screen.

.. only:: html

   .. raw:: html

      <iframe src="../../program-assets/{name}/netlist-viewer.html" title="{name} RTL schematic" style="width:100%;height:720px;border:1px solid #ddd" loading="lazy" allowfullscreen></iframe>

.. only:: not html

   .. image:: ../static/program-assets/{name}/netlist.svg
      :alt: Generic RTL netlist for {name}
      :width: 100%

Open the :download:`standalone RTL viewer <../static/program-assets/{name}/netlist-viewer.html>` or download :download:`SVG <../static/program-assets/{name}/netlist.svg>`, :download:`PDF <../static/program-assets/{name}/netlist.pdf>` or :download:`netlist provenance <../static/program-assets/{name}/metadata/netlist.json>`.

''' if netlist else f'RTL netlist\n-----------\n\n{build.netlist_skip_reason}\n\n'
            page = f'''{name}
{'=' * len(name)}

{description}Target: ``{build.target}``; top entity: ``{build.top}``.

{netlist_section}{state_section}Simulation waveform
-------------------

The passing cocotb regression produces **{info['duration_ns']:g} ns** of simulated time across **{info['signal_count']} signals**.
Choose a preset or filter and select individual signals.
The viewer starts with the full trace; drag to zoom, use Plotly's Reset axes to restore the full trace, and hover to read values.
Unknown and high-impedance values appear at mid-level.

.. only:: html

   .. raw:: html

      {waveform_embed}

Download the :download:`interactive waveform <../static/program-assets/{name}/waveform.html>`, :download:`VCD trace <../static/program-assets/{name}/waves.vcd>`, :download:`simulation provenance <../static/program-assets/{name}/metadata/run.json>` or :download:`waveform provenance <../static/program-assets/{name}/metadata/waveform.json>`.
The trace represents regression stimulus at RTL, with timestamped values rather than VHDL delta cycles.
The waveform viewer works offline.

Testbench
---------

Download the :download:`cocotb testbench <../../../programs/{name}/{build.name}_tb.py>`.
'''
            (pages / f'program-{page_name}.rst').write_text(page)
    except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
        detail = ((exc.stdout or '') + (exc.stderr or '')
                  if isinstance(exc, subprocess.CalledProcessError) else '')
        raise BuildError(f'{name}: {exc}\n{detail or ""}') from exc


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--jobs", type=int, default=4, help="Concurrent programs (default: 4; 1 for sequential)")
    parser.add_argument("--release-cycle", "--release_cycle", dest="release_cycle", help="Release to document; default: current; use all for every release")
    parser.add_argument('--program', help='Limit documentation to one program')
    parser.add_argument('--target', help='Limit documentation to one board target')
    parser.add_argument('--build-site', action='store_true', help='Also render and validate HTML under the same lock')
    args = parser.parse_args()
    try:
        action = build_site if args.build_site else generate
        print(action(jobs=args.jobs, release_cycle=args.release_cycle, program=args.program, target=args.target))
    except (BuildError, OSError, ValueError, subprocess.CalledProcessError) as exc:
        print(f'Program documentation failed: {exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
