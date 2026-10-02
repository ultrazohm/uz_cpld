"""Generate and execute Diamond Tcl using the vendor environment wrapper."""
import os
import json
from pathlib import Path
import shutil
import subprocess
import re
import signal
import sys
import tempfile
from typing import Callable
import xml.etree.ElementTree as ET
from ..model import Build, BuildError
from toolchain.diamond import executable, environment, installed_version

STARTUP_MARKER = 'UZ_CPLD_DIAMOND_TCL_STARTED'
STARTUP_PREAMBLE = f'puts "{STARTUP_MARKER}"\nflush stdout\n'


def tcl(value: str) -> str:
    """Quote one Tcl word without allowing variable or command substitution."""
    return '"' + str(value).replace('\\', '\\\\').replace('"', '\\"').replace('$', '\\$').replace('[', '\\[').replace(']', '\\]').replace('\n', '\\n').replace('\r', '\\r') + '"'


def launcher(gui: bool = False) -> Path:
    """Find a configurable vendor launcher; overrides are executable paths."""
    return executable('gui' if gui else 'cli')


def reported_versions(output: str) -> list[str]:
    return sorted(set(re.findall(r'(?<![\d.])\d+\.\d+\.\d+\.\d+\.\d+(?![\d.])', output)))


def preflight(builds):
    """Check the shared vendor installation once, before touching build outputs."""
    expected = {build.expected_version for build in builds if build.backend == 'diamond'}
    if not expected:
        return
    if len(expected) != 1:
        raise BuildError('Selected builds require different Diamond versions: ' + ', '.join(sorted(expected)))
    wanted = expected.pop()
    binary = launcher()
    version = installed_version(binary)
    if version is not None and version != wanted:
        raise BuildError(f'Expected Diamond {wanted}; installed {version} at {binary}. '
                         'Set DIAMOND_ROOT or DIAMOND_CLI to the matching full Diamond installation. '
                         'No builds were started.')
    env = environment(binary)
    env.pop('DISPLAY', None)
    env.pop('WAYLAND_DISPLAY', None)
    with tempfile.TemporaryDirectory(prefix='cpld-diamond-check-') as tmp:
        script = Path(tmp) / 'check.tcl'
        script.write_text('exit 0\n', encoding='utf-8')
        try:
            result = subprocess.run([str(binary), script.name], cwd=tmp, env=env,
                                    stdin=subprocess.DEVNULL, capture_output=True,
                                    text=True, errors='replace', timeout=30)
        except subprocess.TimeoutExpired as exc:
            raise BuildError(f'Diamond startup timed out after 30 seconds: {binary}; check the installation and license') from exc
    output = result.stdout + result.stderr
    if result.returncode:
        raise BuildError(f'Diamond startup failed (exit {result.returncode}): {binary}\n{output[-1800:]}')
    if version is None:
        print('Diamond installation version unavailable; the full version will be checked in each build log.')


def run(script: Path, log: Path, *, reset_project: Callable[[], None] | None = None) -> str:
    """Run Tcl without a display or stdin, preserving output even on failure."""
    binary = launcher()
    env = environment(binary)
    env.pop('DISPLAY', None); env.pop('WAYLAND_DISPLAY', None)
    # The flushed marker precedes every project command. Only retry a native
    # startup segfault unless preparation provides a clean project reset.
    marked = script.read_text().startswith(STARTUP_PREAMBLE)
    for attempt in range(2):
        attempt_log = log if attempt == 0 else log.with_name(f'{log.stem}-retry1{log.suffix}')
        with attempt_log.open('w') as stream:
            result = subprocess.run([str(binary), script.name], cwd=script.parent,
                                    env=env, stdin=subprocess.DEVNULL, stdout=stream, stderr=subprocess.STDOUT)
        output = attempt_log.read_text(errors='replace')
        if attempt:
            # Keep the normal build-log path useful to provenance/report readers.
            with log.open('a') as stream:
                stream.write(f'\nDiamond retry: {attempt_log.name}\n{output}')
        if not result.returncode:
            return output
        if result.returncode == -signal.SIGSEGV and reset_project is not None:
            # Preserve the native failure before reset_project removes vendor state.
            # Core dumps are handled separately by the diagnostic workflow.
            snapshot = attempt_log.with_name(attempt_log.stem + '-crash')
            shutil.copytree(script.parent, snapshot, symlinks=True,
                            ignore=None if os.environ.get('CPLD_DIAMOND_KEEP_CORES') == '1'
                            else shutil.ignore_patterns('core', 'core.*'))
        if (attempt == 0 and marked and result.returncode == -signal.SIGSEGV
                and (STARTUP_MARKER not in output or reset_project is not None)):
            if reset_project is not None:
                reset_project()
            phase = 'during project preparation' if reset_project is not None else 'before Tcl startup'
            print(f'Diamond segfaulted {phase}; retrying once. First log: {log}', file=sys.stderr)
            continue
        reason = ' (SIGSEGV)' if result.returncode == -signal.SIGSEGV else ''
        raise BuildError(f'Diamond exited {result.returncode}{reason}; see {attempt_log}\n{output[-1800:]}')


