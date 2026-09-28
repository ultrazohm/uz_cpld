Lattice Programmer projects
===========================

``programmer_helper`` generates separate five-device D-slot and one-device S3C XCF files from published Diamond JEDEC exports. It does not communicate with a programmer or change hardware.

Select every program explicitly. Positions 1 through 5 are the JTAG positions in the archived D-slot chain, not an automatically chosen catalog order. Copy ``programmer_helper/selection.example.toml``, fill all six values, then run::

   make programmer-project selection=my_programmer_selection.toml

The TOML file has a top-level ``s3c`` program and a ``[slots]`` table with keys ``"1"`` through ``"5"``. Each value is a program name from the selected release. No name is filled in by the helper. You can also supply all names on the command line::

   make programmer-project slot1=tx30 slot2=tx30 slot3=rx30 \
       slot4=uz_d_resolver_d4_4inverter_sdifix \
       slot5=uz_d_resolver_d5_4inverter_sdifix s3c=s3c_power_on_debounce

These command-line names are an example of an operator-supplied selection. The helper has no default mapping. Each selected program must have a successful, current Diamond build with a recorded JEDEC file. To rebuild all selected programs in the same command, add ``rebuild=1``. This requires a working Diamond installation.

Omit ``release_cycle`` to use ``programs/releases.toml``. To select an older cycle, add ``release_cycle=NAME``. All six programs are resolved within that cycle; the helper never mixes release cycles. The source release must be present in this checkout and its Diamond builds must be available or rebuilt.

The generated files are ``toolchain/build/programmer/<release_cycle>/dslots.xcf``, ``s3c.xcf`` and ``selection.json``. The receipt records the chosen programs and SHA-256 hashes of the JEDEC and XCF files. The helper copies device positions and programming options from the archived XCFs, replaces each JEDEC path, time, fuse checksum and usercode, and removes archived USB serial numbers. It retains the archived USB2 port addresses (``FTUSB-1`` for D-slots and ``FTUSB-0`` for S3C); confirm those addresses on the programming station. The generated XCFs contain absolute paths and must be regenerated after moving the checkout or rebuilding the firmware.

Open the generated files in Lattice Programmer for chain detection and programming. The source templates use ``FLASH Erase,Program,Verify`` and the helper accepts only Diamond ``.jed`` exports. The FOSS backend currently exports ``.bit`` files and is not supported for these Flash projects. Successful build evidence and XCF generation do not establish hardware qualification; review the selected programs and device chain before programming. In particular, the imported ``s3c_power_on_debounce`` program has an unresolved FOSS startup proof counterexample even though its Diamond export can be selected here.
