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
Exactly one authored LPF is supported; constraint merging is excluded to avoid ambiguous precedence.
``testbench`` must name the program-local ``<name>_tb.py`` file; manifest validation checks its existence but does not run it.
``description.rst`` is optional program prose discovered by the documentation generator.

Target
------

.. literalinclude:: ../toolchain/targets/uz_dslot_xo2/target.toml
   :language: toml

The supported target is the Rev05+ UltraZohm D-slot ``LCMXO2-2000HC-4TG100C``.
A board target is separate from the backend, program mapping and eventual JTAG chain position.
``diamond.strategy`` selects the captured strategy input; the empty ``diamond.options`` table is required and accepts string-valued vendor overrides.
Set VHDL standard through the program manifest rather than ``lse_vhdl2008``.
Unknown vendor options fail during Diamond preparation.
``diamond.version`` must appear in the build log; the extractor recognizes the ``3.14.0.<number>.<number>`` release family.

``backend`` selects the target default; both ``diamond`` and ``foss`` are supported.
The selected backend table is required.
``foss.version`` matches the pinned OSS CAD Suite release, and ``foss.seed`` selects a positive deterministic nextpnr seed.
Diamond strategy settings do not apply to FOSS builds.
Unknown manifest fields and unsupported backends/devices are rejected.
