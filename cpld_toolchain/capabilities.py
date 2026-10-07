"""Command-scoped prerequisite checks shared by execution and doctor.

Availability means dependencies were located, not that a license, tool version,
USB permissions or hardware connection has been verified. Workflow preflights
remain responsible for those checks.
"""
from dataclasses import dataclass
from importlib.util import find_spec
import sys

from . import tools
from .toolchain.buildsystem.model import BuildError


@dataclass(frozen=True)
class Requirement:
    name: str
    kind: str
    value: str


def requirements(action, options):
    backend = options.get('backend', 'diamond')
    build = options.get('build_backend', backend)
    programmer = options.get('programmer_backend', backend)
    result = []
    def python(*names):
        result.extend(Requirement(name, 'python', name) for name in names)
    def external(*names):
        result.extend(Requirement(name, 'tool', name) for name in names)
    if action in ('docs', 'docs_assets', 'sim'):
        python('pytest', 'xdist', 'cocotb', 'find_libpython')
        external('ghdl')
    if action in ('docs', 'docs_assets'):
        python('plotly', 'vcd')
    if action == 'docs':
        python('sphinx', 'furo', 'sphinxcontrib.mermaid')
    if action in ('docs', 'docs_assets', 'netlist'):
        external('yosys', 'dot')
        if action == 'netlist':
            external('ghdl')
    if action in ('build', 'build_all', 'build_selection', 'project', 'gui') or (
            action == 'diamond_xcf_programming_chain' and options.get('rebuild') == '1'):
        if build == 'diamond':
            result.append(Requirement('Diamond build CLI', 'diamond', 'cli'))
        else:
            external('ghdl', 'foss:yosys', 'foss:nextpnr-machxo2', 'foss:ecppack', 'foss:openFPGALoader')
    if action == 'gui':
        result.append(Requirement('Diamond GUI', 'diamond', 'gui'))
    if action == 'compare':
        external('ghdl', 'foss:yosys', 'foss:iverilog', 'foss:vvp', 'foss:ecpunpack')
    if action in ('scan', 'identify', 'program'):
        if programmer == 'diamond':
            result.append(Requirement('Diamond Programmer', 'diamond', 'programmer'))
            if sys.platform != 'win32':
                external('bash')
        else:
            if action in ('scan', 'program'):
                external('openFPGALoader')
            if action in ('identify', 'program'):
                external('openocd')
    if action == 'firmware_download' and not (options.get('git_url') and options.get('branch')):
        external('git')
    if action == 'image':
        external(options.get('container_engine', 'docker'))
    if action == 'flasher_build':
        external('cmake', 'make', 'c++', 'pkg-config')
    return tuple(dict.fromkeys(result))


def missing(requirement):
    try:
        if requirement.kind == 'python':
            return None if find_spec(requirement.value) else f'Python module {requirement.value}'
        if requirement.kind == 'diamond':
            from .toolchain.diamond import executable
            executable(requirement.value)
            return None
        name = requirement.value
        if name.startswith('foss:'):
            # FOSS builds still require the existing pinned installation and receipts.
            from .toolchain.buildsystem.backends.foss import tool
            tool(name.split(':', 1)[1])
            return None
        resolver = {'openFPGALoader': tools.loader_path, 'openocd': tools.openocd_path,
                    'yosys': tools.yosys_path}.get(name)
        candidate = resolver() if resolver else name
        return None if tools.installed(candidate) else f'{requirement.name} ({candidate})'
    except (ImportError, ValueError, OSError, BuildError) as exc:
        return f'{requirement.name}: {exc}'


def unavailable(action, options):
    return tuple(detail for requirement in requirements(action, options)
                 if (detail := missing(requirement)))


def require(action, options):
    problems = unavailable(action, options)
    if problems:
        raise BuildError(f'{action} cannot run; missing requirements:\n  - ' + '\n  - '.join(problems) +
                         '\nRun uz_cpld doctor for details. Install the requirements for this command, '
                         'or use the configured toolchain container. '
                         'For missing Python dependencies, run python -m cpld_toolchain setup.')


def inventory():
    """Representative capabilities; excludes configuration and destructive actions."""
    for label, action, options in (
        ('Simulation', 'sim', {}), ('Documentation', 'docs', {}),
        ('Diamond builds', 'build', {'backend': 'diamond'}),
        ('FOSS builds', 'build', {'backend': 'foss'}),
        ('Diamond programming', 'program', {'backend': 'diamond'}),
        ('FOSS programming + identity', 'program', {'programmer_backend': 'foss'}),
    ):
        yield label, unavailable(action, options)
