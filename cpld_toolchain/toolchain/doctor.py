"""Read-only environment inventory; missing optional tools are report entries."""
from cpld_toolchain import repository_root
import argparse
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass
from importlib import metadata, util
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys

from cpld_toolchain.toolchain.diamond import executable as diamond_executable
from cpld_toolchain.toolchain.diamond import installed_version
from cpld_toolchain.toolchain.buildsystem.model import BuildError


@dataclass(frozen=True)
class Finding:
    name: str
    state: str
    detail: str


def compact(value):
    return ' '.join(str(value).split())[:240]


def locate(value):
    return shutil.which(str(value)) if value else None


def probe(name, candidate, version_args=None):
    """Only explicitly supplied version flags run; no vendor or USB operations."""
    found = locate(candidate)
    if not found and candidate and Path(candidate).is_file():
        return Finding(name, 'FAILED', f'{candidate}: not executable')
    if not found:
        return Finding(name, 'MISSING', str(candidate or 'not found on PATH'))
    if version_args is None:
        return Finding(name, 'FOUND', f'{found} (startup not tested)')
    try:
        result = subprocess.run([found, *version_args], capture_output=True, text=True,
                                errors='replace', timeout=5, stdin=subprocess.DEVNULL)
        output = next((compact(line) for line in (result.stdout or result.stderr).splitlines() if line.strip()), '')
        if result.returncode:
            return Finding(name, 'FAILED', f'{found}: exit {result.returncode}; {output}')
        return Finding(name, 'OK', f'{found}; {output or "version command succeeded"}')
    except subprocess.TimeoutExpired:
        return Finding(name, 'TIMEOUT', f'{found}: version check exceeded 5 seconds')
    except OSError as exc:
        return Finding(name, 'FAILED', f'{found}: {compact(exc)}')


def package(name, module=None):
    try:
        version = metadata.version(name)
        return Finding(name, 'FOUND', f'{version} (installed in this Python environment)')
    except metadata.PackageNotFoundError:
        if module:
            try:
                spec = util.find_spec(module)
                if spec:
                    return Finding(name, 'FOUND', str(spec.origin or 'available module'))
            except (ImportError, ValueError):
                pass
        return Finding(name, 'MISSING', 'not installed in this Python environment')


def receipt(name, installed, expected):
    try:
        actual = json.loads(installed.read_text(encoding='utf-8'))
        wanted = json.loads(expected.read_text(encoding='utf-8'))
        return Finding(name, 'MATCH' if actual == wanted else 'MISMATCH', str(installed))
    except FileNotFoundError as exc:
        return Finding(name, 'MISSING', str(exc.filename))
    except (OSError, ValueError) as exc:
        return Finding(name, 'INVALID', compact(exc))


def catalog_state(root, release_cycle, backend, target):
    from cpld_toolchain.toolchain.buildsystem.model import catalog, load_build, program_backends, program_targets, resolve_release
    try:
        cycle = resolve_release(root, release_cycle)
        checked, problems = 0, []
        for name in catalog(root, cycle):
            try:
                if backend not in program_backends(root, name, cycle):
                    continue
                for board in program_targets(root, name, cycle):
                    if target is None or target == board:
                        load_build(root, name, board, backend, cycle)
                        checked += 1
            except (BuildError, OSError, ValueError, ImportError) as exc:
                problems.append(f'{name}: {exc}')
        detail = f'{cycle}, {backend}: {checked} valid program/target configurations'
        if problems:
            detail += f'; {len(problems)} invalid: ' + '; '.join(problems[:3])
        elif not checked:
            detail += ' (selection is empty)'
        return Finding('Catalog', 'INVALID' if problems else 'OK', detail)
    except (BuildError, OSError, ValueError, ImportError) as exc:
        return Finding('Catalog', 'INVALID', compact(exc))


