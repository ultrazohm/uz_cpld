"""Reproducible functional comparison of the cvg_tx30 pilot netlists.

This command consumes fresh, hashed firmware artifacts. It never programs hardware
and does not interpret a simulation pass as timing or board qualification.
"""
from contextlib import ExitStack
import json
from pathlib import Path
import subprocess
import shutil

from .backends.foss import suite_root, tool
from .model import BuildError, load_build
from .workflow import digest, locked, safe_directory, write_json


def run(argv, directory, log):
    with log.open('w') as stream:
        result = subprocess.run(argv, cwd=directory, stdout=stream,
                                stderr=subprocess.STDOUT, timeout=180)
    if result.returncode:
        raise BuildError(f'Comparison tool failed; see {log}')


def normalize(source, top, destination, root, *, mapped=False):
    """Expand functional cell models and replace exactly one OSCH by an input.

    Keep native event-driven FF semantics for simulation. Formal conversion is
    performed on separate copies. Unsupported primitives fail hierarchy checking.
    """
    destination.mkdir(parents=True, exist_ok=True)
    primitive = root / 'toolchain/hdl/machxo2_primitives.v'
    commands = [] if mapped else [f'read_verilog -lib {json.dumps(str(primitive))}']
    if mapped:
        commands += [f'read_json {json.dumps(str(source))}',
                     'delete =*TRELLIS_FF* =*CCU2D*']
    commands += [f'read_verilog -lib -overwrite {json.dumps(str(primitive))}',
                 'read_verilog -overwrite +/lattice/cells_sim_xo2.v']
    if not mapped:
        commands += [f'read_verilog {json.dumps(str(source))}']
    commands += [f'hierarchy -check -top {top}', 'proc', 'flatten -wb',
                 'opt_clean', 'write_json expanded.json']
    script = destination / 'expand.ys'
    script.write_text('\n'.join(commands) + '\n')
    run([tool('yosys'), '-s', script.name], destination, destination / 'expand.log')
    design = json.loads((destination / 'expanded.json').read_text())
    module = design['modules'][top]
    clocks = [(name, cell) for name, cell in module['cells'].items() if cell['type'] == 'OSCH']
    if len(clocks) != 1:
        raise BuildError('Comparison requires exactly one internal OSCH')
    name, oscillator = clocks[0]
    if oscillator['connections']['STDBY'] != ['0']:
        raise BuildError('Comparison requires OSCH STDBY tied low')
    clock = oscillator['connections']['OSC']
    if '__comparison_clock' in module['ports']:
        raise BuildError('Reserved comparison clock port already exists')
    del module['cells'][name]
    module['ports']['__comparison_clock'] = {'direction': 'input', 'bits': clock}
    # SEDSTDBY is unused in the pilot; reject any design that depends on it.
    used = {b for c in module['cells'].values() for bits in c['connections'].values() for b in bits}
    used.update(b for p in module['ports'].values() for b in p['bits'])
    if used.intersection(oscillator['connections'].get('SEDSTDBY', [])):
        raise BuildError('Comparison cannot abstract a used OSCH SEDSTDBY output')
    module['attributes'].pop('hdlname', None)
    design['modules'] = {'dut': module}
    write_json(destination / 'normalized.json', design)
    script = destination / 'export.ys'
    script.write_text('read_json normalized.json\nhierarchy -check -top dut\ncheck -assert\nopt\nwrite_verilog -noattr normalized.v\n')
    run([tool('yosys'), '-s', script.name], destination, destination / 'export.log')
    return destination / 'normalized.v'


def testbench():
    connections = ['.__comparison_clock(clk)', '.reqsafestate(safe)', '.carrierrdy(hb)',
                   '.pilot_in(pilot)', '.i2c_scl(1\'b0)', '.i2c_sda(1\'b0)',
                   '.slotok(slotok)', '.reqoe(reqoe)']
    connections += [f'.fpga_{i:02d}(data[{i}])' for i in range(30)]
    connections += [f'.d_{i:02d}(out[{i}])' for i in range(30)]
    return TB.replace('@CONNECTIONS@', ',\n'.join(connections))


SCENARIOS = [(fault, safe) for fault in ('timeout', 'fast', 'slow') for safe in (0, 1)]


