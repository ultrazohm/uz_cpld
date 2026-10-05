Python API
==========

These modules are the shared implementation behind Make commands and program documentation.
Use :doc:`architecture` for the public workflow and :doc:`configuration` for manifest rules.

.. automodule:: cpld_toolchain.toolchain.buildsystem.model
   :members:

.. automodule:: cpld_toolchain.toolchain.buildsystem.workflow
   :members:

.. automodule:: cpld_toolchain.toolchain.buildsystem.backends.diamond
   :members:

.. automodule:: cpld_toolchain.toolchain.buildsystem.cli
   :members:

.. automodule:: cpld_toolchain.toolchain.simulation.test_simulation
   :members:

.. automodule:: cpld_toolchain.toolchain.analysis.netlist
   :members: export_netlist

.. automodule:: cpld_toolchain.toolchain.analysis.waveform
   :members: read_vcd, write_waveform

.. automodule:: cpld_toolchain.toolchain.buildsystem.backends.foss
   :members:
