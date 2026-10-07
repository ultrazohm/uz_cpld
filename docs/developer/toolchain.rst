Toolchain contribution
======================

Use this guide to change Python commands, the generator implementation, build backends, programmer support, documentation tooling or CI.
For writing program VHDL or using the generator, see :doc:`hdl`.
Run commands from the repository root.

Quick start reference
---------------------

For a native Python development environment::

   python3 -m cpld_toolchain setup --activate 0
   source .venv/bin/activate
   uz_cpld doctor
   uz_cpld test
   uz_cpld docs

Setup installs the locked Python dependencies and the editable project.
The broader Linux test suite and documentation generation also need native tools including Make, Bash, GHDL, Yosys and Graphviz.
Use ``python`` instead of ``python3`` where appropriate; Windows setup and its test subset are described in :doc:`../windows`.

For the bundled Linux tools, use **Dev Containers: Reopen in Container**, or start a manual container::

   uz_cpld image
   docker run --rm -it --init --platform=linux/amd64 \
     --user "$(id -u):$(id -g)" \
     --mount "type=bind,source=$PWD,target=/work" -w /work \
     uz-cpld-toolchain bash
   # Run inside the container.
   uz_cpld test
   uz_cpld docs

Open ``docs/_build/html/index.html`` after a successful documentation build.
``docs`` includes all releases by default; add ``--release-cycle heartbeat_cvg --program cvg_tx30`` for a focused preview.
A focused preview replaces the generated documentation with that scope; run ``uz_cpld docs`` to restore the complete site.
Diamond workflows additionally need an installation and license.

Where to contribute
-------------------

* ``cpld_toolchain/toolchain/commands.py`` defines CLI actions and the shared Make command contract.
* ``cpld_toolchain/toolchain/buildsystem/`` handles manifests, build backends, provenance and cleanup.
* ``cpld_toolchain/cpld_vhdl_generator/`` implements CSV/TOML validation and generated project files.
* ``cpld_toolchain/programmer_helper/`` handles selections, device identification and programming.
* ``cpld_toolchain/toolchain/simulation/`` and ``analysis/`` provide simulation and documentation tooling.
* ``.devcontainer/`` and ``.github/workflows/`` define container setup and CI.

Use tests next to the component being changed and run ``uz_cpld test`` for the repository's tooling regressions.
For generator changes, check representative generated programs and their HDL simulations as described in :doc:`hdl`.
Keep CLI help, documentation and tests aligned with the implemented behavior.
Write one sentence per source line in RST documentation.
Ignore the ``archive`` directory when documenting supported interfaces.

Python dependency maintenance
-----------------------------

``pyproject.toml`` defines package metadata and dependency groups; ``uv.lock`` locks the dependency graph.
``.python-version`` selects the interpreter, and ``cpld_toolchain/uv-bootstrap.json`` pins uv and its archive checksums.
Native setup and the container share these files.
After changing dependencies, run ``uv lock`` with the pinned uv executable under ``.tools/uv/`` and commit the updated lockfile.
Run setup again and rebuild the container to verify both environments.

CI image caching
----------------

The ``checks`` job imports and exports the license-free toolchain's BuildKit cache using the GitHub Actions ``cpld-toolchain`` scope.
It exports intermediate stages as well as the final image, so unchanged Python dependencies, OSS CAD Suite downloads, nextpnr and openFPGALoader builds can be reused on fresh runners.
The first run after this change populates the cache; later runs still need to download and load the cached layers.
Cache export failures do not fail otherwise successful builds.

The Diamond job imports the same cache for its shared tool stages but does not export its private image layers.
The two jobs remain independent, so a Diamond build can reuse a cache from an earlier run without waiting for the current ``checks`` job.
The Dockerfile separates nextpnr and flasher inputs; changing a flasher patch or test does not invalidate the suite download or nextpnr compilation.
Python dependency changes also leave the separate uv bootstrap and native-tool stages reusable.

Local ``uz_cpld image`` builds use Docker's local layer cache with the same Dockerfile.
Compare a cold and a warm CI run when measuring improvements; cache eviction or changed toolchain inputs can require rebuilding stages.

Toolchain reference
-------------------

.. toctree::
   :maxdepth: 1

   ../architecture
   ../commands
   ../tool-environments
   ../environments
   ../windows
   ../builds
   ../programmer
   ../firmware-identity
   ../foss
   ../program-documentation
   ../publishing
   ../api
