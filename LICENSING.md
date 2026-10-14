# Licensing

Original UltraZohm CPLD code is licensed under Apache-2.0; see LICENSE and NOTICE.
This covers our Python tooling, C++ driver helper, build scripts, documentation,
and original HDL and test sources. Existing third-party notices take precedence
for the material to which they apply. Applying this license does not claim
ownership of third-party contributions or supersede their licenses.

Third-party dependencies retain their own licenses. In particular, our changes
to libwdi remain LGPL-3.0-or-later; our openFPGALoader patch retains the upstream
Apache-2.0 license. The delivered application is a distribution of components
under multiple licenses, not an exclusively Apache-2.0 binary.

Historical files in archive/, programs_LA4128V/ and programs_LC256V/ include vendor
reference designs, IEEE material and generated artifacts. Their existing notices
and restrictions remain in force. Examples include Lattice's i2c_slave.vhd and
IEEE's _math_real.vhd files. These historical directories are excluded from the
programmer's corresponding-source archive and are not licensed wholesale under
Apache-2.0. No new redistribution permission is asserted for third-party material
that lacks a clear grant. These files are not part of the standalone programmer.

Vendor software, proprietary IP and tool-generated portions of firmware retain
any applicable vendor terms. Diamond is not included in public programmer ZIPs.
Our original HDL is Apache-2.0; this does not relicense vendor primitives or grant
rights beyond the applicable tool/IP agreements for generated firmware.

Contributions to the Apache-covered parts are accepted under Apache-2.0.
Contributors must have the necessary rights and identify any third-party content.
Do not remove existing attribution when adapting external code.

Programmer releases include THIRD_PARTY_NOTICES.txt, component license texts,
a file-level dependency inventory, and corresponding source/relinking material.
No distribution terms restrict modifying LGPL components or reverse engineering
for debugging those modifications. Locally rebuilt native executables may be
used by updating their local SHA-256 receipts; these receipts are integrity
checks, not a requirement to obtain a publisher signature.