def synthesis_options(build: Build) -> dict:
    """Select the VHDL standard option for the chosen Diamond engine."""
    key = "lse_vhdl2008" if build.synthesis == "lse" else "syn_vhdl2008"
    return dict(build.options, **{key: "True" if build.standard == "2008" else "False"})


def preparation_commands(build: Build, project: Path, *, close_project: bool = True) -> list[str]:
    """Share the production project commands with the isolated CI reproducer."""
    relative = lambda p: tcl(os.path.relpath(p, project))
    lines = [f'prj_project new -name firmware -impl impl -impl_dir impl -dev {tcl(build.device)} -lpf constraints.lpf',
             f'prj_syn set {build.synthesis}',
             'prj_strgy import -name baseline -file baseline.sty', 'prj_strgy set baseline']
    for source in build.sources:
        lines.append(f'prj_src add -format VHDL -work {tcl(source.library)} {relative(source.path)}')
    for key, value in sorted(synthesis_options(build).items()):
        lines.append(f'prj_strgy set_value {tcl(key + "=" + value)}')
    return lines + ['prj_project save'] + (['prj_project close'] if close_project else [])


class DiamondBackend:
    """Prepare relocatable projects and request both firmware export tasks."""

    def prepare(self, build: Build, project: Path, log: Path):
        """Reference authored HDL and a generated LPF containing the build identity."""
        project.mkdir(parents=True, exist_ok=True)
        shutil.copy2(build.strategy, project / 'baseline.sty')
        from ..identity import constraint_text, validate_identity
        identity = validate_identity(build, json.loads((project.parent / 'metadata/identity.json').read_text()))
        (project / 'constraints.lpf').write_text(constraint_text(build, identity))
        script = project / 'prepare.tcl'
        # Temporary CI experiment; normal builds retain explicit project close.
        script.write_text(wrap(preparation_commands(
            build, project, close_project=os.environ.get('CPLD_DIAMOND_SKIP_PREPARE_CLOSE') != '1')))
        # Discard partial vendor state before retrying preparation. Identity and
        # logs live outside this generated directory and must be retained.
        inputs = {name: (project / name).read_bytes()
                  for name in ('baseline.sty', 'constraints.lpf', 'prepare.tcl')}

        def reset_project():
            shutil.rmtree(project)
            project.mkdir()
            for name, contents in inputs.items():
                (project / name).write_bytes(contents)

        run(script, log, reset_project=reset_project)
        if not (project / 'firmware.ldf').is_file():
            raise BuildError(f'Diamond did not create a project; see {log}')
        # Diamond exposes def_top as internal-only in Tcl. Store it in its LDF schema.
        ldf = project / 'firmware.ldf'
        tree = ET.parse(ldf)
        implementation = tree.getroot().find('Implementation')
        opts = implementation.find('Options')
        if opts is None:
            opts = ET.SubElement(implementation, 'Options')
        opts.set('def_top', build.top)
        tree.write(ldf, encoding='UTF-8', xml_declaration=True)

    def build(self, project: Path, log: Path) -> str:
        """Run synthesis through PAR, timing reporting and both export tasks."""
        lines = ['prj_project open firmware.ldf', 'prj_run Synthesis -impl impl',
                 'prj_run Translate -impl impl', 'prj_run Map -impl impl',
                 'prj_run Map -impl impl -task MapVerilogSimFile',
                 'set mapped_files [glob impl/*.vo]',
                 'if {[llength $mapped_files] != 1} {error "Expected one mapped Verilog simulation netlist"}',
                 'file copy -force [lindex $mapped_files 0] impl/comparison_mapped.v',
                 'prj_run PAR -impl impl', 'prj_run PAR -impl impl -task PARTrace',
                 'prj_run Export -impl impl -task TimingSimFileVlg',
                 'prj_run Export -impl impl -task Bitgen',
                 'prj_run Export -impl impl -task Jedecgen', 'prj_project close']
        script = project / 'build.tcl'
        script.write_text(wrap(lines))
        return run(script, log)


def wrap(lines: list[str], *, trace: bool | None = None) -> str:
    """Mark Tcl startup, then turn Tcl errors into a nonzero process exit."""
    if trace is None:
        trace = os.environ.get('CPLD_DIAMOND_TRACE') == '1'
    commands = []
    for index, line in enumerate(lines, 1):
        label = f'{index}: {line}'
        if trace:
            commands += [f'puts {tcl("UZ_CPLD_DIAMOND_BEFORE " + label)}', 'flush stdout']
        commands.append(line)
        if trace:
            commands += [f'puts {tcl("UZ_CPLD_DIAMOND_AFTER " + label)}', 'flush stdout']
    ending = 'puts "UZ_CPLD_DIAMOND_BEFORE_EXIT"\nflush stdout\n' if trace else ''
    return STARTUP_PREAMBLE + 'if {[catch {\n' + '\n'.join(commands) + '\n} message]} {\nputs stderr $message\nexit 1\n}\n' + ending + 'exit 0\n'
