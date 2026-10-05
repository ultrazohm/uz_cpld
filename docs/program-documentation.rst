Program diagrams and waveforms
==============================

::

   make docs jobs=4
   make netlist program=tx26_w_enable release_cycle=original

``make docs`` discovers complete program manifests in the current release, generates RTL schematics, runs its testbench with seed 1 and builds a Sphinx page.
Use ``release_cycle=all`` for all releases, or ``program=NAME`` and ``target=dslot|s3c`` to filter.
An explicit filter matching no programs fails before replacing existing assets.
Each page includes ``programs/<release_cycle>/<name>/description.rst`` when present, SVG/PDF diagrams, an interactive waveform and downloads.
Up to ``jobs`` programs run concurrently (default: 4; ``jobs=1`` runs sequentially).
For each program, RTL schematics, state diagrams, simulation, waveform assets and its page are generated in order.
After every program succeeds, the complete page index is written and the main Sphinx build runs sequentially.
Failed analysis or simulation stops the build; generated page sources are replaced before generation.
A documentation lock covers asset generation, HTML cleanup, Sphinx rendering and site validation for ``make docs``.
It rejects concurrent managed documentation builds and prevents ``clean-all`` or program creation throughout those stages.
The assets-only command holds the same lock for its generation stage.
The same worker limit applies to ``make docs-assets`` and ``make docs``.
Firmware builds, including Diamond ``make build-all``, run sequentially.
``make netlist`` exports diagrams for the firmware catalog without simulation; ``program`` selects one program.

RTL netlists
------------

GHDL synthesizes the manifest's VHDL to Verilog, Yosys lowers processes and flattens/cleans the generic netlist, and Graphviz renders SVG and PDF.
The program page embeds a searchable schematic viewer with mouse-wheel zoom, drag-to-pan, a fit button and full-screen mode.
The standalone HTML viewer, SVG and PDF are also available for download.
This analysis excludes LPF constraints, device mapping, placement, routing and timing, so it does not represent Diamond's implemented netlist.
Conditional routing appears as a mux at this stage; for example, choosing an FPGA input in normal state and ``0`` in safe state implements an AND for defined binary values.
The firmware tools can map that function into device LUTs.
Vendor attributes such as ``syn_keep`` can be ignored; sources in the manifest are compiled in their declared libraries, while unsupported primitives require explicit models.

``programs/<release_cycle>/<name>/build/netlist/`` contains ``netlist.svg``, ``netlist.pdf``, intermediates and diagnostic logs; ``metadata/`` contains netlist provenance and the Yosys JSON export.
Netlist exports use the managed program/target lock and remove stale diagrams on failure.

State diagrams
--------------

For programs with an enumerated state signal and a ``case`` statement, documentation generation extracts possible state assignments from the manifest VHDL and renders an SVG/PDF diagram with Graphviz.
The diagram identifies the declared initial state and explicit transitions and labels each arrow with its source-level condition.
For ``elsif`` and ``else`` branches, the label also includes the preceding guards being false.
An unconditional assignment is labeled ``always``; the implicit hold when a branch does not assign a new state is omitted.
The extractor supports named ``when`` branches, grouped choices such as ``when run | wait_mode =>``, ``others``, and nested ``if``/``elsif``/``else`` guards within one state ``case`` statement.
Unsupported or duplicate state choices fail diagram generation instead of publishing a partial graph.
Reset assignments outside that statement, enclosing process guards, and implicit holds are omitted.
The diagram is a source navigation aid and does not establish transition reachability or safety.
Generated files and source hashes are under ``programs/<release_cycle>/<name>/build/state-diagrams/``.
TerosHDL offers an interactive state-machine viewer in VS Code; Sphinx's headless export uses the repository's own extractor.

Interactive waveforms
---------------------

Plotly renders the actual VCD transitions as step traces with nanosecond units, channel selection, zoom and value tooltips.
Choose a channel preset, search the signal list, add matching signals, or toggle individual signals to compare them.
The plot width fits the viewer frame; its height grows with the selected signals so each trace has at least 32 pixels of vertical space.
The signal selector shows every available signal without pagination; use the search field to narrow the list.
The embedded viewer starts at 1,200 pixels high and grows to fit the signal list while reserving at least 600 pixels for the plot.
Long views scroll with the documentation page rather than inside the embedded viewer, and every selected signal keeps its axis label.
The initial view covers the full simulation; drag to zoom and use Plotly's **Reset axes** to restore the full trace.
Unknown/uninitialized values (X/U), high impedance (Z) and other nonbinary states retain their labels and use a middle display level.
Bus values are normalized to their width, with binary values in tooltips.
VCD has no delta-cycle axis, so the viewer shows the final value at each timestamp and extends it to the end time reported by cocotb.

Documentation generation writes ``waveform.html`` beside the simulation results and ``metadata/waveform.json`` beside simulation provenance, then copies public assets into the site.
Each viewer embeds Plotly.js for offline use, trading larger HTML files for independence from external scripts.
``make docs`` replaces simulation outputs with its VCD run; copy results before comparing separate runs.

Authoring and publishing
------------------------

Write release-wide prose in ``programs/<release_cycle>/description.rst``, program-specific prose in ``programs/<release_cycle>/<name>/description.rst``, and shared guides in ``docs/*.rst``.
Use one sentence per source line without manual wrapping or a line-length limit; preserve the required layout of directives, tables and code blocks.
Generated pages follow the same prose rule.
``make docs`` uses installed tools; ``make docs-assets`` generates pages/assets without Sphinx.
Direct Sphinx invocation renders existing assets without refreshing simulation or netlists.
See :doc:`publishing` for GitHub Pages deployment and :doc:`architecture` for source/output ownership.

Browser checks
--------------

The optional browser tests exercise schematic navigation and full-screen mode, waveform selection, keyboard focus and Plotly zoom/reset in Chromium::

   python3 -m pip install playwright
   python3 -m playwright install chromium
   CPLD_BROWSER_TESTS=1 python3 -m unittest cpld_toolchain.toolchain.tests.test_viewers_browser -v

Set ``CPLD_CHROMIUM_EXECUTABLE`` to use an existing Chromium executable.
These tests are skipped during normal tooling tests unless ``CPLD_BROWSER_TESTS=1`` is set.

References
----------

* `GHDL synthesis <https://ghdl.github.io/ghdl/using/Synthesis.html>`_
* `Yosys schematic export <https://yosyshq.readthedocs.io/projects/yosys/en/0.47/cmd/show.html>`_
* `Plotly HTML export <https://plotly.com/python/interactive-html-export/>`_
* `UltraZohm documentation dependencies <https://github.com/ultrazohm/ultrazohm_sw/blob/main/docs/requirements.txt>`_

Declared netlist omissions
--------------------------

A program can declare ``netlist_skip_reason`` in its manifest when its HDL cannot be synthesized by GHDL.
The value must be a nonempty explanation and is displayed in place of the RTL schematic on the program page.
Simulation remains mandatory, and unexpected netlist failures for other programs still fail documentation generation.
Catalog netlist export reports the declared omission; explicitly requesting that program's netlist fails with the explanation.
The FSM extractor omits graphs with no directly extractable transitions, including controllers whose transitions are implemented through procedures.
