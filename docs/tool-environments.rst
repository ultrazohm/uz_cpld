Tools and execution environments
================================

Use ``python -m toolchain ACTION`` from the repository root on Linux or
Windows. The Makefile is an optional Linux wrapper around the same commands.
This page separates the Python environment, the external tools, and the
choice of where a command executes.

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
     - Isolated native Python packages: the editable VHDL generator and TOML parser where needed, installed by ``python -m toolchain venv``.
     - Diamond, licenses, USB drivers/libraries and any additional simulation or documentation tools.
   * - Docker toolchain image
     - Linux amd64 Python environment, simulation/analysis packages, GHDL, FOSS binaries, Graphviz, Sphinx and Diamond runtime libraries.
     - A separately installed Linux Diamond and license for Diamond work; USB exposure for hardware access.
   * - VS Code Dev Container
     - A persistent development session using the same Docker image and the mounted checkout.
     - The optional Diamond mount, or USB configuration, when the workflow requires them.

**A venv is still native execution.** It isolates Python packages; it does
not contain a different operating system, install Diamond, or expose USB
hardware. Native Python and venv execution have the same external tool
requirements. Creating or activating a venv does not change runner defaults.
The container already has its Python dependencies, so a venv is not required
inside it.

Workflow matrix
---------------

In the table, **included** means supplied by the repository's image or venv
setup. **Additional setup** means the code can use locally installed tools,
but those tools are not installed by ``venv``. The Docker column describes
execution *inside a running container*; automatic container launching is
covered in the next section.

Native Windows entries describe implemented support. Windows CI has been
configured, but a successful Windows CI run and real Diamond/USB validation
are not established by the Linux regression results. Native Windows FOSS,
simulation and analysis integrations are outside the current validation scope.
Tool availability also does not establish hardware equivalence or timing
acceptance; the FOSS MachXO2 flow remains experimental. See :doc:`windows`,
:doc:`foss` and :doc:`validation` for the limits.

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
   * - Catalog, releases, source checks, identities and selections: ``list``, ``check``, ``release-*``, ``usercodes*``, ``init``, ``report``, ``clean*``
     - Repository Python modules
     - Available
     - Implemented
     - Python dependencies included
     - Python dependencies included
   * - Diamond firmware: ``project``, ``build``, ``build-all``
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
   * - FOSS firmware: ``build --backend foss``, ``build-all --backend foss``
     - GHDL, pinned Yosys, nextpnr-machxo2 and Trellis toolchain
     - Additional pinned tool installation
     - Use the Linux container workflow
     - FOSS tools not included
     - Compiled toolchain included
   * - Export Programmer projects: ``programmer-project``
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
     - openFPGALoader for scans; OpenOCD for identity; verified patched loader plus identity reader for programming
     - Additional native tools and USB setup
     - Outside current validation scope
     - Native tools and USB access not included
     - Tools included; expose USB with permissions
   * - HDL simulation: ``sim``
     - GHDL, cocotb, pytest and pytest-xdist
     - Additional tools/packages; use ``--runner local``
     - Use the Linux container workflow
     - Simulation dependencies not included
     - Included
   * - RTL diagrams: ``netlist``
     - GHDL, Yosys and Graphviz
     - Additional tools; use ``--runner local``
     - Use the Linux container workflow
     - Analysis tools not included
     - Included
   * - Program documentation: ``docs-assets``, ``docs``
     - Simulation/RTL tools and analysis packages; ``docs`` also runs Sphinx
     - Additional tools/packages; use ``--runner local``
     - Use the Linux container workflow
     - Documentation dependencies not included
     - Included
   * - Tooling regressions: ``test``
     - unittest plus dependencies used by the selected tests
     - Broader suite; needs Make/Bash and additional analysis/simulation dependencies for its integrations
     - Native Python subset, without Make/Bash/Linux HDL integrations
     - Windows subset covered; Linux broader suite needs additional dependencies
     - Broader Linux suite uses included tools
   * - Build patched flasher: ``flasher-build``
     - Linux compiler, development libraries and pinned sources
     - Additional development dependencies
     - Native action rejected; use a Linux environment
     - Compiler/development dependencies not included
     - Compiled flasher included; rebuilding it requires additional development dependencies

