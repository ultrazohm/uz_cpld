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


STARTUP_POLICY = 'cpld_toolchain/toolchain/foss/startup-exceptions.json'


def startup_fingerprint(build):
    """Bind waivers to the reviewed sources, proof implementation and tool pins."""
    from ..workflow import hashes
    inputs = hashes(build)
    # The policy contains this digest; including it would make the hash circular.
    inputs.pop(STARTUP_POLICY, None)
    value = {'program': build.qualified_name, 'target': build.target, 'inputs': inputs}
    return hashlib.sha256(json.dumps(value, sort_keys=True).encode()).hexdigest()


def proof_tool_fingerprint(record):
    value = {name: {key: record['executables'][name][key] for key in ('version', 'binary_sha256')}
             for name in ('ghdl', 'yosys')}
    return hashlib.sha256(json.dumps(value, sort_keys=True).encode()).hexdigest()


def enforce_startup_proof(build, proof_record, report):
    """Retain proof evidence and reject counterexamples outside explicit exceptions."""
    rejected = False
    if not proof_record['initial_alignment_proven']:
        policy = json.loads((build.root / STARTUP_POLICY).read_text())
        exception = policy.get(build.qualified_name, {})
        fingerprint = startup_fingerprint(build)
        proof_record['startup_input_fingerprint'] = fingerprint
        if (exception.get('target') == build.target
                and exception.get('input_fingerprint') == fingerprint
                and exception.get('tool_fingerprint')
                and exception['tool_fingerprint'] == proof_record.get('proof_tool_fingerprint')
                and exception.get('outcome') == proof_record['initial_alignment']
                and exception.get('reason')):
            proof_record['startup_exception'] = exception['reason']
            print(f'WARNING: {build.qualified_name}: startup proof exception: {exception["reason"]}', flush=True)
        else:
            rejected = True
            proof_record['result'] = 'failed startup acceptance'
    report.write_text(json.dumps(proof_record, indent=2) + '\n')
    if rejected:
        raise BuildError(f'{build.qualified_name}: unexpected startup proof failure '
                         f'({proof_record["initial_alignment"]}); see {report}. '
                         'Changed exception inputs require review; do not refresh the waiver automatically.')


def suite_root():
    return Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite')).resolve()


def tool(name):
    path = suite_root() / ('native' if name == 'nextpnr-machxo2' else 'bin') / name
    if not path.is_file() or not os.access(path, os.X_OK):
        raise BuildError(f'Missing {path}; rebuild the container or install cpld_toolchain/toolchain/foss/install.py and set FOSS_ROOT')
    return str(path)


def tools(build):
    root = suite_root()
    pin = json.loads((build.root / 'cpld_toolchain/toolchain/foss/toolchain.json').read_text())
    try:
        installed = json.loads((root / 'cpld-toolchain.json').read_text())
    except OSError as exc:
        raise BuildError(f'Missing pinned FOSS installation in {root}; rebuild the container or run cpld_toolchain/toolchain/foss/install.py') from exc
    if installed != pin or pin['release'] != build.expected_version:
        raise BuildError('Installed OSS CAD Suite does not match the target and toolchain pin')
    native_pin = json.loads((build.root / 'cpld_toolchain/toolchain/foss/sources.json').read_text())
    try:
        if json.loads((root / 'native/sources.json').read_text()) != native_pin:
            raise BuildError('Native nextpnr source pin mismatch')
    except OSError as exc:
        raise BuildError('Missing XO2 nextpnr; run cpld_toolchain/toolchain/foss/build_nextpnr.py') from exc
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
            if 'TRACEID' in deferred and deferred['TRACEID'] != words[1]:
                raise BuildError('Conflicting TRACEID settings')
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
                if '=' not in attr or attr.split('=', 1)[0] not in ('IO_TYPE', 'SLEWRATE', 'PULLMODE', 'DRIVE', 'OPENDRAIN'):
                    raise BuildError(f'Unsupported FOSS IOBUF attribute: {attr}')
                if attr.startswith('OPENDRAIN=') and attr != 'OPENDRAIN=ON':
                    raise BuildError('FOSS supports explicit OPENDRAIN=ON; omit it for ordinary outputs')
            lines.append(command.strip() + ';')
        else:
            raise BuildError(f'Unsupported FOSS LPF command: {command.strip()}')
    return '\n'.join(lines) + '\n', deferred, notes


