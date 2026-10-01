"""Generate and execute Diamond Tcl using the vendor environment wrapper."""
import os
import json
from pathlib import Path
import shutil
import subprocess
import xml.etree.ElementTree as ET
from ..model import Build, BuildError
from toolchain.diamond import executable, environment


def tcl(value: str) -> str:
    """Quote one Tcl word without allowing variable or command substitution."""
    return '"' + str(value).replace('\\', '\\\\').replace('"', '\\"').replace('$', '\\$').replace('[', '\\[').replace(']', '\\]').replace('\n', '\\n').replace('\r', '\\r') + '"'


def launcher(gui: bool = False) -> Path:
    """Find a configurable vendor launcher; overrides are executable paths."""
    return executable('gui' if gui else 'cli')


def run(script: Path, log: Path) -> str:
    """Run Tcl without a display or stdin, preserving output even on failure."""
    binary = launcher()
    env = environment(binary)
    env.pop('DISPLAY', None); env.pop('WAYLAND_DISPLAY', None)
    with log.open('w') as stream:
        result = subprocess.run([str(binary), script.name], cwd=script.parent,
                                env=env, stdin=subprocess.DEVNULL, stdout=stream, stderr=subprocess.STDOUT)
    output = log.read_text(errors='replace')
    if result.returncode:
        raise BuildError(f'Diamond exited {result.returncode}; see {log}\n{output[-1800:]}')
    return output


def synthesis_options(build: Build) -> dict:
    """Select the VHDL standard option for the chosen Diamond engine."""
    key = "lse_vhdl2008" if build.synthesis == "lse" else "syn_vhdl2008"
    return dict(build.options, **{key: "True" if build.standard == "2008" else "False"})


class DiamondBackend:
    """Prepare relocatable projects and request both firmware export tasks."""

    def prepare(self, build: Build, project: Path, log: Path):
        """Reference authored HDL and a generated LPF containing the build identity."""
        project.mkdir(parents=True, exist_ok=True)
        shutil.copy2(build.strategy, project / 'baseline.sty')
        from ..identity import constraint_text, validate_identity
        identity = validate_identity(build, json.loads((project.parent / 'metadata/identity.json').read_text()))
        (project / 'constraints.lpf').write_text(constraint_text(build, identity))
        relative = lambda p: tcl(os.path.relpath(p, project))
        lines = [f'prj_project new -name firmware -impl impl -impl_dir impl -dev {tcl(build.device)} -lpf constraints.lpf',
                 f'prj_syn set {build.synthesis}',
                 'prj_strgy import -name baseline -file baseline.sty', 'prj_strgy set baseline']
        for source in build.sources:
            lines.append(f'prj_src add -format VHDL -work {tcl(source.library)} {relative(source.path)}')
        options = synthesis_options(build)
        for key, value in sorted(options.items()):
            lines.append(f'prj_strgy set_value {tcl(key + "=" + value)}')
        lines += ['prj_project save', 'prj_project close']
        script = project / 'prepare.tcl'
        script.write_text(wrap(lines))
        run(script, log)
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
                 'prj_run PAR -impl impl', 'prj_run PAR -impl impl -task PARTrace',
                 'prj_run Export -impl impl -task Bitgen',
                 'prj_run Export -impl impl -task Jedecgen', 'prj_project close']
        script = project / 'build.tcl'
        script.write_text(wrap(lines))
        return run(script, log)


def wrap(lines: list[str]) -> str:
    """Turn Tcl errors into a nonzero process exit."""
    return 'if {[catch {\n' + '\n'.join(lines) + '\n} message]} {\nputs stderr $message\nexit 1\n}\nexit 0\n'