def device_settings(text):
    """Extract decoded electrical/global fields without treating them as logic."""
    settings, tile = {}, ''
    for line in text.splitlines():
        if line.startswith('.tile '):
            tile = line.split()[1]
        elif line.startswith(('.device ', '.variant ')):
            key, value = line.split(maxsplit=1)
            settings[key] = value
        elif line.startswith(('enum: ', 'word: ')):
            _, key, value = line.split(maxsplit=2)
            if key.startswith(('PIO', 'BANK.', 'SYSCONFIG.', 'OSCH.', 'GSR.')):
                settings[f'{tile}/{key}'] = value
        elif line.startswith('unknown:') and any(t in tile for t in ('PIC', 'CFG', 'OSC')):
            settings[f'{tile}/{line}'] = 'review required: undecoded bit'
    return settings


def configuration_evidence(builds, directory):
    """Decode both actual bitstreams; expose differences for electrical review."""
    decoded = {}
    for backend, build in builds.items():
        bitstream = build.firmware_path('bit')
        output = directory / f'{backend}-unpacked.config'
        run([tool('ecpunpack'), str(bitstream), str(output)], directory,
            directory / f'{backend}-unpack.log')
        decoded[backend] = device_settings(output.read_text())
    keys = set().union(*(set(fields) for fields in decoded.values()))
    differences = {k: {b: fields.get(k) for b, fields in decoded.items()} for k in sorted(keys)
                   if len({fields.get(k) for fields in decoded.values()}) > 1}
    return {'decoded_fields': decoded, 'differences': differences,
            'status': 'review required' if differences else 'decoded fields match',
            'scope': 'decoded PIO/bank/global settings; excludes logic, routing and USERCODE; '
                     'not proof of all electrical defaults or physical pin connectivity'}


def simulate(netlist, directory):
    """Start a new simulation process (fresh initial state) for every fault case."""
    (directory / 'tb.v').write_text(testbench())
    run([tool('iverilog'), '-g2012', '-s', 'tb', '-o', 'sim.vvp',
         str(netlist), 'tb.v'], directory, directory / 'compile.log')
    traces = {}
    for fault, safe in SCENARIOS:
        key = f'{fault}-safe{safe}'
        log = directory / f'{key}.log'
        run([tool('vvp'), 'sim.vvp', f'+FAULT={fault}', f'+SAFE={safe}'], directory, log)
        lines = log.read_text().splitlines()
        if 'PASS' not in lines:
            raise BuildError(f'Simulation did not finish: {log}')
        traces[key] = [line for line in lines if line.startswith('TRACE ')]
        if not traces[key]:
            raise BuildError(f'Simulation produced no comparisons: {log}')
    return traces


def formal(reference, candidate, directory):
    """Attempt output equivalence and separately check initialized outputs.

    No internal aliases are assumed equal between independently optimized tools.
    Failure to prove is reported as unproven, never as equivalent.
    """
    commands = []
    for label, path in [('gold', reference), ('gate', candidate)]:
        commands += [f'read_json {json.dumps(str(path))}', 'hierarchy -top dut',
                     'async2sync', 'opt_clean', f'rename dut {label}',
                     f'rename -hide {label}/w:*', f'design -stash {label}']
    commands += ['design -copy-from gold -as gold gold', 'design -copy-from gate -as gate gate',
                 'write_json copies.json']
    (directory / 'formal-prepare.ys').write_text('\n'.join(commands) + '\n')
    run([tool('yosys'), '-s', 'formal-prepare.ys'], directory, directory / 'formal-prepare.log')
    results = {}
    for label, commands in {
        'induction': ['equiv_make gold gate equiv', 'hierarchy -top equiv',
                      'equiv_simple -undef', 'equiv_induct -undef -seq 8', 'equiv_status -assert'],
        'startup': ['miter -equiv -make_assert -flatten gold gate startup',
                    'hierarchy -top startup', 'sat -seq 8 -prove-asserts -verify'],
    }.items():
        (directory / f'{label}.ys').write_text('read_json copies.json\n' + '\n'.join(commands) + '\n')
        try:
            run([tool('yosys'), '-s', f'{label}.ys'], directory, directory / f'{label}.log')
            results[label] = 'proven'
        except subprocess.TimeoutExpired:
            results[label] = 'timeout'
        except BuildError:
            results[label] = 'unproven; inspect log for counterexample or tool error'
    return results


