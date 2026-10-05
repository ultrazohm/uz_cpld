Release cycles
==============

Programs are grouped as ``programs/<release_cycle>/<program>/``.
Each release directory has its own ``catalog.toml`` and an authored ``description.rst``.
The ``original`` cycle contains the reference programs, including ``cvg_tx30_stateful``.
The same program name may occur in multiple cycles, with independent source files and build outputs.

Document a cycle
----------------

Write release-wide documentation in ``programs/<release_cycle>/description.rst``; for example, ``programs/original/description.rst``.
Describe the cycle's purpose, intended hardware, S3C/D-slot protocol compatibility, and validation limits.
Keep program-specific routing and behavior in ``programs/<release_cycle>/<program>/description.rst``.
The generated program index includes the release description above that cycle's program list, including for empty cycles.
Use paragraphs and ``.. rubric::`` headings without a top-level title; the index supplies the cycle heading.
Use absolute Sphinx document paths, such as ``/s3c``, for links to shared guides.
Existing cycles without a description remain supported.

Select and create cycles
------------------------

::

   make release-list
   make release-new name=r2026_10
   make release-select release_cycle=original
   make release-new name=r2026_11 from=original

``programs/releases.toml`` records the current cycle and is tracked in Git.
Cycle and program names use lowercase letters, digits and underscores, starting with a letter.
The directory name ``build`` is reserved for generated outputs.
Creating a cycle selects it as current; an existing cycle is never overwritten.
Without ``from``, a new cycle has an empty catalog and a starter ``description.rst``.
With ``from``, authored files and the catalog are copied, including unfinished generator starters, while ``build/`` directories and Python caches are excluded.
The release description is copied too; review it for the new cycle, especially compatibility and validation claims.
If the source cycle has no description, a starter is created.
Complete programs are validated before and after copying.
Shared HDL and board targets remain shared across cycles; a cycle is not a frozen snapshot of the whole toolchain.
Git records the corresponding toolchain version.
Copied programs and generator starters receive new permanent program numbers in the shared ``programs/usercodes.json`` registry.
Commit the registry with the new release; see :doc:`firmware-identity` for allocation across independent checkouts.

Every program command accepts ``release_cycle=NAME``.
Omitting it selects the current cycle, independently of directory timestamps or alphabetical ordering.
The Python build CLI uses ``--release-cycle NAME``.
Explicit selection does not change the tracked current cycle.

Create and generate programs
----------------------------

::

   make new name=my_adapter template=tx30 template_release_cycle=original release_cycle=r2026_10
   make new name=my_slot template=generator release_cycle=r2026_10
   # Edit programs/r2026_10/cvg_my_slot/routing.csv
   make generate program=cvg_my_slot release_cycle=r2026_10
   make check program=cvg_my_slot release_cycle=r2026_10
   make sim program=cvg_my_slot release_cycle=r2026_10
   make build program=cvg_my_slot release_cycle=r2026_10

``template_release_cycle`` defaults to the destination cycle.
Specify it to clone from another cycle, especially when the destination is empty.
Generated program clones also receive the ``cvg_`` prefix.
The standalone generator takes explicit config/output paths and does not select or modify a repository release.

Outputs and documentation
-------------------------

Builds, simulations and netlists write under the selected program's ``build/`` directory.
Catalog reports are under ``cpld_toolchain/toolchain/build/validation/<release_cycle>/``.
Locks and provenance include the cycle so matching program names remain independent.
``list``, ``build-all``, ``report``, ``sim`` and ``netlist`` operate on the selected cycle.
``make docs`` documents the current cycle; ``make docs release_cycle=NAME`` selects another cycle.
``make docs release_cycle=all`` includes every cycle and groups program pages by cycle.
``make clean`` affects one selected program/backend; ``make clean-all`` removes generated outputs across all cycles.
