"""Prepare and analyze VHDL sources in their declared GHDL libraries."""

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


def analyze_sources(root: Path, sources, output: Path, standard: str, log=None) -> list[str]:
    """Analyze the ordered manifest in its libraries, then return search arguments."""
    machxo2_library(root, sources, output, standard)
    search = [f'-P{output}']
    for source in sources:
        subprocess.run(['ghdl', '-a', f'--std={standard}', *search,
                        f'--work={source.library}', f'--workdir={output}', str(source.path)],
                       cwd=output, stdout=log, stderr=subprocess.STDOUT if log is not None else None, check=True)
    return search