def compare(root, name, target=None, release_cycle=None, backend=None):
    """Run the pilot checks; return a report path and whether selected checks pass."""
    if name != 'cvg_tx30' or release_cycle != 'heartbeat_cvg':
        raise BuildError('Netlist comparison currently supports heartbeat_cvg/cvg_tx30 only')
    from cpld_vhdl_generator import load_config
    from .report import _row
    selected = [backend] if backend else ['foss', 'diamond']
    foss = load_build(root, name, target, 'foss', release_cycle)
    config = load_config(foss.manifests[0].parent / 'generator.toml')
    expected_contract = {
        'implementation': 'heartbeat', 'request_mode': 'active_high',
        'carrier_ready': 'heartbeat', 'slotok': [1, 0], 'reqoe': [1, 1],
        'heartbeat': {'timeout_clks': 208, 'min_edge_clks': 10,
                      'max_edge_clks': 52, 'valid_edges_required': 16},
    }
    expected_routes = {f'd_{i:02d}': (f'fpga_{i:02d}', '0') for i in range(30)}
    if (any(config.contract.get(k) != v for k, v in expected_contract.items()) or
            config.enable or config.pilot_policy != 'unused' or
            {p.name: p.actions for p in config.pins if p.direction == 'out'} != expected_routes):
        raise BuildError('Pilot testbench requires the original cvg_tx30 contract and routes')
    destination = safe_directory(foss, foss.build_root / 'comparison')
    report_path = destination / 'report.json'
    report = {'schema_version': 1, 'program': foss.qualified_name, 'status': 'running',
              'selected_backends': selected, 'checks': {}, 'diamond_foss_equivalent': False,
              'scope': 'functional mapped netlists; common ideal clock; binary inputs',
              'formal_assumption': 'async2sync negative hold time; startup bounded to eight cycles',
              'timing_acceptance': 'not evaluated', 'post_route_simulation': 'not implemented',
              'hardware_validation': 'not performed',
              'implementation_sha256': digest(Path(__file__)), 'build_records': {}}
    with ExitStack() as stack:
        builds = {b: load_build(root, name, target, b, release_cycle) for b in set(selected) | {'foss'}}
        for b in sorted(builds):
            stack.enter_context(locked(builds[b]))
        if destination.exists():
            shutil.rmtree(destination)
        destination.mkdir(parents=True)
        write_json(report_path, report)
        try:
            for b, build in builds.items():
                if _row(build)['status'] != 'success':
                    if b == 'foss':
                        raise BuildError(f'Build fresh {b} firmware first: {build.directory}')
                    report['checks'][b] = {'status': 'missing or stale', 'formal_passed': False,
                                           'action': f'Build fresh {b} firmware first: {build.directory}'}
                    continue
                report['build_records'][b] = digest(build.directory / 'metadata/build.json')
            report['tools'] = {n: {'path': tool(n), 'sha256': digest(Path(tool(n)))}
                               for n in ('yosys', 'iverilog', 'vvp')}
            report['cell_models'] = {p.name: digest(p) for p in
                                     (suite_root() / 'share/yosys/lattice').glob('*') if p.suffix in ('.v', '.vh')}
            timing = json.loads((foss.directory / 'metadata/reports/timing.json').read_text())
            report['foss_clock_timing'] = timing.get('fmax', {})
            if 'diamond' in report['build_records']:
                report['configuration'] = configuration_evidence(builds, destination)
            reference = normalize(foss.directory / 'reports/reference.v', foss.top,
                                  destination / 'reference', root)
            expected = simulate(reference, reference.parent)
            report['checks']['reference_simulation'] = 'passed'
            for b in selected:
                if b in report['checks']:
                    continue
                build = builds[b]
                source = (build.directory / 'metadata/reports/synth.json' if b == 'foss'
                          else build.directory / 'reports/comparison_mapped.v')
                if not source.is_file():
                    raise BuildError(f'Missing comparison artifact; rebuild {b}: {source}')
                netlist = normalize(source, build.top, destination / b, root, mapped=b == 'foss')
                observed = simulate(netlist, netlist.parent)
                if observed != expected:
                    raise BuildError(f'{b} output trace differs from reference; see {netlist.parent}')
                proof = (json.loads((build.directory / 'metadata/reports/equivalence.json').read_text())
                         if b == 'foss' else formal(reference.with_suffix('.json'),
                                                  netlist.with_suffix('.json'), netlist.parent))
                proven = ((proof.get('result') == 'proven' and proof.get('initial_alignment_proven') is True)
                          if b == 'foss' else all(value == 'proven' for value in proof.values()))
                report['checks'][b] = {'simulation': 'passed', 'scenarios': len(SCENARIOS),
                                       'formal': proof, 'formal_passed': proven}
            passed = all(report['checks'][b]['formal_passed'] for b in selected)
            report['status'] = ('passed' if passed else 'incomplete'
                                if any('status' in report['checks'][b] for b in selected) else 'unproven')
            report['diamond_foss_equivalent'] = passed and set(selected) == {'foss', 'diamond'}
        except (BuildError, OSError, ValueError, subprocess.TimeoutExpired) as exc:
            report['status'] = 'incomplete' if isinstance(exc, FileNotFoundError) else 'failed'
            report['error'] = str(exc)
            passed = False
        finally:
            report['artifacts'] = {str(p.relative_to(destination)): digest(p)
                                   for p in destination.rglob('*') if p.is_file() and p != report_path}
            write_json(report_path, report)
    return report_path, passed


