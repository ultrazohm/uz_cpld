"""Exercise the installed wheel and its bundled programmer outside the checkout."""
import argparse
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from cpld_toolchain.programmer_helper.tests.test_release import ReleaseTests
from cpld_toolchain.toolchain.foss.tests.fixtures import jedec


def smoke(python, gui=False):
    # Resolving a venv's interpreter symlink would bypass the venv on Linux.
    python = str(python.absolute())
    fixture = ReleaseTests()
    fixture.setUp()
    try:
        with tempfile.TemporaryDirectory(prefix='uz installed wheel ') as directory:
            root = Path(directory)
            env = dict(os.environ, PYTHONPATH='', UZ_CPLD_DATA_DIR=str(root / 'data'),
                       UZ_CPLD_CONFIG_DIR=str(root / 'config'))
            for key in ('CPLD_BUNDLED_TOOLS', 'CPLD_OPENFPGALOADER', 'CPLD_DRIVER_HELPER',
                        'FOSS_ROOT', 'UZ_CPLD_GUI_PYTHON', 'UZ_CPLD_GUI_WORKER_PYTHON'):
                env.pop(key, None)
            def run(*args, success=True):
                result = subprocess.run([python, '-I', *args], cwd=root, env=env,
                                        capture_output=True, text=True, timeout=60)
                if (result.returncode == 0) != success:
                    raise RuntimeError(result.stdout + result.stderr)
                return result.stdout
            def cli(*args, **kwargs):
                return run('-m', 'cpld_toolchain.user', *args, **kwargs)
            info = json.loads(run('-c', 'import json, importlib.metadata as m; '
                'from pathlib import Path; import cpld_toolchain; '
                'from cpld_toolchain.tools import loader_path, bundled_directory; '
                'print(json.dumps(dict(user=m.version("ultrazohm-cpld-user"), '
                'programmer=json.loads((bundled_directory() / "release.json").read_text())["version"], '
                'dependencies=m.requires("ultrazohm-cpld-user"), '
                'package=cpld_toolchain.__file__, loader=str(loader_path()))))'))
            assert info['user'] == info['programmer']
            assert info['dependencies'] == ['certifi==2026.7.22']
            assert Path(info['loader']).is_relative_to(Path(info['package']).parent / 'bundled_tools')
            assert not Path(info['package']).is_relative_to(ROOT / 'cpld_toolchain')
            assert info['user'] in cli('--version')
            assert info['user'] in run('-m', 'cpld_toolchain', '--version')
            assert run('-c', 'from cpld_toolchain import programmer_command; print(programmer_command())').strip() == 'ultrazohm-cpld-user'
            launcher = Path(python).parent / ('ultrazohm-cpld-user.exe' if os.name == 'nt' else 'ultrazohm-cpld-user')
            gui_launcher = launcher.with_name('ultrazohm-cpld-user-gui.exe' if os.name == 'nt' else 'ultrazohm-cpld-user-gui')
            assert gui_launcher.is_file()
            launched = subprocess.run([str(launcher), '--version'], cwd=root, env=env,
                                      capture_output=True, text=True, timeout=30)
            assert launched.returncode == 0 and info['user'] in launched.stdout, launched.stdout + launched.stderr
            assert 'build_all' not in cli('--help')
            cli('build_all', success=False)
            assert 'Loader verified' in cli('doctor')
            cli('setup_drivers', '--dry-run', '1')
            cli('firmware_select', '--firmware', str(fixture.zip))
            cli('firmware_list')
            request, response = root / 'request.json', root / 'response.json'
            request.write_text(json.dumps(dict(action='select', firmware=str(fixture.zip), workspace=str(root / 'workspace'))))
            cli('--programmer-gui-worker', str(request), str(response))
            assert json.loads(response.read_text())['ok']
            native = root / 'native fixture.jed'
            native.write_bytes(jedec())
            result = subprocess.run([info['loader'], '--check-file', '--usercode', '89ABCDEF', str(native)],
                                    cwd=root, env=env, capture_output=True, text=True, timeout=30)
            assert result.returncode == 0, result.stdout + result.stderr
            if os.name == 'nt':
                run('-c', 'from cpld_toolchain.driver_setup import helper_path, invoke; '
                    'r=invoke(helper_path(), "--version"); assert r.returncode == 0, r.stderr')
            if gui:
                cli('programmer_gui', '--check')
                run('-c', '''import json, time, tkinter as tk
from pathlib import Path
from cpld_toolchain.programmer_gui import ProgrammerWindow
r = tk.Tk()
r.withdraw()
w = ProgrammerWindow(r, Path("gui-workspace"))
def fail(title, message, **kwargs):
    raise RuntimeError(message)
w.message.showerror = fail
deadline = time.monotonic() + 30
while not (getattr(w, "result_path", None) and w.process is None):
    assert time.monotonic() < deadline, "GUI worker did not finish"
    r.update()
    time.sleep(0.01)
assert json.loads(w.result_path.read_text())["ok"]
w.close()
''')
            print(f'Installed wheel {info["user"]} and bundled programmer passed; no USB operation or driver change performed.')
    finally:
        fixture.doCleanups()


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--python', type=Path, required=True)
    parser.add_argument('--gui', action='store_true')
    args = parser.parse_args()
    smoke(args.python, args.gui)
