Tools and execution environments
================================

Use ``uz_cpld ACTION`` in the activated environment from the repository root on Linux or Windows.
The Makefile is an optional Linux wrapper around the same commands.

What each environment provides
------------------------------

.. list-table:: Environment definitions
   :header-rows: 1
   :widths: 18 42 40

   * - Environment
     - Provides
     - Still needs
   * - Native Python
     - Runs the repository CLI with the host's Python installation.
     - Python 3.10+, the Python dependencies for the chosen workflow, and any external tools.
   * - Repository venv
     - Isolated native Python packages: the editable project plus all simulation, analysis and documentation packages, installed by ``python -m cpld_toolchain setup``.
     - Diamond, licenses, USB drivers/libraries and any additional simulation or documentation tools.
   * - Docker toolchain image
     - Linux amd64 Python environment, simulation/analysis packages, GHDL, FOSS binaries, Graphviz, Sphinx and Diamond runtime libraries.
     - A separately installed Linux Diamond and license for Diamond work; USB exposure for hardware access.
   * - VS Code Dev Container
     - A persistent development session using the same Docker image and the mounted checkout.
     - The optional Diamond mount, or USB configuration, when the workflow requires them.

**A venv is still native execution.**
It isolates Python packages; it does not contain a different operating system, install Diamond, or expose USB hardware.
Native Python and venv execution have the same external tool requirements.
Commands always use the calling environment.
The container already has its Python dependencies, so a venv is not required inside it.

Workflow matrix
---------------

In the table, **included** means supplied by the repository's image or venv setup.
**Additional setup** means the code can use locally installed tools, but those tools are not installed by ``setup``.
The Docker column describes execution *inside a running container*; start that container explicitly.

Native Windows entries describe implemented support.
Windows CI has been configured, but a successful Windows CI run and real Diamond/USB validation are not established by the Linux regression results.
Native Windows FOSS hardware programming, simulation and analysis integrations are outside the current validation scope.
The separate FOSS programmer CI job compiles the patched Windows loader and runs native tests without USB; it does not validate drivers or physical programming.
Tool availability also does not establish hardware equivalence or timing acceptance; the FOSS MachXO2 flow remains experimental.
See :doc:`windows`, :doc:`foss` and :doc:`validation` for the limits.

.. list-table:: Workflows, tools and environments
   :header-rows: 1
   :widths: 19 23 15 15 14 14

   * - Workflow / CLI action
     - Tools used
     - Native Linux
     - Native Windows
     - Repository venv
     - Docker / Dev Container
   * - Environment inventory: ``doctor``
     - Python; bounded version checks for discovered non-vendor CLI tools
     - Reports installed and missing tools
     - Same reporting behavior
     - Reports packages in the active interpreter
     - Reports tools inside the image
   * - VHDL generation: ``new --template generator``, ``generate``; standalone ``cpld-vhdl-generator``
     - Python, generator and shared HDL
     - Available
     - Implemented
     - Python dependencies included
     - Python dependencies included
   * - Catalog, releases, source checks, identities and selections: ``list``, ``check``, ``release_*``, ``usercodes*``, ``init_programmer``, ``report``, ``clean*``
     - Repository Python modules
     - Available
     - Implemented
     - Python dependencies included
     - Python dependencies included
   * - Diamond firmware: ``project``, ``build``, ``build_all``, ``build_selection``
     - Diamond CLI, runtime libraries and license
     - Additional Linux Diamond setup
     - Implemented with Windows Diamond
     - Python dependencies included; Diamond remains external
     - Mount Linux Diamond and provide its license
   * - Diamond GUI: ``gui``
     - Diamond GUI and display access
     - Additional Diamond/display setup
     - Windows launcher implemented
     - Diamond remains external
     - Requires mounted Diamond, license and separately configured GUI display forwarding
   * - FOSS firmware: ``build --backend foss``, ``build_all --backend foss``, ``build_selection --backend foss``
     - GHDL, pinned Yosys, nextpnr-machxo2 and Trellis toolchain
     - Additional pinned tool installation
     - Use the Linux container workflow
     - FOSS tools not included
     - Compiled toolchain included
   * - Export Programmer projects: ``diamond_xcf_programming_chain``
     - Python, current Diamond firmware and build receipts; no USB access
     - Available with matching builds
     - Implemented with matching builds
     - Python dependencies included
     - Available with matching builds
   * - Diamond hardware: ``scan``, ``identify``, ``program``
     - Diamond Programmer, host cable driver; Linux helper also uses libusb
     - Additional Diamond/USB setup
     - Implemented; validate vendor driver and FTUSB mapping on the station
     - Python dependencies included; vendor tools and USB access remain external
     - Mount Diamond/license and expose USB with permissions
   * - FOSS hardware: ``scan``, ``identify``, ``program`` with ``--programmer-backend foss``
     - openFPGALoader for scans; verified patched openFPGALoader for identity and programming
     - Additional native tools and USB setup
     - Outside current validation scope
     - Native tools and USB access not included
     - Tools included; expose USB with permissions
   * - HDL simulation: ``sim``
     - GHDL, cocotb, pytest and pytest-xdist
     - Additional tools/packages
     - Use the Linux container workflow
     - Python dependencies included; GHDL installed separately
     - Included
   * - RTL diagrams: ``netlist``
     - GHDL, Yosys and Graphviz
     - Additional tools
     - Use the Linux container workflow
     - Analysis tools not included
     - Included
   * - Program documentation: ``docs_assets``, ``docs``
     - Simulation/RTL tools and analysis packages; ``docs`` also runs Sphinx
     - Additional tools/packages
     - Use the Linux container workflow
     - Python dependencies included; HDL tools and Graphviz installed separately
     - Included
   * - Tooling regressions: ``test``
     - unittest plus dependencies used by the selected tests
     - Broader suite; needs Make/Bash and additional analysis/simulation dependencies for its integrations
     - Native Python subset, without Make/Bash/Linux HDL integrations
     - Python packages included; native test tools installed separately
     - Broader Linux suite uses included tools
   * - Build patched flasher: ``flasher_build``
     - Linux compiler, development libraries and pinned sources
     - Additional development dependencies
     - Native action rejected; use a Linux environment
     - Compiler/development dependencies not included
     - Compiled flasher included; rebuilding it requires additional development dependencies

``diamond_xcf_programming_chain --rebuild 1`` also runs Diamond builds, so it needs the Diamond installation and license.
Without ``--rebuild 1``, exporting an XCF uses existing, current build evidence and does not launch Diamond.

The shared ``xo2_library`` VHDL itself has no dependency on Python, the venv, Docker or this build system.
Compile it with the HDL tools used by the consuming project.
Opening already generated HTML documentation also does not require the build toolchain.

Execution environment
---------------------

Commands run in the calling environment on native Windows, Ubuntu and inside containers.
They use installed tools and report missing dependencies; they never start Docker or Podman automatically.
Backend selection is independent: ``--backend diamond`` is the default and ``--backend foss`` opts into FOSS.

``uz_cpld image`` explicitly builds the toolchain image but does not start a shell.
Reopen the workspace in a Dev Container or use the manual Docker commands in :doc:`environments` before running workflows with the container's tools.
``python -m cpld_toolchain setup`` installs native Python dependencies and opens an activated shell when interactive.
``doctor`` reports the environment in which it is invoked.

Choose a USB profile when the container needs hardware access.
On Windows, Docker runs the Linux image; native Windows Diamond cannot serve as the Linux Diamond installation inside that image.
Hardware forwarding into the Docker VM is separate from native Windows driver access.

Build and programmer backends
-----------------------------

.. list-table:: Firmware/programmer combinations
   :header-rows: 1
   :widths: 25 25 50

   * - Build backend
     - Programmer backend
     - Result
   * - Diamond
     - Diamond
     - Programs current Diamond JEDEC exports.
   * - Diamond
     - FOSS
     - Programs current Diamond JEDEC exports with the verified patched loader and identity reader.
   * - FOSS
     - FOSS
     - Programs current FOSS bitstreams with the verified patched loader and identity reader.
   * - FOSS
     - Diamond
     - Unsupported; rejected before programming.

``--backend`` sets both defaults; ``--build-backend`` and ``--programmer-backend`` override them separately.
Local programming requires current successful builds and does not build firmware automatically.
``program --source zip --firmware PATH.zip`` instead validates a published release package without local builds; its manifest determines the firmware backend.
A command preview using ``--dry-run 1`` starts no vendor tools and contacts no hardware; it does not demonstrate that the required tools, builds or hardware are available.

Setup entry points
------------------

For generation and native Diamond work, start with::

   python -m cpld_toolchain setup
   # Configure Diamond and its license separately.
   uz_cpld doctor
   uz_cpld build_all

For the bundled simulation, FOSS and documentation tools, start with::

   uz_cpld image
   docker run --rm -it --mount "type=bind,source=$PWD,target=/work" -w /work uz-cpld-toolchain bash
   # Run the following commands inside that Linux container.
   uz_cpld sim --program cvg_tx30 --release-cycle heartbeat_cvg
   uz_cpld build --program cvg_tx30 --release-cycle heartbeat_cvg --backend foss
   uz_cpld docs

See :doc:`environments` for Linux tools, container mounts and USB permissions; :doc:`windows` for native Windows setup; :doc:`foss` for pinned native FOSS tools; and :doc:`commands` for the complete command contract.
Setup includes Python packages for native Linux analysis and simulation; GHDL, Yosys, Graphviz and other external executables must still be installed separately.

Command availability
--------------------

The repository CLI exposes the full command set; execution checks the prerequisites of the chosen workflow.
Missing simulation or documentation tools do not prevent help, catalog listing or programmer selection initialization.
The :doc:`standalone` application bundles Python and exposes only the programming workflow, using the system Diamond Programmer.
See :doc:`architecture` for module boundaries.
