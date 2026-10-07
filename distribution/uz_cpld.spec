from pathlib import Path

root = Path(SPECPATH).parent
data = root / 'cpld_toolchain/programmer_helper'
a = Analysis(
    [str(root / 'distribution/entry.py')], pathex=[str(root)],
    datas=[(str(data / 'templates'), 'cpld_toolchain/programmer_helper/templates'),
           (str(data / 'selection.example.toml'), 'cpld_toolchain/programmer_helper'),
           (str(data / 'diamond_program.sh'), 'cpld_toolchain/programmer_helper')],
    hiddenimports=['tomli'],
    excludes=['typer', 'sphinx', 'plotly', 'cocotb', 'pytest', 'tkinter',
              'cpld_toolchain.cli', 'cpld_toolchain.bootstrap',
              'cpld_toolchain.toolchain.analysis', 'cpld_toolchain.toolchain.simulation'],
    noarchive=False,
)
pyz = PYZ(a.pure)
exe = EXE(pyz, a.scripts, [], exclude_binaries=True, name='uz_cpld',
          debug=False, strip=False, upx=False, console=True)
coll = COLLECT(exe, a.binaries, a.datas, strip=False, upx=False, name='uz_cpld')
