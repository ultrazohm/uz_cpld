"""Licensed integration check for independent scaffolding and optional legacy comparison.

Run ``python3 cpld_toolchain/toolchain/tests/validate_diamond.py`` after ``make build_all``. Requires
Diamond but never modifies original project files or programs hardware.
"""
import argparse
import json
from pathlib import Path
import re
import shutil
import sys
import tempfile
import xml.etree.ElementTree as ET
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from cpld_toolchain.toolchain.buildsystem.backends.diamond import run, tcl, wrap
from cpld_toolchain.toolchain.buildsystem.model import catalog, load_build
from cpld_toolchain.toolchain.buildsystem.workflow import build_program, scaffold, digest

ROOT = Path(__file__).resolve().parents[3]


def jed_payload(path):
    """Compare programming records, excluding JEDEC notes and transport checksum."""
    data = path.read_text(errors='replace').split('\x02', 1)[-1].split('\x03', 1)[0]
    records = [re.sub(r'\s+', '', r) for r in data.split('*')
            if re.match(r'^(QF|QP|F[01]|L\d|C[0-9A-F]|E[01]|G[01]|J\d|U)', r.strip())]
    if not any(r.startswith('QF') for r in records) or not any(r.startswith('L') for r in records):
        raise RuntimeError(f'Incomplete JEDEC programming records: {path}')
    return records


def compare_reports(reference, generated):
    """Compare pin table rows and resource counts, ignoring report headers."""
    results = {}
    for ext, select in [('pad', lambda line: line.startswith('|')),
                        ('mrp', lambda line: 'out of' in line or 'used :' in line)]:
        left = [line.strip() for line in reference.with_suffix('.' + ext).read_text().splitlines() if select(line)]
        right = [line.strip() for line in generated.with_suffix('.' + ext).read_text().splitlines() if select(line)]
        results[ext + '_matches'] = bool(left) and left == right
    return results


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--legacy-project', type=Path,
                        help='Optional external LDF for legacy comparison; not required')
    args = parser.parse_args()
    results = {}
    # Keep all evidence beneath ignored cpld_toolchain/toolchain/build/validation; unique directory per run.
    output = ROOT / 'cpld_toolchain/toolchain/build/validation'; output.mkdir(parents=True, exist_ok=True)
    stage = Path(tempfile.mkdtemp(prefix='integration-', dir=output))
    for name in catalog(ROOT) if args.legacy_project else []:
        dest = stage / name; dest.mkdir()
        legacy = args.legacy_project.resolve().parent
        tree = ET.parse(args.legacy_project)
        project = tree.getroot(); project.set('default_implementation', name)
        for impl in list(project.findall('Implementation')):
            if impl.get('title') != name:
                project.remove(impl)
            else:
                for source in impl.findall('Source'):
                    original = legacy / source.get('name')
                    source.set('name', str(original))
        for strategy in project.findall('Strategy'):
            shutil.copy2(legacy / strategy.get('file'), dest / strategy.get('file'))
        tree.write(dest / 'uz_d_slots.ldf', encoding='UTF-8', xml_declaration=True)
        script = dest / 'legacy.tcl'
        script.write_text(wrap(['prj_project open uz_d_slots.ldf',
            f'prj_run Export -impl {tcl(name)} -task Bitgen',
            f'prj_run Export -impl {tcl(name)} -task Jedecgen',
            f'prj_run PAR -impl {tcl(name)} -task PARTrace', 'prj_project close']))
        run(script, dest / 'legacy.log')
        reference = dest / name / f'uz_d_slots_{name}.jed'
        generated = load_build(ROOT, name).firmware_path('jed')
        match = jed_payload(reference) == jed_payload(generated)
        results[name] = {'jedec_programming_records_match': match,
                         'legacy_jed_sha256': digest(reference), 'generated_jed_sha256': digest(generated)}
        results[name].update(compare_reports(reference, generated.parent / 'reports/firmware_impl'))
        print(name, results[name], flush=True)
        if not all(results[name][k] for k in ('pad_matches', 'mrp_matches')):
            raise RuntimeError(f'{name}: pin/utilization reports differ')
        if not match:
            raise RuntimeError(f'{name}: legacy/generated JEDEC payload mismatch; see {dest}')
    # Fresh checkout-shaped tree, with spaces in its path and no generated outputs.
    relocated = stage / 'relocated checkout'; relocated.mkdir()
    for folder in ('cpld_toolchain', 'programs'):
        shutil.copytree(ROOT / folder, relocated / folder, ignore=shutil.ignore_patterns('__pycache__', 'build'))
    scaffold(relocated, 'custom', 'tx30')
    build_program(load_build(relocated, 'custom'))
    matches = jed_payload(load_build(relocated, 'custom').firmware_path('jed')) == jed_payload(load_build(ROOT, 'tx30').firmware_path('jed'))
    results['scaffold_in_relocated_checkout'] = {'jedec_programming_records_match': matches}
    if not matches:
        raise RuntimeError('Relocated scaffold differs from tx30')
    (stage / 'validation.json').write_text(json.dumps(results, indent=2) + '\n')
    print(stage / 'validation.json')


if __name__ == '__main__':
    main()
