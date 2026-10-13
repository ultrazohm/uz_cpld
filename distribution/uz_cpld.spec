from pathlib import Path

root = Path(SPECPATH).parent
data = root / 'cpld_toolchain/programmer_helper'
a = Analysis(
    [str(root / 'distribution/entry.py')], pathex=[str(root)],
    datas=[(str(root / 'cpld_toolchain/windows_driver_pin.json'), 'cpld_toolchain'),(str(data / 'templates'), 'cpld_toolchain/programmer_helper/templates'),
           (str(data / 'selection.example.toml'), 'cpld_toolchain/programmer_helper'),
           (str(data / 'diamond_program.sh'), 'cpld_toolchain/programmer_helper'),
           (str(root / 'cpld_toolchain/toolchain/foss/openfpgaloader.json'), 'cpld_toolchain/toolchain/foss'),
           (str(root / 'cpld_toolchain/toolchain/foss/openfpgaloader-usercode.patch'), 'cpld_toolchain/toolchain/foss')],
    # runtime.execute imports this entry point by name, outside static analysis.
    hiddenimports=['tomli', 'cpld_toolchain.programmer_helper.program', 'cpld_toolchain.driver_setup'],
    excludes=['typer', 'sphinx', 'plotly', 'cocotb', 'pytest', 'tkinter',
              'cpld_toolchain.cli', 'cpld_toolchain.bootstrap',
              'cpld_toolchain.toolchain.analysis', 'cpld_toolchain.toolchain.simulation'],
    noarchive=False,
)
pyz = PYZ(a.pure)
exe = EXE(pyz, a.scripts, [], exclude_binaries=True, name='uz_cpld',
          debug=False, strip=False, upx=False, console=True)
coll = COLLECT(exe, a.binaries, a.datas, strip=False, upx=False, name='uz_cpld')
