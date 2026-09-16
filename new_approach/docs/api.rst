Python API
==========

These modules are the shared implementation behind Make commands and program documentation.
Use :doc:`architecture` for the public workflow and :doc:`configuration` for manifest rules.

.. automodule:: toolchain.buildsystem.model
   :members:

.. automodule:: toolchain.buildsystem.workflow
   :members:

.. automodule:: toolchain.buildsystem.backends.diamond
   :members:

.. automodule:: toolchain.buildsystem.cli
   :members:

.. automodule:: toolchain.simulation.test_simulation
   :members:

.. automodule:: toolchain.analysis.netlist
   :members: export_netlist

.. automodule:: toolchain.analysis.waveform
   :members: read_vcd, write_waveform
