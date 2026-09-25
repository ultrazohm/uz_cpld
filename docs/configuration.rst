Manifest reference
==================

Program
-------

.. literalinclude:: ../programs/tx30/tx30.toml
   :language: toml

All shown fields are required.
``name`` matches its directory and uses lowercase letters, digits and underscores, starting with a letter.
``top`` and source libraries are VHDL basic identifiers; ``standard`` is ``1993`` or ``2008``.
``sources`` is a nonempty ordered list with no duplicate paths, and ``targets`` explicitly lists compatible board targets.
Input paths are relative to the manifest, must exist and must stay within the workspace.
``constraints`` names the authored Diamond LPF. An optional ``foss_constraints`` names a separate FOSS LPF when vendor settings cannot be reproduced by Trellis; each backend reads exactly one LPF.
An optional ``backends`` list limits firmware exports to ``diamond`` and/or ``foss``. Omitted lists permit both.
``testbench`` must name the program-local ``<name>_tb.py`` file; manifest validation checks its existence but does not run it.
An optional ``generator`` path selects a standalone generator configuration and requires fresh emitted VHDL and provenance before builds, simulation, or documentation.
Generated programs use VHDL-1993 and list sources in the order and libraries recorded by ``generator-output.json``.
The shared S3C entity and selected architecture use library ``s3c``; the generated top level uses library ``work``.
The provenance record stays in the program directory and includes the shared source hashes.
``description.rst`` is optional program prose discovered by the documentation generator.

Target
------

.. literalinclude:: ../toolchain/targets/uz_dslot_xo2/target.toml
   :language: toml

The D-slot target is ``uz_dslot_xo2`` (``LCMXO2-2000HC-4TG100C``).
The S3C target is ``uz_s3c_xo2`` (``LCMXO2-4000HC-4TG144C``)::

   make check program=s3c_toolchain_test_program
   make build program=s3c_toolchain_test_program backend=diamond
   make build program=s3c_toolchain_test_program backend=foss

Each catalog program declares its compatible target in ``targets``. Commands
for one program infer that target when it is unique. ``target=...`` selects a
target explicitly; catalog commands process both targets by default and can be
filtered with the same option.
A board target is separate from the backend, program mapping and eventual JTAG chain position.
``diamond.strategy`` selects the captured strategy input; the empty ``diamond.options`` table is required and accepts string-valued vendor overrides.
Set VHDL standard through the program manifest rather than ``lse_vhdl2008``.
Unknown vendor options fail during Diamond preparation.
``diamond.version`` must appear in the build log; the extractor recognizes the ``3.14.0.<number>.<number>`` release family.

``backend`` selects the target default; both ``diamond`` and ``foss`` are implemented for the S3C target, subject to each program's ``backends`` list.
The selected backend table is required.
``foss.version`` matches the pinned OSS CAD Suite release, and ``foss.seed`` selects a positive deterministic nextpnr seed.
Diamond strategy settings do not apply to FOSS builds.
Unknown manifest fields and unsupported backends/devices are rejected.
