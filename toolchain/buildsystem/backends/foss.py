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
        raise BuildError('Missing XO2 nextpnr; run toolchain/foss/build_nextpnr.py') from exc
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
    require_device(build)
    return json.dumps(record, indent=2)


def require_device(build):
    """Fail before synthesis when the pinned native build lacks this target."""
    result = subprocess.run([tool('nextpnr-machxo2'), '--list-devices'], capture_output=True, text=True)
    if result.returncode or build.device not in result.stdout + result.stderr:
        raise BuildError(f'nextpnr does not list target device {build.device}; rebuild the toolchain image or install a fresh FOSS prefix')


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
                if key not in ('SDM_PORT', 'SLAVE_SPI_PORT', 'I2C_PORT', 'MCCLK_FREQ'):
                    raise BuildError(f'Unsupported FOSS SYSCONFIG setting: {word}')
                if key in deferred and deferred[key] != value:
                    raise BuildError(f'Conflicting SYSCONFIG setting: {key}')
                deferred[key] = value
        elif words[0] == 'LOCATE' and len(words) == 5 and words[1] == 'COMP' and words[3] == 'SITE':
            lines.append(command.strip() + ';')
        elif words[0] == 'BANK' and len(words) == 5 and words[1].isdigit() and words[2] == 'VCCIO' and words[4] == 'V':
            key = 'BANK_' + words[1]
            if key in deferred and deferred[key] != words[3]:
                raise BuildError(f'Conflicting BANK setting: {words[1]}')
            deferred[key] = words[3]
        elif (words[0] == 'USERCODE' and len(words) == 3 and
              ((words[1] == 'HEX' and re.fullmatch(r'[0-9A-Fa-f]{8}', words[2])) or
               (words[1] == 'BIN' and re.fullmatch(r'[01]{32}', words[2])))):
            value = words[2].upper() if words[1] == 'HEX' else f'{int(words[2], 2):08X}'
            if 'USERCODE' in deferred and deferred['USERCODE'] != value:
                raise BuildError('Conflicting USERCODE settings')
            deferred['USERCODE'] = value
        elif words[0] == 'IOBUF' and len(words) >= 4 and words[1] == 'PORT':
            for attr in words[3:]:
                if '=' not in attr or attr.split('=', 1)[0] not in ('IO_TYPE', 'SLEWRATE', 'PULLMODE', 'DRIVE'):
                    raise BuildError(f'Unsupported FOSS IOBUF attribute: {attr}')
            lines.append(command.strip() + ';')
        else:
            raise BuildError(f'Unsupported FOSS LPF command: {command.strip()}')
    return '\n'.join(lines) + '\n', deferred, notes


