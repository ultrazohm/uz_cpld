# Add CLI firmware builds, VHDL generation, and CPLD programming

**Base:** `master`

**Head:** `pr/cli-toolchain-master`

## Summary

Introduce a command-line workflow for creating, simulating, building, documenting, and programming UltraZohm D-slot and S3C CPLD firmware.

- Organize active firmware under `programs/<release_cycle>/<program>/`, with explicit catalogs and release selection. Move vendor reference projects under `archive/` and remove obsolete generated HTML reports.
- Support Diamond and FOSS firmware builds, with input/output hashes, build provenance, reports, and checks against stale artifacts.
- Add the standalone CSV/TOML VHDL generator, shared D-slot control logic, generated tests, and resolver/inverter routing variants.
- Provide a unified development container, GHDL/cocotb simulation, generated program documentation, and CI checks.
- Add `make programmer`, `make programmer scan`, `make programmer program target=s3c|dslot`, and `make programmer lattice_xcf`.
- Keep firmware `build_backend` independent of `programmer_backend`: Diamond builds can be programmed by Diamond or FOSS; FOSS builds use FOSS programming.
- Create a populated local `selection.toml`, preserve existing selections, print the selected programs before programming, and support previews with `dry_run=1`.
- Handle FTDI channel-B driver detachment for Diamond from the container. Default to Diamond FTUSB-1 and the corresponding FOSS FT4232-B interface; S3C and D-slots are programmed separately in their required physical states.

## Why master

The base is deliberately `master`. After fetching origin on 28 September 2026, `origin/master` at `aa9a2eb702d0d57fc97856576b18433174f287af` is already an ancestor of this branch, so no merge conflict resolution or rebase is required against that revision.

`develop` has diverged: 69 commits on `origin/develop` are absent from the feature branch. This PR does not merge that development history. Recheck GitHub's mergeability and required checks when submitting, in case the base has advanced.

## S3C scope and exact source revision

**The only implemented S3C power and safety controller in the active catalog is `s3c_power_on_debounce`. Its logic is based on:**

```text
archive/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd
```

**Source commit: `6794ce263a7c2b099001e429ce03a2d9b91d9b1d` — 17 December 2024 — `rev05 00`.**

[View the exact original source](https://github.com/ultrazohm/uz_cpld/blob/6794ce263a7c2b099001e429ce03a2d9b91d9b1d/MACHXO2/S3C_CPLD_LCMXO2-4000HC-4TG144C/S3C_171224/source/Power_on_debounce.vhd) · [View the source commit](https://github.com/ultrazohm/uz_cpld/commit/6794ce263a7c2b099001e429ce03a2d9b91d9b1d)

The archived file is byte-for-byte identical to that historical source. Its SHA-256 is `c820573f7fae2dcf63e7ddf223f848eda5bba95586985cff1ff59215b51f6294`. Commit `7428b1ea2c05cb4cf6edba458881d4696f26e1d8` moved it under `archive/` without changing its contents.

The active port preserves the archived state machine, debounce logic, and output assignments. Port adaptations remove unused library imports and the unused duplicate-driven `tristate_signals` vector, expose the OSCH frequency generic to synthesis, and normalize source text. Diamond uses the archived constraints; FOSS has separate constraints that retain JTAG access and correct two bank-2 IO types.

The older root-level archived file and later S3C implementations on `develop` are not incorporated. `s3c_toolchain_test_program` is only a fixed-output build/simulation example. The generator's `s3c_logic.vhdl` implements the D-slot side of the interface, not another S3C controller.

See `docs/s3c.rst` and the program description for the complete provenance and scope.

## Validation

Run in an isolated checkout of the proposed committed catalog, without local experimental programs:

| Check | Result |
| --- | --- |
| `make test` | 181 passed; 4 optional browser tests skipped |
| `make build-all backend=foss` | All 21 catalog programs built successfully |
| `make docs-local` | All 21 program simulations and documentation generation passed; Sphinx passed with warnings treated as errors |
| Documentation site check | 134 HTML pages verified |
| Preparation diff whitespace check | Passed |
| Archived S3C provenance | Exact byte comparison against the pinned historical blob passed |

The full PR includes historical source and archive whitespace; the preparation diff check does not claim that all inherited files are whitespace-clean. A fresh container image build, hosted Actions run, Diamond catalog rebuild, and new hardware programming were not performed as part of this preparation.

### Existing S3C validation limits

- The archived controller leaves both CarrierReady outputs and the front-panel user LEDs undriven, and records a ReqSafeState limitation while the 1.8 V bank is unpowered.
- The program-level cocotb test checks startup outputs. A separate accelerated GHDL integration test covers startup, ready operation, soft stop, and re-enable with the generated D-slot controller. Complete error and shutdown sequences remain outside this coverage.
- The FOSS mapped sequential proof passes, but the initialized-state miter still reports an S3C output counterexample. Successful export does not establish startup equivalence or Diamond/FOSS electrical equivalence.
- These checks do not establish hardware qualification or timing acceptance.

## Preparation cleanup

- Document S3C scope and source commit prominently in the README, dedicated S3C documentation, program descriptions, and source header.
- Untrack the local `selection.toml`; `make programmer` continues to create it from the tracked example. Local hardware assignments are not shipped as repository defaults.
- Include `openssh-client` in the development image so Git can use the forwarded SSH agent.
- Target GitHub Pages artifact upload and deployment at `master`, with matching publishing instructions. Repository administrators must allow `master` in the `github-pages` environment and select GitHub Actions as the Pages source.

Local `cvg_all_on` work, its catalog addition, hardware selection, and `notes.txt` are excluded from this PR preparation.