TB = r'''`timescale 1ns/1ps
module tb;
reg clk=0, safe=0, hb=0, pilot=0;
reg [29:0] data=30'h3fffffff;
wire [29:0] out;
wire slotok, reqoe;
integer phase=0, period=21, running=0, safe_fault=0, count=0, i;
reg [63:0] fault;
dut device(@CONNECTIONS@);
task trace;
begin
  $display("TRACE %0d %b %b %b", count, slotok, reqoe, out);
  count=count+1;
end
endtask
task tick(input integer cycles);
integer j;
begin
  for(j=0;j<cycles;j=j+1) begin
    clk=0;
    if(running) begin
      phase=phase+1;
      if(phase>=period) begin phase=0; hb=~hb; end
    end
    #5; clk=1; #5; trace;
  end
end
endtask
task check(input normal, input error);
begin
  #1;
  if(slotok !== normal || reqoe !== !error || out !== (normal ? data : 30'b0))
    $fatal(1,"Output mismatch: normal=%b error=%b slotok=%b reqoe=%b out=%b",normal,error,slotok,reqoe,out);
  trace;
end
endtask
initial begin
  if(!$value$plusargs("FAULT=%s",fault)) $fatal(1,"FAULT required");
  if(!$value$plusargs("SAFE=%d",safe_fault)) $fatal(1,"SAFE required");
  #1; check(0,0);
  tick(220); check(0,0); // Absence before qualification is not an error.
  running=1; period=5; tick(100); check(0,0); // Invalid startup traffic stays unarmed.
  period=21; phase=0; tick(400); check(1,0);
  // Walking one/zero data patterns with a held clock.
  for(i=0;i<30;i=i+1) begin data=30'b1<<i; check(1,0); data=~data; check(1,0); end
  data=30'h3fffffff;
  safe=1; check(0,0); safe=0; check(0,0);
  tick(1); check(0,0); tick(1); check(1,0);
  // Complete any partial interval before testing inclusive legal bounds.
  while(phase!=0) tick(1);
  period=10; tick(200); check(1,0);
  period=52; tick(1040); check(1,0);
  period=21; tick(420); check(1,0);
  safe=safe_fault; check(!safe_fault,0);
  phase=0;
  if(fault=="timeout") running=0;
  else if(fault=="fast") period=9;
  else if(fault=="slow") period=53;
  else $fatal(1,"Unknown fault");
  tick(212); check(0,1);
  running=1; period=21; phase=0;
  tick(420); check(0,1);
  safe=1; pilot=1; tick(420); check(0,1);
  safe=0; pilot=0; tick(420); check(0,1);
  for(i=0;i<30;i=i+1) begin data=30'b1<<i; check(0,1); end
  $display("PASS"); $finish;
end
endmodule
'''
