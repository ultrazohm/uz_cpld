Program diagrams and waveforms
==============================

::

   make docs
   make netlist program=tx26_w_enable

``make docs`` discovers every program manifest, generates RTL schematics, runs its testbench with seed 1 and builds a Sphinx page.
Each page includes ``programs/<name>/description.rst`` when present, SVG/PDF diagrams, an interactive waveform and downloads.
Failed analysis or simulation stops the build; generated page sources are replaced before generation.
``make netlist`` exports diagrams for the firmware catalog without simulation; ``program`` selects one program.

RTL netlists
------------

GHDL synthesizes the manifest's VHDL to Verilog, Yosys lowers processes and flattens/cleans the generic netlist, and Graphviz renders SVG and PDF.
This analysis excludes LPF constraints, device mapping, placement, routing and timing, so it does not represent Diamond's implemented netlist.
Vendor attributes such as ``syn_keep`` can be ignored, and unsupported primitives or non-``work`` libraries require explicit support.

``programs/<name>/build/netlist/`` contains ``netlist.svg``, ``netlist.pdf``, intermediates and diagnostic logs; ``metadata/`` contains netlist provenance and the Yosys JSON export.
Netlist exports use the managed program/target lock and remove stale diagrams on failure.

State diagrams
--------------

For programs with an enumerated state signal and a ``case`` statement, documentation generation extracts possible state assignments from the manifest VHDL and renders an SVG/PDF diagram with Graphviz.
The diagram identifies the declared initial state and explicit transitions and labels each arrow with its source-level condition.
For ``elsif`` and ``else`` branches, the label also includes the preceding guards being false.
An unconditional assignment is labeled ``always``; the implicit hold when a branch does not assign a new state is omitted.
It is a source navigation aid, not a proof that a transition is reachable or safe.
Generated files and source hashes are under ``programs/<name>/build/state-diagrams/``.
TerosHDL offers an interactive state-machine viewer in VS Code; Sphinx's headless export uses the repository's own extractor.

Interactive waveforms
---------------------

Plotly renders the actual VCD transitions as step traces with nanosecond units, channel selection, zoom and value tooltips.
The initial view covers 150 ns; **Full trace** shows the complete test.
Unknown/uninitialized values (X/U), high impedance (Z) and other nonbinary states retain their labels and use a middle display level.
Bus values are normalized to their width, with binary values in tooltips.
VCD has no delta-cycle axis, so the viewer shows the final value at each timestamp and extends it to the end time reported by cocotb.

Documentation generation writes ``waveform.html`` beside the simulation results and ``metadata/waveform.json`` beside simulation provenance, then copies public assets into the site.
Each viewer embeds Plotly.js for offline use, trading larger HTML files for independence from external scripts.
``make docs`` replaces simulation outputs with its VCD run; copy results before comparing separate runs.

Authoring and publishing
------------------------

Write program-specific prose in ``description.rst`` and shared guides in ``docs/*.rst``.
Use one sentence per source line without manual wrapping or a line-length limit; preserve the required layout of directives, tables and code blocks.
Generated pages follow the same prose rule.
``make docs-local`` uses installed tools; ``make docs-assets-local`` generates pages/assets without Sphinx.
Direct Sphinx invocation renders existing assets without refreshing simulation or netlists.
See :doc:`publishing` for GitHub Pages deployment and :doc:`architecture` for source/output ownership.

References
----------

* `GHDL synthesis <https://ghdl.github.io/ghdl/using/Synthesis.html>`_
* `Yosys schematic export <https://yosyshq.readthedocs.io/projects/yosys/en/0.47/cmd/show.html>`_
* `Plotly HTML export <https://plotly.com/python/interactive-html-export/>`_
* `UltraZohm documentation dependencies <https://github.com/ultrazohm/ultrazohm_sw/blob/main/docs/requirements.txt>`_
