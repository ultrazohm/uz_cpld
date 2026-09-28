"""Compile the actual catalog sources and execute cocotb via pytest."""
import hashlib
from importlib.metadata import version
import json
from pathlib import Path
import shutil
import subprocess
import sys
import xml.etree.ElementTree as ET

from cocotb_tools.runner import get_runner

from toolchain.buildsystem.model import BuildError, load_build
from toolchain.buildsystem.ghdl import analyze_sources
from toolchain.buildsystem.workflow import locked, safe_directory

ROOT = Path(__file__).resolve().parents[2]


def test_routing(program, request):
    """Compile manifest HDL, execute routing contracts and retain waveforms.

    ``program`` is selected by the pytest fixture in ``toolchain.simulation.conftest``;
    ``request`` supplies the seed and waveform format from command-line options.
    Results are written beneath ``programs/<release_cycle>/<program>/build/simulation``.
    """
    build = load_build(ROOT, program)
    with locked(build):
        run_simulation(build, request)


def run_simulation(build, request):
    """Run one program while its caller holds the generated-output lock."""
    program = build.name
    output = safe_directory(build, build.build_root / "simulation")
    # GHDL libraries retain design units removed from a manifest. Recreate the
    # whole directory so elaboration can only use this run's declared sources.
    if output.exists():
        shutil.rmtree(output)
    output.mkdir(parents=True, exist_ok=True)
    metadata = safe_directory(build, output / 'metadata')
    metadata.mkdir(exist_ok=True)
    seed = request.config.getoption("--seed")
    wave_format = request.config.getoption("--wave-format")
    standard = {"1993": "93", "2008": "08"}[build.standard]
    inputs = tuple(dict.fromkeys((*build.inputs, build.root / 'toolchain/hdl/machxo2_empty.vhdl')))
    before = {str(path.relative_to(build.root)): hashlib.sha256(path.read_bytes()).hexdigest()
              for path in inputs}
    provenance = {
        "program": program, "release_cycle": build.release_cycle, "seed": seed, "standard": build.standard,
        "python": sys.version,
        "cocotb": version("cocotb"), "pytest": version("pytest"),
        "wave_format": wave_format, "inputs": before,
        "testbench": {str(build.testbench.relative_to(ROOT)):
                      hashlib.sha256(build.testbench.read_bytes()).hexdigest()},
        "ghdl": subprocess.check_output(["ghdl", "--version"], text=True),
        "sources": {str(s.path.relative_to(ROOT)):
                    hashlib.sha256(s.path.read_bytes()).hexdigest()
                    for s in build.sources},
    }
    (metadata / "run.json").write_text(json.dumps(provenance, indent=2) + "\n")
    runner = get_runner("ghdl")
    library_args = analyze_sources(ROOT, build.sources, output, standard)
    runner.build(
        # analyze_sources has already compiled every library in manifest order.
        sources=[], hdl_library="work",
        hdl_toplevel=build.top.lower(), build_args=[f"--std={standard}", *library_args],
        build_dir=output, always=True, log_file=output / "compile.log",
    )
    wave = output / f"waves.{wave_format}"
    trace_args = [f"--vcd={output / 'waves.vcd'}"]
    if wave_format != "vcd":
        trace_args.append(f"--{'wave' if wave_format == 'ghw' else 'fst'}={wave}")
    runner.test(
        hdl_toplevel=build.top.lower(), hdl_toplevel_library="work",
        hdl_toplevel_lang="vhdl", test_module=".".join(build.testbench.relative_to(ROOT).with_suffix('').parts),
        test_args=[f"--std={standard}", *library_args],
        plusargs=trace_args + ["--assert-level=error"],
        seed=seed,
        log_file=output / "simulation.log",
    )
    assert wave.is_file() and wave.stat().st_size > 0
    assert (output / "waves.vcd").stat().st_size > 0
    cases = [case for result in output.glob('*.result.xml')
             for case in ET.parse(result).iter('testcase')]
    assert cases, 'Cocotb produced no test result metadata'
    if before != {str(path.relative_to(build.root)): hashlib.sha256(path.read_bytes()).hexdigest()
                  for path in inputs}:
        raise BuildError('Simulation inputs changed during the run; rerun simulation')
    provenance['simulation_duration_ns'] = sum(float(case.attrib['sim_time_ns']) for case in cases)
    (metadata / 'run.json').write_text(json.dumps(provenance, indent=2) + '\n')
