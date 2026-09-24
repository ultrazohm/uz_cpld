"""Prepare the unused MachXO2 library declared by archived D-slot sources."""

from pathlib import Path
import subprocess


def machxo2_library(root: Path, sources, output: Path, standard: str) -> list[str]:
    """Create a GHDL library stub only for sources that declare MachXO2."""
    if not any('library machxo2;' in source.path.read_text(errors='replace').lower()
               for source in sources):
        return []
    stub = root / 'toolchain/hdl/machxo2_empty.vhdl'
    subprocess.run(['ghdl', '-a', f'--std={standard}', '--work=machxo2',
                    f'--workdir={output}', str(stub)], check=True)
    return [f'-P{output}']
