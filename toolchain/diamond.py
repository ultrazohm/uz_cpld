"""Native Diamond executable discovery and Windows runtime environment."""
import os
from pathlib import Path
import shutil
import sys

from toolchain.buildsystem.model import BuildError


def executable(kind='cli', *, required=True):
    windows = sys.platform == 'win32'
    variable = {'cli': 'DIAMOND_CLI', 'gui': 'DIAMOND_GUI', 'programmer': 'CPLD_PGRCMD'}[kind]
    names = ({'cli': 'pnmainc.exe', 'gui': 'pnmain.exe', 'programmer': 'pgrcmd.exe'} if windows else
             {'cli': 'diamondc', 'gui': 'diamond', 'programmer': 'pgrcmd'})
    root = Path(os.environ.get('DIAMOND_ROOT', 'C:/lscc/diamond/3.14' if windows else '/opt/diamond'))
    platform_dir = 'nt64' if windows else 'lin64'
    candidates = [str(root / 'bin' / platform_dir / names[kind])]
    if kind == 'programmer':
        candidates.insert(0, str(root / 'programmer/bin' / platform_dir / names[kind]))
    if 'DIAMOND_ROOT' not in os.environ:
        candidates.append(names[kind])
    if os.environ.get(variable):
        candidates = [os.environ[variable]]
    for candidate in candidates:
        found = shutil.which(candidate)
        if found:
            result = Path(found).resolve()
            if windows and result.suffix.lower() != '.exe':
                raise BuildError(f'{variable} must name a Windows .exe, not a batch/shell command')
            return result
    if not required:
        candidate = Path(candidates[0])
        if windows and candidate.suffix.lower() != '.exe':
            raise BuildError(f'{variable} must name a Windows .exe')
        return candidate
    raise BuildError(f'Diamond {kind} unavailable; set DIAMOND_ROOT or {variable} (tried {", ".join(candidates)})')


def environment(executable_path):
    """Windows tools need DLL/search paths; Linux launchers set their own environment."""
    env = dict(os.environ)
    if sys.platform != 'win32':
        return env
    binary = Path(executable_path).resolve()
    root = binary.parent.parent.parent
    if root.name.lower() == 'programmer':
        root = root.parent
    root = Path(env.get('DIAMOND_ROOT', root))
    foundry = Path(env.get('FOUNDRY', root / 'ispfpga'))
    env['FOUNDRY'] = str(foundry)
    env['PATH'] = ';'.join(map(str, (binary.parent, root / 'bin/nt64', foundry / 'bin/nt64'))) + ';' + env.get('PATH', '')
    license_path = root / 'license/license.dat'
    if license_path.is_file():
        env['LM_LICENSE_FILE'] = str(license_path) + (';' + env['LM_LICENSE_FILE'] if env.get('LM_LICENSE_FILE') else '')
    return env
