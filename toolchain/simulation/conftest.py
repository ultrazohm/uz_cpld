from pathlib import Path
from toolchain.buildsystem.model import discover_programs, resolve_release


def pytest_addoption(parser):
    parser.addoption("--release-cycle", "--release_cycle", dest="release_cycle")
    parser.addoption("--program", help="Program directory name; defaults to every program manifest")
    parser.addoption("--seed", type=int, default=1)
    parser.addoption("--wave-format", choices=("vcd", "ghw", "fst"), default="vcd")


def pytest_generate_tests(metafunc):
    if "program" in metafunc.fixturenames:
        selected = metafunc.config.getoption("--program")
        root = Path(__file__).resolve().parents[2]
        cycle = resolve_release(root, metafunc.config.getoption('release_cycle'))
        names = [selected] if selected else discover_programs(root, cycle)
        metafunc.parametrize("program", [f'{cycle}/{name}' for name in names],
                             ids=[f'{cycle}-{name}' for name in names])
