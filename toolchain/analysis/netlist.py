"""Export generic RTL schematics with GHDL, Yosys and Graphviz, without Diamond."""
import argparse
from pathlib import Path
import shutil
import subprocess
import sys

from toolchain.buildsystem.model import BuildError, catalog, load_build
from toolchain.buildsystem.workflow import digest, locked, safe_directory, write_json

ROOT = Path(__file__).resolve().parents[2]


def export_netlist(build):
    """Generate fresh SVG/PDF schematics and retain intermediate files and logs."""
    with locked(build):
        return _export_netlist(build)


def _export_netlist(build):
    output = safe_directory(build, build.build_root / 'netlist')
    if output.exists():
        shutil.rmtree(output)
    output.mkdir(parents=True)
    (output / 'metadata').mkdir()
    inputs = {str(s.path.relative_to(build.root)): digest(s.path) for s in build.sources}
    primitive = build.root / 'toolchain/hdl/machxo2_primitives.v'
    inputs[str(primitive.relative_to(build.root))] = digest(primitive)
    try:
        for tool in ('ghdl', 'yosys', 'dot'):
            if not shutil.which(tool):
                raise BuildError(f'{tool} is missing; rebuild the toolchain container')
        if any(s.library.lower() != 'work' for s in build.sources):
            raise BuildError('Netlist analysis currently supports only work-library sources')
        standard = {'1993': '93', '2008': '08'}[build.standard]
        from toolchain.buildsystem.ghdl import machxo2_library
        library_args = machxo2_library(build.root, build.sources, output, standard)
        # Use argv for source paths; Yosys sees fixed local filenames only.
        with (output / 'rtl.v').open('w') as net, (output / 'ghdl.log').open('w') as log:
            subprocess.run(['ghdl', '--synth', f'--std={standard}', *library_args, '--out=verilog',
                            *(str(s.path) for s in build.sources), '-e', build.top],
                           cwd=output, stdout=net, stderr=log, check=True)
        script = '\n'.join([f'read_verilog -lib "{primitive}"',
                            'read_verilog rtl.v', f'hierarchy -check -top {build.top}',
                            'proc', 'flatten', 'opt_clean',
                            'write_json metadata/rtl.json', f'show -format dot -prefix netlist {build.top}'])
        (output / 'netlist.ys').write_text(script + '\n')
        with (output / 'yosys.log').open('w') as log:
            subprocess.run(['yosys', '-s', 'netlist.ys'], cwd=output,
                           stdout=log, stderr=subprocess.STDOUT, check=True)
        with (output / 'graphviz.log').open('w') as log:
            for fmt in ('svg', 'pdf'):
                subprocess.run(['dot', f'-T{fmt}', 'netlist.dot', '-o', f'netlist.{fmt}'],
                               cwd=output, stdout=log, stderr=subprocess.STDOUT, check=True)
                if not (output / f'netlist.{fmt}').stat().st_size:
                    raise BuildError(f'Empty {fmt} export')
        current_inputs = {str(s.path.relative_to(build.root)): digest(s.path) for s in build.sources}
        current_inputs[str(primitive.relative_to(build.root))] = digest(primitive)
        if inputs != current_inputs:
            raise BuildError('Netlist inputs changed during export')
        versions = {name: subprocess.check_output(args, stderr=subprocess.STDOUT, text=True).splitlines()[0]
                    for name, args in [('ghdl', ['ghdl', '--version']),
                                       ('yosys', ['yosys', '-V']), ('graphviz', ['dot', '-V'])]}
        write_json(output / 'metadata/netlist.json', {
            'program': build.name, 'top': build.top, 'standard': build.standard,
            'stage': 'generic RTL: GHDL synthesis; Yosys proc, flatten, opt_clean',
            'limitations': 'No Diamond mapping, LPF application, placement, routing or timing analysis.',
            'inputs': inputs, 'tools': versions,
            'outputs': {f'netlist.{fmt}': digest(output / f'netlist.{fmt}') for fmt in ('svg', 'pdf')},
        })
        return output
    except Exception as exc:
        for filename in ('netlist.svg', 'netlist.pdf'):
            (output / filename).unlink(missing_ok=True)
        (output / 'metadata/netlist.json').unlink(missing_ok=True)
        raise BuildError(f'Netlist export failed for {build.name}; see {output}: {exc}') from exc


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--program')
    parser.add_argument('--target')
    args = parser.parse_args()
    try:
        for name in [args.program] if args.program else catalog(ROOT):
            if args.target is None:
                print(export_netlist(load_build(ROOT, name)))
            else:
                from toolchain.buildsystem.model import program_targets
                if args.target in program_targets(ROOT, name):
                    print(export_netlist(load_build(ROOT, name, args.target)))
    except (BuildError, OSError, ValueError) as exc:
        print(exc, file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