def equivalence_script(build, mapped):
    """Compare mapped logic to RTL, expanding sequential MachXO2 cell models."""
    module = mapped['modules'][build.top]
    cells = module['cells']
    sequential = any(cell['type'] == 'TRELLIS_FF' for cell in cells.values())
    oscillators = [(name, cell) for name, cell in cells.items() if cell['type'] == 'OSCH']
    if len(oscillators) > 1:
        raise BuildError('FOSS equivalence supports at most one internal OSCH')
    clock_cut = None
    if oscillators:
        instance, cell = oscillators[0]
        nets = [name for name, net in module['netnames'].items()
                if name.endswith('_OSC') and net['bits'] == cell['connections']['OSC']]
        if len(nets) != 1 or not all(re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*', value)
                                      for value in (instance, nets[0], build.top)):
            raise BuildError('Cannot identify a unique internal oscillator clock for FOSS equivalence')
        clock_cut = (instance, nets[0])
    if build.foss_equivalence_blacklist and not sequential:
        raise BuildError('FOSS equivalence blacklist requires a sequential mapped design')
    if build.foss_equivalence_blacklist:
        lines = build.foss_equivalence_blacklist.read_text().splitlines()
        if (not lines or len(set(lines)) != len(lines) or
                any(not re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*', line) or
                    line not in module['netnames'] or line in module['ports'] for line in lines)):
            raise BuildError('FOSS equivalence blacklist must contain distinct mapped internal signal names')
    commands = ['read_json ../metadata/reports/synth.json']
    if sequential:
        # Parameterized mapping cells in synth.json are blackboxes; derive their
        # functional models from cells_sim_xo2.v for the proof copy only.
        commands.append('delete =*TRELLIS_FF* =*CCU2D*')
    commands += ['read_verilog -overwrite +/lattice/cells_sim_xo2.v']
    for name, start in (('gate', None), ('gold', 'read_verilog rtl.v')):
        if start:
            commands.append(start)
        commands += [f'hierarchy -top {build.top}', 'proc',
                     'flatten -wb' if sequential else 'flatten']
        if clock_cut:
            instance, net = clock_cut
            # Both proof copies receive the same arbitrary clock. The real
            # oscillator remains present in the synthesized firmware netlist.
            commands += [f'expose -input {build.top}/w:{net}',
                         f'delete {build.top}/c:{instance}']
        commands += ['opt_clean', f'rename {build.top} {name}', f'design -stash {name}']
    commands += ['design -copy-from gate -as gate gate',
                 'design -copy-from gold -as gold gold']
    match = 'equiv_make'
    if build.foss_equivalence_blacklist:
        match += ' -blacklist equivalence-blacklist.txt'
    commands += [match + ' gold gate equiv', 'hierarchy -top equiv', 'equiv_simple']
    if sequential:
        commands.append('equiv_induct -seq 8')
    commands.append('equiv_status -assert')
    return '\n'.join(commands) + '\n', {
        'method': 'mapped sequential induction' if sequential else 'mapped combinational SAT',
        'clock_abstraction': dict(zip(('instance', 'net'), clock_cut)) if clock_cut else None,
        'blacklist': (build.foss_equivalence_blacklist.read_text().splitlines()
                      if build.foss_equivalence_blacklist else []),
        'initial_alignment_proven': not sequential,
    }


def normalize_oscillator_frequency(module, expected):
    """Convert GHDL's packed ASCII generic to nextpnr's string parameter."""
    for cell in module['cells'].values():
        if cell['type'] != 'OSCH':
            continue
        bits = cell['parameters'].get('NOM_FREQ')
        if not isinstance(bits, str) or len(bits) % 8 or re.fullmatch(r'[01]+', bits) is None:
            raise BuildError('Unsupported OSCH NOM_FREQ encoding in mapped netlist')
        try:
            frequency = bytes(int(bits[i:i + 8], 2) for i in range(0, len(bits), 8)).decode('ascii')
        except UnicodeDecodeError as exc:
            raise BuildError('OSCH NOM_FREQ is not ASCII') from exc
        if re.fullmatch(r'\d+\.\d+', frequency) is None:
            raise BuildError(f'Unsupported OSCH NOM_FREQ: {frequency!r}')
        if expected not in (None, frequency):
            raise BuildError('OSCH NOM_FREQ conflicts with LPF MCCLK_FREQ')
        cell['parameters']['NOM_FREQ'] = frequency


