Open work and extensions
========================

Release work
------------

* Validate a fresh image build, VS Code attachment and hosted GitHub Pages deployment.
* Complete the native Diamond GUI round trip and adapter-specific hardware acceptance.
* Resolve the electrical warnings and define timing acceptance budgets listed in :doc:`validation`.
* Define firmware release packaging with reports, source revision and validation evidence.
* Pin the base image/tool dependencies and establish a deliberate update policy.

Extensions
----------

* Migrate additional D-slot programs with reviewed constraints, dependencies and testbenches.
* Add a FOSS firmware backend and compare its outputs against the Diamond reference.
* Add ispMACH, S2C or S3C targets when their device-specific requirements are supported.
* Add a separate hardware-programming command with explicit chain/adapter configuration.
* Extract shared HDL and constraints after equivalence and conflict checks.
* Introduce capability matching when multiple targets justify it.
* Investigate supported automation for Diamond Netlist Analyzer exports.
* Add oscillator/EFB behavioral models and host-compiled C-driver cosimulation where required.

Generic RTL SVG/PDF export and interactive program documentation are implemented; they do not establish a FOSS firmware flow or vendor-netlist equivalence.