def report(root, *, backend='diamond', release_cycle=None, target=None):
    root = Path(root).resolve()
    inside = os.environ.get('CPLD_TOOLCHAIN_CONTAINER') == '1'
    virtual = sys.prefix != sys.base_prefix
    where = 'container' if inside else 'native host'
    print('Environment report')
    print(f'  Runtime: {where}; {platform.system()} {platform.machine()}')
    print(f'  Python: {sys.version.split()[0]} at {sys.executable}')
    print(f'  Virtual environment: {sys.prefix if virtual else "not active"}')
    if not virtual and (root / '.venv/pyvenv.cfg').is_file():
        print('  Repository .venv exists but is not used by this interpreter.')
    print(f'  Checkout: {root}')
    print(f'  Selected build backend: {backend} (all tool groups are listed)')

    groups = []
    packages = [package('cpld-toolchain', 'cpld_toolchain')]
    packages += ([Finding('TOML parser', 'FOUND', 'Python standard library (tomllib)')]
                 if sys.version_info >= (3, 11) else [package('tomli', 'tomli')])
    packages += [package(name) for name in ('cocotb', 'pytest', 'pytest-xdist', 'plotly',
                                           'pyvcd', 'Sphinx', 'furo', 'sphinxcontrib-mermaid')]
    groups.append(('Python packages (FOUND does not test imports)', packages))

    vendor = []
    for kind, label in [('cli', 'Diamond build CLI'), ('gui', 'Diamond GUI'), ('programmer', 'Diamond Programmer')]:
        try:
            binary = diamond_executable(kind)
            vendor.append(Finding(label, 'FOUND', f'{binary} (startup not tested)'))
            if kind == 'cli':
                version = installed_version(binary)
                vendor.append(Finding('Diamond installed version', 'FOUND' if version else 'NOT CHECKED',
                                      f'{version} (installation metadata; compare with cpld_toolchain/toolchain/targets/*/target.toml)' if version else 'installation version metadata unavailable'))
        except (BuildError, OSError) as exc:
            vendor.append(Finding(label, 'MISSING', compact(exc)))
    diamond_root = Path(os.environ.get('DIAMOND_ROOT', 'C:/lscc/diamond/3.14' if sys.platform == 'win32' else '/opt/diamond'))
    license_file = diamond_root / 'license/license.dat'
    if os.environ.get('LM_LICENSE_FILE'):
        vendor.append(Finding('Diamond license', 'CONFIGURED', 'LM_LICENSE_FILE is set; validity not checked'))
    elif license_file.is_file():
        vendor.append(Finding('Diamond license', 'CONFIGURED', f'{license_file}; validity not checked'))
    else:
        vendor.append(Finding('Diamond license', 'NOT CHECKED', 'no LM_LICENSE_FILE or license file at the configured/default root; vendor search paths may differ'))
    groups.append(('Diamond (no license checkout or synthesis)', vendor))
    if vendor[0].state == 'MISSING':
        vendor.append(Finding('Diamond builds', 'UNAVAILABLE', 'Full Diamond build CLI is missing. Standalone Programmer can program hardware but cannot compile firmware.'))

    suite = Path(os.environ.get('FOSS_ROOT', '/opt/oss-cad-suite'))
    from cpld_toolchain.toolchain.analysis.netlist import yosys_executable
    from cpld_toolchain.programmer_helper.program import loader_path
    from cpld_toolchain.programmer_helper.identify import openocd_path
    specs = [
        ('GHDL', 'ghdl', ['--version']),
        ('Yosys (RTL diagrams)', yosys_executable(), ['-V']),
        ('Graphviz', 'dot', ['-V']),
        ('GTKWave', 'gtkwave', None),
        ('Yosys (FOSS builds)', suite / 'bin/yosys', ['-V']),
        ('nextpnr-machxo2', suite / 'native/nextpnr-machxo2', ['--version']),
        ('Trellis ecppack', suite / 'bin/ecppack', ['--version']),
        ('openFPGALoader', loader_path(), ['--Version']),
        ('OpenOCD', openocd_path(), ['--version']),
        ('Git', 'git', ['--version']),
        ('Make (optional wrapper)', 'make', ['--version']),
        ('Docker client', 'docker', ['--version']),
        ('Podman client', 'podman', ['--version']),
    ]
    with ThreadPoolExecutor(max_workers=4) as workers:
        tools = list(workers.map(lambda spec: probe(*spec), specs))
    groups.append(('External tools (OK means the version command ran)', tools))
    pins = [receipt('FOSS suite pin', suite / 'cpld-toolchain.json', root / 'cpld_toolchain/toolchain/foss/toolchain.json'),
            receipt('FOSS native source pin', suite / 'native/sources.json', root / 'cpld_toolchain/toolchain/foss/sources.json')]
    if locate(loader_path()):
        from cpld_toolchain.toolchain.foss.flasher import verify
        try:
            verify(loader_path())
            pins.append(Finding('Patched flasher receipt', 'MATCH', 'binary hash and patch pin verified; USB not tested'))
        except (OSError, ValueError) as exc:
            pins.append(Finding('Patched flasher receipt', 'INVALID', compact(exc)))
    else:
        pins.append(Finding('Patched flasher receipt', 'NOT CHECKED', 'openFPGALoader is missing'))
    groups.append(('Pinned FOSS installation (MATCH is not a firmware-build test)', pins))
    groups.append(('Repository', [catalog_state(root, release_cycle, backend, target)]))

    for title, rows in groups:
        print(f'\n{title}')
        for row in rows:
            print(f'  {row.state:<12} {row.name:<26} {compact(row.detail)}')
    print('\nMissing tools affect only workflows that use them. No hardware was accessed.')
    print('License validity, synthesis, USB permissions, Docker daemon and image availability were not tested.')
    print('Python setup: python -m cpld_toolchain venv')
    print('Bundled Linux tools: python -m cpld_toolchain image; then enter the container and run python -m cpld_toolchain doctor')
    print('Setup and workflow requirements: docs/tool-environments.rst, docs/environments.rst, docs/windows.rst')
    return 0


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=repository_root())
    parser.add_argument('--backend', choices=('diamond', 'foss'), default='diamond')
    parser.add_argument('--release-cycle')
    parser.add_argument('--target')
    args = parser.parse_args(argv)
    return report(args.root, backend=args.backend, release_cycle=args.release_cycle, target=args.target)


if __name__ == '__main__':
    raise SystemExit(main())