class FossBackend:
    def prepare(self, build, project, log):
        tools(build)
        require_device(build)
        project.mkdir(parents=True)
        (project / 'impl').mkdir()
        metadata = project.parent / 'metadata'
        (metadata / 'reports').mkdir(parents=True, exist_ok=True)
        lpf, deferred, notes = constraints(build.constraint.read_text())
        from ..foss_config import validate_s3c_banks
        validate_s3c_banks(deferred, build.device)
        if 'TRACEID' in deferred:
            notes.append('TRACEID is retained as provenance only; Trellis does not encode Diamond TRACEID.')
        (project / 'constraints.lpf').write_text(lpf)
        primitive = build.root / 'toolchain/hdl/machxo2_primitives.v'
        (project / 'synth.ys').write_text('\n'.join([
            f'read_verilog -lib "{primitive}"',
            'read_verilog rtl.v', f'hierarchy -check -top {build.top}',
            f'synth_lattice -family xo2 -top {build.top} -json ../metadata/reports/synth.json',
            'check', 'stat']) + '\n')
        plan = {'root': str(build.root), 'program': build.name, 'target': build.target,
                'device': build.device, 'top': build.top, 'standard': build.standard,
                'sources': [str(s.path) for s in build.sources], 'seed': build.options['seed'],
                'deferred': deferred, 'constraint_notes': notes}
        (project.parent / 'metadata/build-plan.json').write_text(json.dumps(plan, indent=2) + '\n')
        log.write_text('Prepared FOSS synthesis and place-and-route plan\n')

    def build(self, project, log):
        from ..model import load_build
        plan = json.loads((project.parent / 'metadata/build-plan.json').read_text())
        build = load_build(Path(plan['root']), plan['program'], plan['target'], 'foss')
        record = tools(build)
        (project.parent / 'metadata/reports/tools.json').write_text(json.dumps(record, indent=2) + '\n')
        def run(argv, stdout=None):
            with log.open('a') as stream:
                stream.write('$ ' + shlex.join(argv) + '\n')
                stream.flush()
                result = subprocess.run(argv, cwd=project, stdout=stdout or stream, stderr=stream)
            if result.returncode:
                raise BuildError(f'FOSS tool failed ({result.returncode}): {argv[0]}; see {log}')
        standard = {'1993': '93', '2008': '08'}[plan['standard']]
        from ..ghdl import analyze_sources
        with log.open('a') as stream:
            library_args = analyze_sources(build.root, build.sources, project, standard, log=stream)
        with (project / 'rtl.v').open('w') as rtl:
            run([record['executables']['ghdl']['path'], '--synth', f'--std={standard}', *library_args, '--out=verilog',
                 plan['top']], stdout=rtl)
        run([tool('yosys'), '-s', 'synth.ys'])
        mapped = json.loads((project.parent / 'metadata/reports/synth.json').read_text())
        proof, proof_record = equivalence_script(build, mapped)
        (project / 'equivalence.ys').write_text(proof)
        if build.foss_equivalence_blacklist:
            shutil.copy2(build.foss_equivalence_blacklist, project / 'equivalence-blacklist.txt')
        run([tool('yosys'), '-l', 'impl/equivalence.log', '-s', 'equivalence.ys'])
        proof_record['result'] = 'proven'
        (project.parent / 'metadata/reports/equivalence.json').write_text(json.dumps(proof_record, indent=2) + '\n')
        from ..foss_config import package_lpf
        netlist = mapped
        module = netlist['modules'][plan['top']]
        used = {bit for cell in module['cells'].values() for bits in cell['connections'].values() for bit in bits}
        used.update(bit for port in module['ports'].values() if port['direction'] != 'input' for bit in port['bits'])
        unused = [name for name, port in module['ports'].items()
                  if port['direction'] == 'input' and not any(bit in used for bit in port['bits'])]
        for name in unused:
            del module['ports'][name]
        normalize_oscillator_frequency(module, plan['deferred'].get('MCCLK_FREQ'))
        (project.parent / 'metadata/reports/pnr-input.json').write_text(json.dumps(netlist))
        lpf, pin_report = package_lpf((project / 'constraints.lpf').read_text(),
                                      netlist['modules'][plan['top']]['ports'], suite_root(), build.device,
                                      plan['deferred'])
        pin_report['unused_inputs_removed'] = unused
        (project / 'routed.lpf').write_text(lpf)
        run([tool('nextpnr-machxo2'), '--device', plan['device'], '--json', '../metadata/reports/pnr-input.json',
             '--lpf', 'routed.lpf', '--seed', str(plan['seed']), '--textcfg', 'impl/routed.config',
             '--write', '../metadata/reports/routed.json', '--report', '../metadata/reports/timing.json'])
        # Device-specific configuration is completed before packing, never dropped.
        from ..foss_config import complete_config
        complete_config(project / 'impl/routed.config', plan['deferred'], suite_root(), build.device)
        pack = [tool('ecppack'), 'impl/routed.config', 'impl/firmware_impl.bit']
        if 'USERCODE' in plan['deferred']:
            pack += ['--usercode', str(int(plan['deferred']['USERCODE'], 16))]
        run(pack)
        run([tool('ecpunpack'), 'impl/firmware_impl.bit', 'impl/unpacked.config'])
        (project.parent / 'metadata/reports/constraints.json').write_text(json.dumps({
            'deferred_settings': plan['deferred'], 'notes': plan['constraint_notes'], 'package': pin_report,
            'lpf': (project / 'routed.lpf').read_text()}, indent=2) + '\n')
        return log.read_text()
