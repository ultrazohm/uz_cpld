from pathlib import Path
import json
import os
import sys
from PyInstaller.config import CONF

root = Path(SPECPATH).parent
data = root / 'cpld_toolchain/programmer_helper'
with_gui = os.environ.get('UZ_CPLD_BUILD_GUI', '1') == '1'
a = Analysis(
    [str(root / 'distribution/entry.py')], pathex=[str(root)],
    datas=[(str(root / 'cpld_toolchain/windows_driver_pin.json'), 'cpld_toolchain'),(str(data / 'templates'), 'cpld_toolchain/programmer_helper/templates'),
           (str(data / 'selection.example.toml'), 'cpld_toolchain/programmer_helper'),
           (str(data / 'diamond_program.sh'), 'cpld_toolchain/programmer_helper'),
           (str(root / 'cpld_toolchain/toolchain/foss/openfpgaloader.json'), 'cpld_toolchain/toolchain/foss'),
           (str(root / 'cpld_toolchain/toolchain/foss/openfpgaloader-usercode.patch'), 'cpld_toolchain/toolchain/foss')],
    # runtime.execute imports this entry point by name, outside static analysis.
    hiddenimports=['tomli', 'certifi', 'cpld_toolchain.programmer_helper.program', 'cpld_toolchain.driver_setup'],
    excludes=['typer', 'sphinx', 'plotly', 'cocotb', 'pytest',
              *([] if with_gui else ['tkinter']),
              'cpld_toolchain.cli', 'cpld_toolchain.bootstrap',
              'cpld_toolchain.toolchain.analysis', 'cpld_toolchain.toolchain.simulation'],
    noarchive=False,
)
# Windows 10/11 already supplies UCRT and API-set forwarding DLLs.
# Keep the Python VC runtime, with its separate redistribution terms.
if sys.platform == 'win32':
    a.binaries = [entry for entry in a.binaries if not (
        Path(entry[0]).name.lower() == 'ucrtbase.dll' or
        Path(entry[0]).name.lower().startswith(('api-ms-win-', 'ext-ms-win-')))]
Path(CONF['workpath'], 'runtime-inputs.json').write_text(json.dumps(list(a.binaries) + list(a.pure)))
pyz = PYZ(a.pure)
exe = EXE(pyz, a.scripts, [], exclude_binaries=True, name='uz_cpld',
          debug=False, strip=False, upx=False, console=True)
if with_gui:
    # Use the same runtime and module archive for both entry points.
    gui_script = ('gui_entry', str(root / 'distribution/gui_entry.py'), 'PYSOURCE')
    gui_exe = EXE(pyz, [*a.scripts[:-1], gui_script], [], exclude_binaries=True,
                  name='uz_cpld_gui', debug=False, strip=False, upx=False,
                  console=sys.platform != 'win32')
    coll = COLLECT(exe, gui_exe, a.binaries, a.datas, strip=False, upx=False, name='uz_cpld')
else:
    coll = COLLECT(exe, a.binaries, a.datas, strip=False, upx=False, name='uz_cpld')
