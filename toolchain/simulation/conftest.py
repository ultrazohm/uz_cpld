from pathlib import Path
from toolchain.buildsystem.model import catalog


def pytest_addoption(parser):
    parser.addoption("--program", help="Program directory name; defaults to the catalog")
    parser.addoption("--seed", type=int, default=1)
    parser.addoption("--wave-format", choices=("vcd", "ghw", "fst"), default="vcd")


def pytest_generate_tests(metafunc):
    if "program" in metafunc.fixturenames:
        selected = metafunc.config.getoption("--program")
        metafunc.parametrize("program", [selected] if selected else
                             catalog(Path(__file__).resolve().parents[2]))
