Legacy project reference
========================

``MACHXO2/`` contains D-slot, S2C and S3C projects; ``ispMACH/`` contains older device designs and imported examples.
Only the three catalog programs under ``programs/`` are supported by the headless build interface.
Review additional programs individually because constraints, primitives and dependencies differ.

Files and tools
---------------

For ispLEVER projects, ``top_level.abl`` contains ABEL logic after ``EQUATIONS`` together with pin and electrical definitions, and ``.syn`` is the project entry point.
``.jed`` is the programming image, ``.html`` contains reports and ``.xcf`` contains Diamond Programmer instructions.
``.sch`` schematics and ``.tcl`` scripts can support development, while ``.lct`` constraints are generated from ABEL.
These file roles do not define the Git policy; generated-file exclusions are specified by ``.gitignore``.

``xo2_libraries/`` contains supplementary VHDL packages associated with the UltraZohm ``xo2_libraries`` project at ``https://bitbucket.org/ultrazohm/xo2_libraries/``.
The headless program manifests do not reference these packages.
The USACH archive contains Quartus 16 communication examples for the USACH board; these are not supported ispMACH or MachXO2 builds.
Vendor-generated ``db/*.txt`` files and ``run_options.txt`` are tool metadata rather than user guides.

Inverter projects
-----------------

``optical_14tx_4rx_2L_interlock`` assigns FPGA/output pairs 00–01, 02–03 and 04–05 to phases A, B and C.
Its complementary switches use mutual exclusion, illustrated by phase A::

   d_00 = fpga_00 & enable_signal & !fpga_01;
   d_01 = fpga_01 & enable_signal & !fpga_00;

``optical_14tx_4rx_3L_NPC_interlock`` assigns groups 00–03, 04–07 and 08–11 to phases A, B and C, ordered top, neutral-point upper, neutral-point lower and bottom.
Phase A excludes simultaneous commands for pairs 00/02 and 01/03::

   d_00 = fpga_00 & enable_signal & !fpga_02;
   d_02 = fpga_02 & enable_signal & !fpga_00;
   d_01 = fpga_01 & enable_signal & !fpga_03;
   d_03 = fpga_03 & enable_signal & !fpga_01;

These interlocks do not insert dead time.
``uz_d_3ph_inverter`` delegates complementary-switch interlocking to the adapter board and also implements no CPLD dead time.
Its documented adapter mapping is listed below; confirm it against the selected hardware before use.

.. list-table:: uz_d_3ph_inverter adapter mapping
   :header-rows: 1

   * - Source
     - Destination
     - Adapter signal
   * - ``fpga_00``
     - ``d_00``
     - ``PWM_H1#``
   * - ``fpga_01``
     - ``d_01``
     - ``PWM_L1#``
   * - ``fpga_02``
     - ``d_02``
     - ``PWM_H2#``
   * - ``fpga_03``
     - ``d_03``
     - ``PWM_L2#``
   * - ``fpga_04``
     - ``d_04``
     - ``PWM_H3#``
   * - ``fpga_05``
     - ``d_05``
     - ``PWM_L3#``
   * - ``d_06``
     - ``fpga_06``
     - ``I1_DIAG``
   * - ``d_07``
     - ``fpga_07``
     - ``GaN_H1_Temp``
   * - ``d_08``
     - ``fpga_08``
     - ``I2_DIAG``
   * - ``d_09``
     - ``fpga_09``
     - ``GaN_L1_Temp``
   * - ``d_10``
     - ``fpga_10``
     - ``I3_DIAG``
   * - ``d_11``
     - ``fpga_11``
     - ``GaN_L1_OC``
   * - ``d_12``
     - ``fpga_12``
     - ``I_DIAG``
   * - ``d_13``
     - ``fpga_13``
     - ``GaN_L1_FAULT``
   * - ``fpga_14``
     - ``d_14``
     - ``PWM_EN``
   * - ``d_15``
     - ``fpga_15``
     - ``GaN_H1_OC``
   * - ``d_16``
     - ``fpga_16``
     - ``N/A``
   * - ``d_17``
     - ``fpga_17``
     - ``GaN_H1_FAULT``
   * - ``d_18``
     - ``fpga_18``
     - ``GaN_H3_Temp``
   * - ``d_19``
     - ``fpga_19``
     - ``GaN_H2_Temp``
   * - ``d_20``
     - ``fpga_20``
     - ``GaN_L3_Temp``
   * - ``d_21``
     - ``fpga_21``
     - ``GaN_L2_Temp``
   * - ``d_22``
     - ``fpga_22``
     - ``GaN_L3_OC``
   * - ``d_23``
     - ``fpga_23``
     - ``GaN_L2_OC``
   * - ``d_24``
     - ``fpga_24``
     - ``GaN_L3_FAULT``
   * - ``d_25``
     - ``fpga_25``
     - ``GaN_L2_FAULT``
   * - ``d_26``
     - ``fpga_26``
     - ``GaN_H3_OC``
   * - ``d_27``
     - ``fpga_27``
     - ``GaN_H2_OC``
   * - ``d_28``
     - ``fpga_28``
     - ``GaN_H3_FAULT``
   * - ``d_29``
     - ``fpga_29``
     - ``GaN_H2_FAULT``
