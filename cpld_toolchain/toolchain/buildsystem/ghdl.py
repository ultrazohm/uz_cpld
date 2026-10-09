"""Prepare and analyze VHDL sources in their declared GHDL libraries."""

from pathlib import Path
import subprocess
import re

from .model import BuildError


def read_vhdl(path: Path) -> str:
    """Read UTF-8 or legacy Latin-1 HDL without changing its source bytes."""
    data = path.read_bytes()
    try:
        return data.decode('utf-8')
    except UnicodeDecodeError:
        return data.decode('latin-1')


def machxo2_library(root: Path, sources, output: Path, standard: str) -> list[str]:
    """Create a GHDL library stub only for sources that declare MachXO2."""
    libraries = [name.strip().lower() for source in sources
                 for clause in re.findall(r'\blibrary\s+([^;]+);',
                                          re.sub(r'--[^\n]*', '', read_vhdl(source.path)), re.I)
                 for name in clause.split(',')]
    if 'machxo2' not in libraries:
        return []
    stub = root / 'cpld_toolchain/toolchain/hdl/machxo2_empty.vhdl'
    subprocess.run(['ghdl', '-a', f'--std={standard}', '--work=machxo2',
                    f'--workdir={output}', str(stub)], check=True)
    return [f'-P{output}']


def analyze_sources(root: Path, sources, output: Path, standard: str, log=None) -> list[str]:
    """Analyze the ordered manifest in its libraries, then return search arguments."""
    if any('"' in str(path.resolve()) for path in (root, output, *(source.path for source in sources))):
        raise BuildError('GHDL library paths cannot contain double quotes; use a checkout and source paths without them')
    machxo2_library(root, sources, output, standard)
    search = [f'-P{output}']
    if any(re.search(r'\buse\s+ieee\.std_logic_(?:arith|unsigned|signed)\.',
                     re.sub(r'--[^\n]*', '', read_vhdl(source.path)), re.I)
           for source in sources):
        search.append('-fsynopsys')
    for source in sources:
        subprocess.run(['ghdl', '-a', f'--std={standard}', *search,
                        f'--work={source.library}', f'--workdir={output}', str(source.path)],
                       cwd=output, stdout=log, stderr=subprocess.STDOUT if log is not None else None, check=True)
    return search
