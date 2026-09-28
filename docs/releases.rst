Release cycles
==============

Programs are grouped as ``programs/<release_cycle>/<program>/``.
Each release directory has its own ``catalog.toml``. All pre-existing programs are in ``original``;
the generated example is now ``original/cvg_tx30_stateful``.
The same program name may occur in multiple cycles, with independent source files and build outputs.

Select and create cycles
------------------------

::

   make release-list
   make release-new name=r2026_10
   make release-current release_cycle=original
   make release-new name=r2026_11 from=original

``programs/releases.toml`` records the current cycle and is tracked in Git.
Creating a cycle selects it as current; an existing cycle is never overwritten.
Without ``from``, a new cycle has an empty catalog.
With ``from``, authored files and the catalog are copied, including unfinished generator starters,
while ``build/`` directories and Python caches are excluded. Complete programs are validated before and after copying.
Shared HDL and board targets remain shared across cycles; a cycle is not a frozen snapshot of the whole toolchain.
Git records the corresponding toolchain version.

Every program command accepts ``release_cycle=NAME``. Omitting it selects the current cycle,
independently of directory timestamps or alphabetical ordering.
The Python build CLI uses ``--release-cycle NAME`` (``--release_cycle`` is also accepted).
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

``template_release_cycle`` defaults to the destination cycle. Specify it to clone from another cycle,
especially when the destination is empty. Generated program clones also receive the ``cvg_`` prefix.
The standalone generator takes explicit config/output paths and does not select or modify a repository release.

Outputs and documentation
-------------------------

Builds, simulations and netlists write under the selected program's ``build/`` directory.
Catalog reports are under ``toolchain/build/validation/<release_cycle>/``.
Locks and provenance include the cycle so matching program names remain independent.
``list``, ``build-all``, ``report``, ``sim`` and ``netlist`` operate on the selected cycle.
``make docs`` includes all cycles and groups program pages by cycle;
``make docs release_cycle=NAME`` generates documentation for one cycle.
``make clean`` affects one selected program/backend; ``make clean-all`` removes generated outputs across all cycles.

Migrated build evidence may contain old paths and is stale. Regenerate projects, simulations and reports
before relying on their outputs. Authored program files and existing build directories were retained during migration.
