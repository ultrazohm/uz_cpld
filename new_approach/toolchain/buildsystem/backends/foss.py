"""GHDL, Yosys, nextpnr-machxo2 and Project Trellis firmware backend."""
import hashlib
import json
import os
from pathlib import Path
import re
import shlex
import shutil
import subprocess

from ..model import BuildError


def suite_root():
    return Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite')).resolve()


def tool(name):
    path = suite_root() / ('native' if name == 'nextpnr-machxo2' else 'bin') / name
    if not path.is_file() or not os.access(path, os.X_OK):
        raise BuildError(f'Missing {path}; rebuild the container or install toolchain/foss/install.py and set FOSS_ROOT')
    return str(path)


def tools(build):
    root = suite_root()
    pin = json.loads((build.root / 'toolchain/foss/toolchain.json').read_text())
    try:
        installed = json.loads((root / 'cpld-toolchain.json').read_text())
    except OSError as exc:
        raise BuildError(f'Missing pinned FOSS installation in {root}; rebuild the container or run toolchain/foss/install.py') from exc
    if installed != pin or pin['release'] != build.expected_version:
        raise BuildError('Installed OSS CAD Suite does not match the target and toolchain pin')
    native_pin = json.loads((build.root / 'toolchain/foss/sources.json').read_text())
    try:
        if json.loads((root / 'native/sources.json').read_text()) != native_pin:
            raise BuildError('Native nextpnr source pin mismatch')
    except OSError as exc:
        raise BuildError('Missing XO2-2000 nextpnr; run toolchain/foss/build_nextpnr.py') from exc
    ghdl = shutil.which('ghdl')
    if not ghdl:
        raise BuildError('GHDL is missing; rebuild the toolchain container')
    commands = {'ghdl': [ghdl, '--version'], 'yosys': [tool('yosys'), '-V'],
                'nextpnr': [tool('nextpnr-machxo2'), '--version'],
                'trellis': [tool('ecppack'), '--version'],
                'openFPGALoader': [tool('openFPGALoader'), '--Version']}
    record = {'suite': pin, 'native_sources': native_pin, 'executables': {}}
    for name, argv in commands.items():
        result = subprocess.run(argv, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
        if result.returncode:
            raise BuildError(f'{name} startup failed: {result.stdout.strip()}')
        binary = root / 'libexec' / Path(argv[0]).name
        if name == 'nextpnr' and native_pin['nextpnr']['revision'] not in result.stdout:
            raise BuildError('Native nextpnr binary does not report its pinned revision')
        record['executables'][name] = {
            'path': argv[0], 'version': result.stdout.strip(),
            'sha256': hashlib.sha256(Path(argv[0]).read_bytes()).hexdigest(),
            'binary_sha256': hashlib.sha256((binary if name not in ('ghdl', 'nextpnr') and binary.is_file() else Path(argv[0])).read_bytes()).hexdigest()}
    return record


def doctor(build):
    record = tools(build)
    result = subprocess.run([tool('nextpnr-machxo2'), '--list-devices'], capture_output=True, text=True)
    if result.returncode or build.device not in result.stdout + result.stderr:
        raise BuildError(f'nextpnr does not list target device {build.device}')
    return json.dumps(record, indent=2)


def constraints(text):
    """Parse the supported LPF subset, retaining explicit deferred settings."""
    lines, deferred, notes = [], {}, []
    # Reject constructs whose interpretation could differ from the vendor LPF.
    text = '\n'.join(line.split('//', 1)[0].split('#', 1)[0] for line in text.splitlines())
    commands = text.split(';')
    if commands[-1].strip():
        raise BuildError('LPF must terminate each command with a semicolon')
    for command in commands[:-1]:
        words = shlex.split(command)
        if not words:
            continue
        if words[0] == 'BLOCK' and words[1:] in (['RESETPATHS'], ['ASYNCPATHS']):
            notes.append('Timing exclusion recorded without a timing acceptance claim: ' + ' '.join(words))
        elif words[0] == 'TRACEID' and len(words) == 2 and re.fullmatch(r'[01]{8}', words[1]):
            deferred['TRACEID'] = words[1]
        elif words[0] == 'SYSCONFIG':
            for word in words[1:]:
                if '=' not in word:
                    raise BuildError(f'Invalid LPF SYSCONFIG: {word}')
                key, value = word.split('=', 1)
                if key not in ('SDM_PORT', 'SLAVE_SPI_PORT', 'MCCLK_FREQ'):
                    raise BuildError(f'Unsupported FOSS SYSCONFIG setting: {word}')
                if key in deferred and deferred[key] != value:
                    raise BuildError(f'Conflicting SYSCONFIG setting: {key}')
                deferred[key] = value
        elif words[0] == 'LOCATE' and len(words) == 5 and words[1] == 'COMP' and words[3] == 'SITE':
            lines.append(command.strip() + ';')
        elif words[0] == 'IOBUF' and len(words) >= 4 and words[1] == 'PORT':
            for attr in words[3:]:
                if '=' not in attr or attr.split('=', 1)[0] not in ('IO_TYPE', 'SLEWRATE', 'PULLMODE', 'DRIVE'):
                    raise BuildError(f'Unsupported FOSS IOBUF attribute: {attr}')
            lines.append(command.strip() + ';')
        else:
            raise BuildError(f'Unsupported FOSS LPF command: {command.strip()}')
    return '\n'.join(lines) + '\n', deferred, notes


class FossBackend:
    def prepare(self, build, project, log):
        if any(s.library.lower() != 'work' for s in build.sources):
            raise BuildError('FOSS synthesis currently supports only work-library sources')
        tools(build)
        project.mkdir(parents=True)
        (project / 'impl').mkdir()
        lpf, deferred, notes = constraints(build.constraint.read_text())
        if 'TRACEID' in deferred:
            notes.append('TRACEID is retained as provenance only; Trellis does not encode Diamond TRACEID.')
        (project / 'constraints.lpf').write_text(lpf)
        (project / 'synth.ys').write_text('\n'.join([
            'read_verilog rtl.v', f'hierarchy -check -top {build.top}',
            f'synth_lattice -family xo2 -top {build.top} -json impl/synth.json',
            'check', 'stat']) + '\n')
        (project / 'equivalence.ys').write_text('\n'.join([
            'read_json impl/synth.json', 'read_verilog -overwrite +/lattice/cells_sim_xo2.v',
            f'hierarchy -top {build.top}', 'proc', 'flatten', 'opt_clean',
            f'rename {build.top} gate', 'design -stash gate',
            'read_verilog rtl.v', f'hierarchy -top {build.top}', 'proc', 'flatten', 'opt_clean',
            f'rename {build.top} gold', 'design -stash gold',
            'design -copy-from gate -as gate gate', 'design -copy-from gold -as gold gold',
            'equiv_make gold gate equiv', 'hierarchy -top equiv', 'equiv_simple',
            'equiv_status -assert']) + '\n')
        plan = {'root': str(build.root), 'program': build.name, 'target': build.target,
                'device': build.device, 'top': build.top, 'standard': build.standard,
                'sources': [str(s.path) for s in build.sources], 'seed': build.options['seed'],
                'deferred': deferred, 'constraint_notes': notes}
        (project / 'build-plan.json').write_text(json.dumps(plan, indent=2) + '\n')
        log.write_text('Prepared FOSS synthesis and place-and-route plan\n')

    def build(self, project, log):
        from ..model import load_build
        plan = json.loads((project / 'build-plan.json').read_text())
        build = load_build(Path(plan['root']), plan['program'], plan['target'], 'foss')
        record = tools(build)
        (project / 'impl/tools.json').write_text(json.dumps(record, indent=2) + '\n')
        def run(argv, stdout=None):
            with log.open('a') as stream:
                stream.write('$ ' + shlex.join(argv) + '\n')
                stream.flush()
                result = subprocess.run(argv, cwd=project, stdout=stdout or stream, stderr=stream)
            if result.returncode:
                raise BuildError(f'FOSS tool failed ({result.returncode}): {argv[0]}; see {log}')
        standard = {'1993': '93', '2008': '08'}[plan['standard']]
        with (project / 'rtl.v').open('w') as rtl:
            run([record['executables']['ghdl']['path'], '--synth', f'--std={standard}', '--out=verilog',
                 *plan['sources'], '-e', plan['top']], stdout=rtl)
        run([tool('yosys'), '-s', 'synth.ys'])
        run([tool('yosys'), '-l', 'impl/equivalence.log', '-s', 'equivalence.ys'])
        from ..foss_config import package_lpf
        netlist = json.loads((project / 'impl/synth.json').read_text())
        module = netlist['modules'][plan['top']]
        used = {bit for cell in module['cells'].values() for bits in cell['connections'].values() for bit in bits}
        used.update(bit for port in module['ports'].values() if port['direction'] != 'input' for bit in port['bits'])
        unused = [name for name, port in module['ports'].items()
                  if port['direction'] == 'input' and not any(bit in used for bit in port['bits'])]
        for name in unused:
            del module['ports'][name]
        (project / 'impl/pnr-input.json').write_text(json.dumps(netlist))
        lpf, pin_report = package_lpf((project / 'constraints.lpf').read_text(),
                                      netlist['modules'][plan['top']]['ports'], suite_root())
        pin_report['unused_inputs_removed'] = unused
        (project / 'routed.lpf').write_text(lpf)
        run([tool('nextpnr-machxo2'), '--device', plan['device'], '--json', 'impl/pnr-input.json',
             '--lpf', 'routed.lpf', '--seed', str(plan['seed']), '--textcfg', 'impl/routed.config',
             '--write', 'impl/routed.json', '--report', 'impl/timing.json'])
        # Device-specific configuration is completed before packing, never dropped.
        from ..foss_config import complete_config
        complete_config(project / 'impl/routed.config', plan['deferred'], suite_root())
        run([tool('ecppack'), 'impl/routed.config', 'impl/firmware_impl.bit'])
        run([tool('ecpunpack'), 'impl/firmware_impl.bit', 'impl/unpacked.config'])
        (project / 'impl/constraints.json').write_text(json.dumps({
            'deferred_settings': plan['deferred'], 'notes': plan['constraint_notes'], 'package': pin_report,
            'lpf': (project / 'routed.lpf').read_text()}, indent=2) + '\n')
        return log.read_text()
