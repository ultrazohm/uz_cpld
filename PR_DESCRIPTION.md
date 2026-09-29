# Add CLI firmware builds, shared HDL, generation and CPLD programming

Base: `master`

Head: `feature/cli_based_toolchain_including_foss`

The repository now provides one command-line workflow for creating, simulating, building, documenting and programming UltraZohm CPLD firmware. The active `original` catalog contains 22 programs: 19 D-slot programs, two S3C controllers and one fixed-output S3C example. Vendor reference projects remain under `archive/`.

## Implementation

- Add explicit program/board manifests, release-cycle selection and cloning, Diamond/FOSS builds, provenance and stale-artifact checks.
- Add CSV/TOML VHDL generation and generated cocotb testbenches. Repository-generated projects use program-local `generator.toml` and outputs; the standalone generator accepts explicit paths and supports Unicode source paths.
- Keep reusable D-slot control HDL in standalone `xo2_library`. Handwritten and generated clones preserve shared-library references, including across release cycles.
- Generate program documentation, waveforms and RTL/state diagrams. Grouped FSM branches are handled explicitly; unsupported state choices fail rather than producing misleading transitions. The documentation lock covers asset generation, Sphinx and site validation.
- Add selection-based JTAG scanning, programming previews, verified flash programming and XCF export. Diamond execution uses private plans containing XCFs and verified JEDEC snapshots, checks the selected positions and firmware hashes, and rejects changed firmware before accessing hardware. XCF export supports `probe_index` for both chains.
- Allow per-program cleanup with stale generated files or missing HDL inputs while retaining output-path checks, locking and protection of edited project settings.
- Assign all 22 programs permanent numbers in `programs/usercodes.json`. Automatically allocate numbers for new programs and clones, and encode the program number plus input-specific build revision in USERCODE for both build backends. Locked allocation rejects collisions and exhausted counters; independent checkouts must coordinate the tracked registry.
- Add read-only firmware identification using USERCODE and silicon TraceID, and require matching identity readback before declaring programming successful. Build a pinned, patched openFPGALoader that writes and verifies MachXO2 USERCODE for JEDEC and compressed FOSS bitstreams; verify its provenance and parse selected files before USB access.
- Include all flasher inputs in the Docker build context, install its receipt with runtime-readable permissions and check the patched loader as the non-root image user. Serialize local flasher installation and retain the identity registry with CI firmware artifacts. Document native prerequisites, loader precedence, container rebuilds and current probe restrictions.

## Controller scope

`s3c_power_on_debounce` ports the December 2024 controller from `6794ce263a7c2b099001e429ce03a2d9b91d9b1d`. `s3c_rev6_beta` preserves the October 2025 sources and constraints from `2107cd5900ed2ebfa43226d5f6f8b7229bbd6bae`, except for commenting out an unused duplicate driver. Both use static safe-state signaling without heartbeat. Rev6 retains its historical FlexLIO pin mapping. See `docs/s3c.rst` for source provenance, adaptations and behavioral coverage.

FOSS builds retain their documented startup-equivalence limitations. Their two bank-2 open-drain outputs are checked against the Diamond electrical encoding. Neither successful builds nor the selected simulation sequences establish comprehensive hardware qualification or timing acceptance.

## Validation

- `make test`: 234 tests run, 230 passed and four optional browser tests skipped.
- `make docs-local`: all 22 program documentation assets validated; Sphinx completed with warnings treated as errors, and 141 HTML files passed site validation. All 22 program simulations passed during this change.
- Diamond builds for all 22 programs passed, with unique embedded USERCODEs matching the registry.
- FOSS builds of `tx30` and `s3c_rev6_beta` passed, covering both device sizes and compressed bitstream output.
- The pinned openFPGALoader patch compiled successfully and passed native mocked USERCODE write/readback tests. Its real parsers accepted Diamond JEDEC and FOSS bitstreams for both device sizes, and rejected wrong JEDEC identities and malformed codes without accessing USB.

Regression coverage includes concurrent identity allocation, revision reuse, automatic clone/release numbering, shared-library cloning, independent programming plans, changed firmware rejection before the hardware runner, identity readback failures, stale-input cleanup, grouped FSM branches, Unicode TOML paths, XCF probe selection and documentation locking. Hardware programming and live identity readback, a fresh container-image build and hosted Actions/Pages deployment remain outside this local validation.

The workflow targets Pages deployment from `master`; repository Pages/environment settings and live PR mergeability still need verification on GitHub. This branch does not integrate the later heartbeat development history.