def equivalence_script(build, mapped):
    """Compare mapped logic to RTL, expanding sequential MachXO2 cell models."""
    module = mapped['modules'][build.top]
    cells = module['cells']
    sequential = any(cell['type'] == 'TRELLIS_FF' for cell in cells.values())
    asynchronous = any(cell['type'] == 'TRELLIS_FF' and
                       cell.get('parameters', {}).get('SRMODE') == 'ASYNC' for cell in cells.values())
    oscillators = [(name, cell) for name, cell in cells.items() if cell['type'] == 'OSCH']
    if len(oscillators) > 1:
        raise BuildError('FOSS equivalence supports at most one internal OSCH')
    clock_cut = None
    if oscillators:
        instance, cell = oscillators[0]
        # Flattening can discard the generated *_OSC alias (Rev06 retains clk).
        # All candidates are aliases of the actual oscillator output; prefer
        # its generated name, then the shallowest remaining named wire.
        nets = [name for name, net in module['netnames'].items()
                if net['bits'] == cell['connections']['OSC'] and
                re.fullmatch(r'[A-Za-z_][A-Za-z0-9_.]*', name)]
        if not nets or not all(re.fullmatch(r'[A-Za-z_][A-Za-z0-9_.]*', value)
                               for value in (instance, build.top)):
            raise BuildError('Cannot identify an internal oscillator clock for FOSS equivalence')
        net = min(nets, key=lambda name: (not name.endswith('_OSC'), name.count('.'), name))
        clock_cut = (instance, net)
    if build.foss_equivalence_blacklist and not sequential:
        raise BuildError('FOSS equivalence blacklist requires a sequential mapped design')
    if build.foss_equivalence_blacklist:
        lines = build.foss_equivalence_blacklist.read_text().splitlines()
        if (not lines or len(set(lines)) != len(lines) or
                any(not re.fullmatch(r'[A-Za-z_][A-Za-z0-9_.]*', line) or
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
            commands += [f'connect -assert -port {instance} OSC {net} {build.top}',
                         f'delete {build.top}/c:{instance}',
                         f'add -input __foss_clock 1 {build.top}',
                         f'connect -nounset -set {net} __foss_clock {build.top}']
        if asynchronous:
            # Formal sampling model only. Event-driven netlist simulation keeps
            # the actual asynchronous FFs and checks between-edge safe pulses.
            commands.append('async2sync')
        commands += ['opt_clean', f'rename {build.top} {name}', f'design -stash {name}']
    commands += ['design -copy-from gate -as gate gate',
                 'design -copy-from gold -as gold gold']
    match = 'equiv_make'
    if build.foss_equivalence_blacklist:
        match += ' -blacklist equivalence-blacklist.txt'
    # Keep both flattened copies for a separate initial-state/output miter.
    commands += ['write_json impl/proof-copies.json', match + ' gold gate equiv',
                 'hierarchy -top equiv', 'equiv_simple -undef' if sequential else 'equiv_simple']
    if sequential:
        commands.append('equiv_induct -undef -seq 8')
    commands.append('equiv_status -assert')
    return '\n'.join(commands) + '\n', {
        'method': 'mapped sequential induction' if sequential else 'mapped combinational SAT',
        'undefined_value_modeling': sequential,
        'asynchronous_clock_modeling': ('async2sync: negative hold time assumption' if asynchronous else None),
        'clock_abstraction': dict(zip(('instance', 'net'), clock_cut)) if clock_cut else None,
        'blacklist': (build.foss_equivalence_blacklist.read_text().splitlines()
                      if build.foss_equivalence_blacklist else []),
        'initial_alignment_proven': not sequential,
    }


def startup_script(proof_copies):
    """Check defined RTL outputs from declared initial state for eight cycles.

    Entirely undefined/high-impedance RTL ports cannot be compared as logic.
    They are reported explicitly instead of being silently treated as zeros.
    """
    gold = proof_copies['modules']['gold']['ports']
    gate = proof_copies['modules']['gate']['ports']
    if gold.keys() != gate.keys():
        raise BuildError('Startup proof copies have different top-level ports')
    omitted = []
    for name, port in gold.items():
        if port['direction'] != 'input' and all(bit in ('x', 'z') for bit in port['bits']):
            if not re.fullmatch(r'[A-Za-z_][A-Za-z0-9_]*', name):
                raise BuildError(f'Unsupported startup proof port name: {name}')
            omitted.append(name)
        elif port['direction'] != 'input' and any(bit in ('x', 'z') for bit in port['bits']):
            raise BuildError(f'Partly undefined RTL output needs explicit proof handling: {name}')
    commands = ['read_json impl/proof-copies.json']
    commands += [f'delete -port gold/w:{name} gate/w:{name}' for name in omitted]
    commands += ['miter -equiv -make_assert -flatten gold gate startup',
                 'hierarchy -top startup', 'sat -seq 8 -prove-asserts -verify']
    return '\n'.join(commands) + '\n', omitted


def startup_points_script(omitted, blacklisted):
    """Check every retained induction match point from the initial state."""
    commands = ['read_json impl/proof-copies.json']
    commands += [f'delete -port gold/w:{name} gate/w:{name}' for name in omitted]
    match = 'equiv_make -make_assert'
    if blacklisted:
        match += ' -blacklist equivalence-blacklist.txt'
    commands += [match + ' gold gate startup_points', 'hierarchy -top startup_points',
                 'flatten -wb', 'sat -seq 8 -prove-asserts -verify']
    return '\n'.join(commands) + '\n'


def normalize_oscillator_frequency(module, expected):
    """Convert GHDL's packed ASCII generic to nextpnr's string parameter."""
    for cell in module['cells'].values():
        if cell['type'] != 'OSCH':
            continue
        # An omitted generic uses the OSCH 2.08 MHz default in the XO2 cell
        # declaration, including historical HDL with translate_off generics.
        bits = cell['parameters'].get('NOM_FREQ', ''.join(f'{byte:08b}' for byte in b'2.08'))
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
        from ..identity import constraint_text, validate_identity
        identity = validate_identity(build, json.loads((metadata / 'identity.json').read_text()))
        lpf, deferred, notes = constraints(constraint_text(build, identity))
        from ..foss_config import validate_s3c_banks
        validate_s3c_banks(deferred, build.device)
        if 'TRACEID' in deferred:
            notes.append('TRACEID is retained as provenance only; Trellis does not encode Diamond TRACEID.')
        (project / 'constraints.lpf').write_text(lpf)
        primitive = build.root / 'cpld_toolchain/toolchain/hdl/machxo2_primitives.v'
        (project / 'synth.ys').write_text('\n'.join([
            f'read_verilog -lib {json.dumps(str(primitive))}',
            'read_verilog rtl.v', f'hierarchy -check -top {build.top}',
            f'synth_lattice -family xo2 -top {build.top} -json ../metadata/reports/synth.json',
            'check', 'stat']) + '\n')
        plan = {'root': str(build.root), 'program': build.name, 'release_cycle': build.release_cycle, 'target': build.target,
                'device': build.device, 'top': build.top, 'standard': build.standard,
                'sources': [str(s.path) for s in build.sources], 'seed': build.options['seed'],
                'deferred': deferred, 'constraint_notes': notes}
        (project.parent / 'metadata/build-plan.json').write_text(json.dumps(plan, indent=2) + '\n')
        log.write_text('Prepared FOSS synthesis and place-and-route plan\n')

    def build(self, project, log):
        from ..model import load_build
        plan = json.loads((project.parent / 'metadata/build-plan.json').read_text())
        build = load_build(Path(plan['root']), plan['program'], plan['target'], 'foss', plan['release_cycle'])
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
        shutil.copy2(project / 'rtl.v', project / 'impl/reference.v')
        mapped = json.loads((project.parent / 'metadata/reports/synth.json').read_text())
        proof, proof_record = equivalence_script(build, mapped)
        proof_record['proof_tool_fingerprint'] = proof_tool_fingerprint(record)
        (project / 'equivalence.ys').write_text(proof)
        if build.foss_equivalence_blacklist:
            shutil.copy2(build.foss_equivalence_blacklist, project / 'equivalence-blacklist.txt')
        run([tool('yosys'), '-l', 'impl/equivalence.log', '-s', 'equivalence.ys'])
        proof_record['result'] = 'proven'
        if proof_record['method'] == 'mapped sequential induction':
            copies = json.loads((project / 'impl/proof-copies.json').read_text())
            startup, omitted = startup_script(copies)
            (project / 'startup.ys').write_text(startup)
            proof_record['undefined_rtl_outputs'] = omitted
            startup_log = project / 'impl/startup.log'
            with log.open('a') as stream:
                stream.write('$ yosys -l impl/startup.log -s startup.ys\n')
                stream.flush()
                result = subprocess.run([tool('yosys'), '-l', 'impl/startup.log', '-s', 'startup.ys'],
                                        cwd=project, stdout=stream, stderr=stream)
            if result.returncode:
                if 'ERROR: Called with -verify and proof did fail!' not in startup_log.read_text():
                    raise BuildError(f'Startup proof tool failed; see {startup_log}')
                proof_record['initial_alignment'] = 'output counterexample'
            else:
                (project / 'startup-points.ys').write_text(
                    startup_points_script(omitted, bool(build.foss_equivalence_blacklist)))
                points_log = project / 'impl/startup-points.log'
                with log.open('a') as stream:
                    stream.write('$ yosys -l impl/startup-points.log -s startup-points.ys\n')
                    stream.flush()
                    points_result = subprocess.run([tool('yosys'), '-l', 'impl/startup-points.log',
                                                    '-s', 'startup-points.ys'], cwd=project,
                                                   stdout=stream, stderr=stream)
                if points_result.returncode:
                    if 'ERROR: Called with -verify and proof did fail!' not in points_log.read_text():
                        raise BuildError(f'Initial match-point proof tool failed; see {points_log}')
                    proof_record['initial_alignment'] = 'internal match-point counterexample'
                else:
                    proof_record['initial_alignment'] = 'all retained match points proven for eight cycles'
                    proof_record['initial_alignment_proven'] = True
        else:
            proof_record['initial_alignment'] = 'not applicable: combinational design'
        enforce_startup_proof(build, proof_record, project.parent / 'metadata/reports/equivalence.json')
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
        from ..foss_config import complete_config, verify_open_drain
        complete_config(project / 'impl/routed.config', plan['deferred'], suite_root(), build.device,
                        pin_report['open_drain'])
        # MachXO2's internal-flash bitstream path requires compressed framing.
        pack = [tool('ecppack'), 'impl/routed.config', 'impl/firmware_impl.bit', '--compress']
        if 'USERCODE' in plan['deferred']:
            pack += ['--usercode', str(int(plan['deferred']['USERCODE'], 16))]
        run(pack)
        run([tool('ecpunpack'), 'impl/firmware_impl.bit', 'impl/unpacked.config'])
        pin_report['open_drain_verification'] = verify_open_drain(
            project / 'impl/unpacked.config', pin_report['open_drain'], suite_root())
        (project.parent / 'metadata/reports/constraints.json').write_text(json.dumps({
            'deferred_settings': plan['deferred'], 'notes': plan['constraint_notes'], 'package': pin_report,
            'lpf': (project / 'routed.lpf').read_text()}, indent=2) + '\n')
        # GHDL diagnostics can quote preserved Latin-1 vendor source lines.
        return log.read_text(errors='replace')
