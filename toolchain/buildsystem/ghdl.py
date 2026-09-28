"""Prepare and analyze VHDL sources in their declared GHDL libraries."""

from pathlib import Path
import subprocess
import re

from .model import BuildError


def machxo2_library(root: Path, sources, output: Path, standard: str) -> list[str]:
    """Create a GHDL library stub only for sources that declare MachXO2."""
    libraries = [name.strip().lower() for source in sources
                 for clause in re.findall(r'\blibrary\s+([^;]+);',
                                          re.sub(r'--[^\n]*', '', source.path.read_text()), re.I)
                 for name in clause.split(',')]
    if 'machxo2' not in libraries:
        return []
    stub = root / 'toolchain/hdl/machxo2_empty.vhdl'
    subprocess.run(['ghdl', '-a', f'--std={standard}', '--work=machxo2',
                    f'--workdir={output}', str(stub)], check=True)
    return [f'-P{output}']


def analyze_sources(root: Path, sources, output: Path, standard: str, log=None) -> list[str]:
    """Analyze the ordered manifest in its libraries, then return search arguments."""
    if any('"' in str(path.resolve()) for path in (root, output, *(source.path for source in sources))):
        raise BuildError('GHDL library paths cannot contain double quotes; use a checkout and source paths without them')
    machxo2_library(root, sources, output, standard)
    search = [f'-P{output}']
    for source in sources:
        subprocess.run(['ghdl', '-a', f'--std={standard}', *search,
                        f'--work={source.library}', f'--workdir={output}', str(source.path)],
                       cwd=output, stdout=log, stderr=subprocess.STDOUT if log is not None else None, check=True)
    return search
