Releases
========

The MachXO2 programs are organized into release cycles under ``programs/<release_cycle>/``.
Each cycle has a catalog, a release description, and program-local sources, constraints and tests.
Choose a cycle by its S3C/D-slot protocol and the required adapter routing.
A release name or successful firmware build does not establish hardware qualification.

Release comparison
------------------

All three cycles target the MachXO2 D-slot ``LCMXO2-2000HC-4TG100C`` and S3C ``LCMXO2-4000HC-4TG144C``.

.. list-table:: Available release cycles
   :header-rows: 1
   :widths: 18 29 28 25

   * - Cycle
     - Program sources
     - S3C/D-slot protocol
     - Firmware backends
   * - ``original``
     - 22 programs, including static controllers and a generated routing example
     - Static active-high ReqSafeState; no heartbeat
     - Diamond and FOSS
   * - ``heartbeat``
     - 29 handwritten D-slot programs and ``s3c_heartbeat``
     - CarrierReady heartbeat plus independent static ReqSafeState
     - Diamond
   * - ``heartbeat_cvg``
     - 28 CSV-generated D-slot programs and handwritten ``s3c_heartbeat``
     - CarrierReady heartbeat plus independent static ReqSafeState
     - Diamond; FOSS also supported by ``cvg_tx30``

original
--------

Use this cycle for static safe-state signaling.
It contains the ``s3c_power_on_debounce`` and ``s3c_rev6_beta`` power controllers, the fixed-output ``s3c_toolchain_test_program``, and adapter-specific D-slot routing programs.
The generated ``cvg_tx30_stateful`` example uses the ``s3c_power_on_debounce_v1`` contract.
Neither power controller generates the heartbeat required by receivers in the heartbeat cycles.
Both controllers have strict FOSS initialized-state comparison counterexamples; see :doc:`validation` for their verification limits.

heartbeat
---------

Use this cycle to work directly with handwritten heartbeat D-slot VHDL.
The ``s3c_heartbeat`` controller sends heartbeat on CarrierReady while ReqSafeState independently selects safe routing.
The D-slots include 16 grouped voltage-card TX/RX variants, adapter-specific programs and the diagnostic ``tx30_hearbeattesting``.
All manifests select Synplify and VHDL-2008 for Diamond.

The shared receiver inhibits outputs until heartbeat qualifies and latches system error on heartbeat faults after qualification.
Static safe state follows each program's routing policy, so some data routes remain active in that state.
See :doc:`xo2-library` for receiver timing and :doc:`s3c` for controller behavior.

heartbeat_cvg
-------------

Use this cycle to maintain heartbeat D-slot routing through CSV and TOML inputs.
Its 28 D-slot programs use ``cvg_`` names and the ``s3c_heartbeat_v1`` contract; edit ``routing.csv`` and ``generator.toml`` and regenerate the project files.
It includes the same handwritten ``s3c_heartbeat`` controller as ``heartbeat`` and omits the ``tx30_hearbeattesting`` diagnostic.

Generated routing preserves the assigned normal/safe routes of the corresponding handwritten programs.
Unused pins are inputs in the generated model, so pin directions are not identical for every counterpart.
All programs support Diamond with Synplify and VHDL-2008; ``cvg_tx30`` additionally supports the :doc:`FOSS comparison workflow <foss>`.

Select a release
----------------

The tracked default is defined here:

.. literalinclude:: ../programs/releases.toml
   :language: toml

Run these commands from the repository root::

   uz_cpld release_list
   uz_cpld list --release-cycle heartbeat_cvg
   uz_cpld build --program cvg_tx30 --release-cycle heartbeat_cvg

``--release-cycle NAME`` selects a cycle for one command without changing the default.
``uz_cpld release_select --release-cycle NAME`` changes the tracked default.
Programming resolves the release from the command line, then ``selection.toml``, then the tracked default; build commands do not read ``selection.toml``.
Use program names from the selected cycle and pair S3C and D-slot firmware with compatible protocols.
See the :doc:`user guide <user/index>` for programming and :doc:`developer/release-management` for creating, cloning and documenting cycles.

ispLEVER program collections
----------------------------

``programs_LA4128V/`` and ``programs_LC256V/`` contain separate ispLEVER projects and JEDEC files for their device families.
They are outside the MachXO2 release-cycle catalog and are not selected by ``--release-cycle``.

Program reference
-----------------

Browse :doc:`Programs <_generated/programs/index>` for the release pages and their individual programs.
Documentation generation includes every release by default.
Use ``--release-cycle NAME`` only when intentionally building a smaller documentation preview.
