Developer guide
===============

Use this guide to change firmware, the generator, shared HDL or Python tooling.
Run commands from the repository root; use ``python3`` on Linux if ``python`` is unavailable.
For programming existing firmware, see :doc:`../user/index`.

Quick start reference
---------------------

The VS Code **Dev Containers: Reopen in Container** command builds and enters the development image.
It includes simulation, FOSS and documentation tools.
Diamond additionally requires an installation and license; see :doc:`../environments` for profiles and mounts.

For a manual Linux Docker session::

   python3 -m cpld_toolchain image
   docker run --rm -it --init --platform=linux/amd64 \
     --user "$(id -u):$(id -g)" \
     --mount "type=bind,source=$PWD,target=/work" -w /work \
     uz-cpld-toolchain bash

Inside the container::

   python3 -m cpld_toolchain doctor
   python3 -m cpld_toolchain check --program cvg_tx30 --release-cycle heartbeat_cvg
   python3 -m cpld_toolchain sim --program cvg_tx30 --release-cycle heartbeat_cvg
   python3 -m cpld_toolchain build --program cvg_tx30 --release-cycle heartbeat_cvg --backend foss
   python3 -m cpld_toolchain compare --program cvg_tx30 --release-cycle heartbeat_cvg --backend foss
   python3 -m cpld_toolchain test
   python3 -m cpld_toolchain docs --release-cycle all

Open ``docs/_build/html/index.html`` for the generated site.
``test`` runs tooling tests; ``sim`` runs program HDL testbenches.
The FOSS comparison above is the supported heartbeat pilot; Diamond comparison is unsupported.

For native Linux development with GHDL, Yosys and Graphviz installed::

   python3 -m cpld_toolchain setup --activate 0
   source .venv/bin/activate
   python -m cpld_toolchain doctor

The venv installs the ``uz_cpld`` console command, so ``uz_cpld ACTION`` can replace ``python -m cpld_toolchain ACTION`` in an activated environment.
Run setup again to synchronize dependencies with the committed lockfile.
Setup includes simulation, analysis and documentation Python dependencies; native HDL tools are installed separately.
Native Linux tooling tests also need Make and Bash; the managed Python includes Tcl support.
FOSS builds need the pinned tools in :doc:`../foss`.
See :doc:`../windows` for native Windows generation, Diamond workflows and the Windows test subset.

Python dependency maintenance
-----------------------------

``pyproject.toml`` defines package metadata and dependency groups; ``uv.lock`` locks the complete Python dependency graph.
``.python-version`` selects the setup interpreter independently of the Python used to launch setup.
The bootstrap version and archive checksums are recorded in ``cpld_toolchain/uv-bootstrap.json``.
After changing dependencies, use the repository-local uv executable under ``.tools/uv/`` to run ``uv lock`` and commit the resulting ``uv.lock``.
The container and native setup use the same interpreter pin, uv bootstrap manifest and lockfile.
Run setup again to verify that ``uv sync --locked --all-groups --managed-python`` succeeds.

Author a program
----------------

Create an independent release and a generator starter::

   python -m cpld_toolchain release-new --name my_release
   python -m cpld_toolchain new --name my_slot --template generator --release-cycle my_release
   # Edit programs/my_release/cvg_my_slot/routing.csv and generator.toml.
   python -m cpld_toolchain generate --program cvg_my_slot --release-cycle my_release
   python -m cpld_toolchain check --program cvg_my_slot --release-cycle my_release
   python -m cpld_toolchain sim --program cvg_my_slot --release-cycle my_release
   python -m cpld_toolchain build --program cvg_my_slot --release-cycle my_release

``release-new`` changes the tracked default release; use ``release-select --release-cycle NAME`` to select another.
The starter defaults to the static ``s3c_power_on_debounce_v1`` contract, VHDL-1993, LSE and Diamond-only builds.
For heartbeat receivers, set ``contract = "s3c_heartbeat_v1"`` before generation and use a compatible S3C controller.
Edit CSV/TOML inputs for generated projects; edit VHDL/LPF/testbench files for handwritten projects.
Commit program inputs, generated files and receipts, descriptions, catalogs, and ``programs/usercodes.json`` together.

Technical reference
-------------------

The following guides cover current interfaces, implementation and validation.
Program and release descriptions live beside their sources and appear in the generated program reference.

.. toctree::
   :maxdepth: 1

   ../quick-start
   ../commands
   ../tool-environments
   ../environments
   ../windows
   ../builds
   ../programmer
   ../firmware-identity
   ../s3c
   release-management
   ../foss
   ../simulation
   ../program-documentation
   ../configuration
   ../vhdl-generator
   ../xo2-library
   ../architecture
   ../validation
   ../publishing
   ../api