``programmer-project --rebuild 1`` also runs Diamond builds, so it needs the
Diamond installation and license. Without ``--rebuild 1``, exporting an XCF
uses existing, current build evidence and does not launch Diamond.

The shared ``xo2_library`` VHDL itself has no dependency on Python, the venv,
Docker or this build system. Compile it with the HDL tools used by the consuming
project. Opening already generated HTML documentation also does not require
the build toolchain.

When does a container start?
----------------------------

``--runner auto`` is the default. Backend selection is separate:
``--backend diamond`` is the default and ``--backend foss`` opts into FOSS.
On either a native Linux or Windows host, the following routing applies.
An activated venv does not alter it.

.. list-table:: Default runner behavior
   :header-rows: 1
   :widths: 45 55

   * - Command
     - Default execution
   * - ``doctor`` (either backend)
     - Reports the current environment; use ``--runner container`` to inspect the image explicitly.
   * - Plain ``build-all`` or ``build --program NAME``
     - Local Diamond; no new container starts.
   * - FOSS ``build``, ``build-all`` or ``project``
     - Starts a temporary toolchain container on the host.
   * - ``sim``, ``netlist``, ``docs``, ``docs-assets``
     - Starts a temporary toolchain container on the host.
   * - ``test``
     - Local tests; ``--runner container`` explicitly selects the image.
   * - Generator, catalog, release, selection, XCF export and USB commands
     - Local execution. Generic ``--runner container`` is not supported for these actions.
   * - ``image``
     - Asks Docker/Podman to build the image; it does not enter a development shell.
   * - ``venv``
     - Installs native Python dependencies and opens an activated shell when interactive.

Inside the configured image or Dev Container, commands use the existing
environment instead of starting nested containers. Therefore, a command that
cannot use the generic host container runner can still run *inside* a manually
started, correctly configured container.

``--runner local`` uses tools installed in the current environment. It does
not install missing tools or silently switch backends. ``--runner container``
on a host supports FOSS firmware actions, simulation, analysis/documentation
and tests, plus ``doctor`` for either backend. Build the image first with ``python -m toolchain image``; normal
commands never rebuild it implicitly.

The generic runner mounts the checkout only. It does not forward Diamond or
USB devices. The default Dev Container can mount Diamond, but USB needs the
separate Linux USB profile or equivalent manual configuration. On Windows,
Docker still runs the Linux image; native Windows Diamond cannot serve as the
Linux Diamond installation inside that image. Hardware forwarding into the
Docker VM is separate from native Windows driver access.

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

``--backend`` sets both defaults; ``--build-backend`` and
``--programmer-backend`` override them separately. Programming requires current
successful builds and does not build firmware automatically. A command preview
using ``--dry-run 1`` starts no vendor tools and contacts no hardware; it does
not demonstrate that the required tools, builds or hardware are available.

Setup entry points
------------------

For generation and native Diamond work, start with::

   python -m toolchain venv
   # Configure Diamond and its license separately.
   python -m toolchain doctor
   python -m toolchain build-all

For the bundled simulation, FOSS and documentation tools, start with::

   python -m toolchain image
   python -m toolchain sim --program tx30
   python -m toolchain build --program tx30 --backend foss
   python -m toolchain docs

See :doc:`environments` for Linux tools, container mounts and USB permissions;
:doc:`windows` for native Windows setup; :doc:`foss` for pinned native FOSS
tools; and :doc:`commands` for the complete command contract. A venv can be
extended with the Python packages in ``docs/requirements.txt`` for native
Linux analysis and simulation, but GHDL, Yosys, Graphviz and other external
executables must still be installed separately.
