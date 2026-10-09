from pathlib import Path
from cpld_toolchain.toolchain.buildsystem.model import discover_programs, resolve_release, program_targets, BuildError


def pytest_addoption(parser):
    parser.addoption("--release-cycle", dest="release_cycle")
    parser.addoption("--program", help="Program directory name; defaults to every program manifest")
    parser.addoption("--target", help="Select or filter a board target")
    parser.addoption("--seed", type=int, default=1)
    parser.addoption("--wave-format", choices=("vcd", "ghw", "fst"), default="vcd")


def pytest_generate_tests(metafunc):
    if "program" in metafunc.fixturenames:
        selected = metafunc.config.getoption("--program")
        root = Path(__file__).resolve().parents[3]
        cycle = resolve_release(root, metafunc.config.getoption('release_cycle'))
        names = [selected] if selected else discover_programs(root, cycle)
        target = metafunc.config.getoption('--target')
        if target:
            names = [name for name in names if target in program_targets(root, name, cycle)]
            if not names:
                raise BuildError(f'No programs match target {target} in release {cycle}')
        metafunc.parametrize("program", [f'{cycle}/{name}' for name in names],
                             ids=[f'{cycle}-{name}' for name in names])
