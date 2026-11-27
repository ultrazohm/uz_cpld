Python programmer distribution
==============================

One package is published to PyPI: ``ultrazohm-cpld-user``.
Its platform wheels bundle the application and FOSS programmer together.
The public interface programs existing firmware only; the checkout retains its current native Windows Diamond and dev-container workflows.
Further separation of developer interfaces is follow-up work.

Package layout
--------------

``distribution/wheels.py`` stages an isolated setuptools project without changing the root developer ``pyproject.toml`` or lockfile.
The user wheel has console and GUI entry points, the bundled native programmer, and a certificate dependency.
Shared internal workflow modules remain in that wheel for now, but developer commands are not exported and developer dependencies are not installed.
Tests, program catalogs, firmware binaries and native compilation tools are excluded.
Native assets live inside ``cpld_toolchain/bundled_tools`` with provenance, licenses and corresponding sources/relinking materials.
The installed application uses the same asset layout as the Windows standalone.
Explicit executable overrides still take precedence over packaged tools.

The user wheels target ``win_amd64`` and ``manylinux_2_28_x86_64``, matching the Windows/Linux x64 scope and Linux glibc floor used by ultrazohm_sw.
The package requires Python 3.12+.
Use a tested uv-managed Python 3.12 for the GUI; an arbitrary Python installation may omit Tcl/Tk.
Unsupported architectures have no user wheel and must not silently fall back to compiling it during installation.

Build and test
--------------

Install ``build==1.3.0`` in a packaging environment.
Every wheel build requires native artifacts from the same source commit, passing the existing provenance checks.
For Windows, use the artifacts from the FOSS programmer workflow::

   python distribution/wheels.py user --version 0.6.0.dev1 --platform win_amd64 --loader build/portable-loader --drivers build/windows-drivers

For Linux, build ``distribution/manylinux.Dockerfile`` and run ``distribution/loader.py`` inside it.
That image builds against glibc 2.28, collects corresponding RPM sources/notices, checks symbol requirements and executes native protocol tests before allowing the platform tag::

   python distribution/wheels.py user --version 0.6.0.dev1 --platform manylinux_2_28_x86_64 --loader build/portable-loader

Install the wheel for your platform in a fresh environment and run ``distribution/wheel_smoke.py --python PATH_TO_ENV_PYTHON``.
Add ``--gui`` on Windows or under Xvfb on Linux to exercise the actual window and worker startup.
The same Windows user wheel is installed before PyInstaller builds.
There is no Linux standalone build.

Publication
-----------

``toolchain.yml`` publishes only on pushes to ``feature/add_heartbeat``.
Versions are ``0.6.0.dev<RUN_ID><ATTEMPT_PADDED_TO_THREE_DIGITS>``; rerunning the version/build jobs generates a new prerelease version.
Rerunning publication alone reuses the version recorded in the tested wheels.
Publication rejects incomplete wheel sets, mixed versions and artifacts from another source commit before uploading.
There is no stable PyPI publication path yet.
Python package validation and Windows standalone tests gate publication independently of licensed firmware compilation.
Firmware remains a separate GitHub release artifact and downloads default to stable releases even when the application is a prerelease.

Configure one PyPI Trusted Publisher (or a pending publisher before the first release):

* Project: ``ultrazohm-cpld-user``.
* GitHub owner: ``ultrazohm``.
* Repository: ``uz_cpld``.
* Workflow filename: ``toolchain.yml``.
* GitHub environment: ``pypi``.

Existing permission to publish ultrazohm-dataviewer does not automatically configure this new project.
Both platform wheels upload to that project using GitHub OIDC rather than a stored API token.
After publication CI installs the exact version from PyPI and runs the programmer diagnostic.
Source provenance, dependency notices and relinking materials remain in each user wheel.

Windows driver setup is an explicit operation with native UAC elevation.
Linux setup installs udev rules with sudo.
Neither importing nor installing a wheel changes host driver state.
