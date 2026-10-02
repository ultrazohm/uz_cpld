# Diamond crash investigation: findings and next steps

Status: 2026-10-02. Investigated toolchain: Lattice Diamond 3.14. Reference source commit: `a96dc0497633a9a804421833364142c29e56c8e5`.

## Conclusion

**The crash is reproducible locally, not only in GitHub Actions.** The latest local reproduction used the actual pinned GHCR base image, matching recorded CI binaries, packages, preparation inputs and process limits. One of 200 preparation attempts crashed at `prj_project close`.

**Valgrind confirms use-after-free and double-free inside Diamond's project cleanup code.** CI native backtraces also lead into this cleanup path. This is substantially stronger evidence than the earlier hypotheses about insufficient RAM, Docker configuration or missing libraries.

There is no validated permanent fix yet. Removing explicit project close does not fix the problem. Retries currently mitigate intermittent failures; they do not correct the invalid memory accesses. Disabling ASLR and omitting strategy commands stopped native crashes in their respective samples, but neither result establishes memory-safe behavior.

## What fails

Our Python toolchain generates Tcl that creates a project, selects the synthesis engine, imports and configures its strategy, adds sources, saves, and closes the project. The diagnostic reproducer runs this preparation sequence without synthesis or programming hardware, using `original/uz_d_voltage_013_tx30`.

The native failures occur after a successful save, during project destruction:

```text
UZ_CPLD_DIAMOND_BEFORE 7: prj_project save
UZ_CPLD_DIAMOND_AFTER 7: prj_project save
UZ_CPLD_DIAMOND_BEFORE 8: prj_project close
```

Yes, our generated Tcl explicitly calls `prj_project close`. However, Diamond also destroys the project automatically when its process exits. Removing the command moves the failing cleanup to process exit rather than avoiding it. Explicit close has therefore been restored.

The preparation replays are sequential, use fresh projects and disable retries. Build-level parallelism is not required to reproduce this failure.

## Confirmed invalid memory accesses

The downloaded [Memcheck artifact](diamond-cause-memcheck.zip) contains 20 error-bearing `pnmainc prepare.tcl` logs. Each reports **16 errors from 13 contexts**, totaling 320 reported errors across 20 runs. These are repeated observations of the cleanup defect, not 320 independent bugs. Other helper-process logs contain no reported errors.

The allocation and destruction stacks show this sequence in `libprojmngr.so.1.0.0`:

1. Project creation allocates implementation state and registers an LSE status controller.
2. `BaliImplementationPrivate` destruction frees vector and string storage.
3. `BaliImplementation` destruction deletes the private state, a 352-byte allocation.
4. `LSECompStatusController` destruction calls `BaliImplementation::unregisterInjecter`, which reads and writes the freed state, accesses freed vector/string storage and frees a string again.

A representative report identifies a read 288 bytes into the already-freed 352-byte block. Its call stack is:

```text
BaliImplementation::unregisterInjecter
LSECompStatusController::~LSECompStatusController
BaliImplementation::~BaliImplementation
...
BaliProjectManager::closeProject
ProjectCloseCmd
```

The string-comparison instruction implicated by Memcheck also matches the location implicated by the captured native CI crash traces. With explicit close, the caller is `ProjectCloseCmd`; without it, the path runs through Tcl/process exit and project-manager destruction.

Under Valgrind these attempts completed their Tcl sequence without native SIGSEGV, but all 20 failed the memory check with exit code 86. **A process that exits without a segfault can still execute the same invalid memory accesses.** This matters when evaluating apparent workarounds.

The allocation stack includes initial project creation and synthesis-controller registration. It does not by itself prove that a particular later strategy command introduces the defect.

## Local reproduction and correction of the earlier assumption

The detailed reproduction recipe and retained evidence are in [local_segfault.md](local_segfault.md). Earlier local tests used a host installation and a locally pruned copy inside the existing development container. Those were not equivalent to running the actual GHCR-based CI environment.

The new test pulled:

```text
ghcr.io/schindlerto/lattice-diamond@sha256:7181d9ed28fa1804f3fc120ae6f05ea8ebc76d1df1d4e88d0fa5006d025bc509
```

The final toolchain layer was rebuilt locally from the unchanged project Dockerfile; it was not the exact final image downloaded from CI. Nevertheless, all **769 recorded native-file hashes** and installed Debian package versions matched CI. The clean-checkout replay also matched source and preparation-input hashes, including constraints.

| Test | Observed outcome |
| --- | --- |
| Local GHCR-based smoke test, all catalogs and packaging | 81 builds passed, no retry logs |
| Local replay with workflow options and inherited local limits | 0 crashes / 400 attempts |
| Local clean-checkout replay with captured CI limits | **1 crash / 200 attempts** |
| CI reference, identical control and candidate | **21 crashes / 400 attempts** |

The local crash occurred on overall attempt **183**, block 2 attempt 83. It returned `-11` (SIGSEGV), did not time out, and reached the same final Tcl marker as CI. Its log is byte-for-byte identical to the CI reference lane's `candidate-1/attempt-0051/diamond.log`.

The local failing process peaked at **66,032 KiB RSS**, with zero recorded OOM/OOM-kill counters. Its duration was approximately 1.26 seconds.

The first 400-attempt local replay had different resource limits and a different firmware-identity constraint, allocated by the preceding production build. The matched replay changed multiple factors together. Consequently, the result cannot identify stack size, CPU affinity, identity or another individual factor as the reason the crash appeared.

Local kernel `7.0.0-34-generic` and CI kernel `6.8.0-1064-azure` still differ. So do `vm.max_map_count`, physical hardware and host-dependent runtime behavior. These can affect manifestation without being necessary causes. The observed rates, 0.5% locally versus 5.25% in the CI reference sample, are not universal probabilities.

Core dumps were disabled in the local replay to match CI. Thus the local evidence establishes the same observed failure stage, **not an independently verified identical native stack**.

## Controlled CI experiments

The main [cause matrix, run 37017235837](https://github.com/ultrazohm/uz_cpld/actions/runs/37017235837), ran paired control/candidate experiments on the same runner. Most lanes used four sequential blocks: control 100, candidate 100, candidate 100, control 100. There were no retries. Memcheck used 10 attempts per candidate block.

Counts below are native segfaults, not memory-check errors. Each ordinary column represents 200 attempts. Controls belong to their individual lanes and should not be pooled as if all conditions were identical.

| Candidate change | Control crashes | Candidate crashes | Interpretation |
| --- | ---: | ---: | --- |
| None: reference A/A | 10 | 11 | Baseline variability |
| Account | 7 | 9 | Not eliminated |
| HOME | 12 | 11 | Not eliminated; counts from console logs |
| Temporary directory | 8 | 10 | Not eliminated |
| One CPU | 13 | 6 | Not eliminated |
| Unlimited stack | 9 | 5 | Not eliminated |
| 1 GiB shared memory | 7 | 10 | Not eliminated |
| 2 GiB memory cap | 10 | 11 | Not eliminated |
| Allocator perturbation | 6 | 4 | Not eliminated |
| Allocator tcache disabled | 7 | 7 | Not eliminated |
| ASLR disabled | 14 | **0** | Promising symptom suppression; not a proven fix |
| Seccomp disabled | 16 | 7 | Not eliminated |
| 250 ms delay before close | 9 | 11 | Not eliminated |
| Event-loop update | 9 | 14 | Not eliminated |
| All strategy commands omitted | 13 | **0** | Needs Memcheck and settings-preserving follow-up |
| Explicit engine selection omitted | 11 | 5 | Not eliminated |
| Minimal create/save/close | 14 | **0** | Reduced reproducer, not production-equivalent |
| Memcheck | 5 | 0 / 20 | **All 20 reported invalid memory accesses** |
| strace | 13 | 7 | Tracing did not eliminate crashes |
| Read-only installation mount | 4 | 8 | Not eliminated |
| Vendor environment initialization | 17 | 15 | Not eliminated |
| Qt environment unset | 6 | 9 | Not eliminated |
| Alternate Ubuntu-based toolchain image, same vendor copy | 10 | 10 | Not eliminated; not a full-installation test |
| Ubuntu 24 runner A/A | 3 | 8 | Still crashes |
| Full vendor installation | — | — | Not run: full image unavailable |

The HOME lane's artifact was accidentally excluded by the upload pattern `!**/home/**`; console output supplies its counts. This is a diagnostic collection defect to fix before reusing that workflow. A red matrix run can reflect expected control crashes rather than failure to execute the experiment.

Earlier focused experiments reinforce these findings:

| Experiment | Evidence | Result |
| --- | --- | --- |
| Explicit close versus automatic cleanup on exit | [Run 37005233105](https://github.com/ultrazohm/uz_cpld/actions/runs/37005233105) | 11/300 versus 13/300 crashes; removing close did not fix it |
| Native cleanup traces | [Run 37007661134](https://github.com/ultrazohm/uz_cpld/actions/runs/37007661134), `diamond-exit-traces-1.zip` | Captured crashes converge on string comparison / `unregisterInjecter` during destruction |
| Tested glibc package update, revision .14 to .15 | [Run 37010821523](https://github.com/ultrazohm/uz_cpld/actions/runs/37010821523) | 16/300 versus 12/300 crashes; update did not fix it |
| Successful full production CI | [Run 36999802964](https://github.com/ultrazohm/uz_cpld/actions/runs/36999802964) | Published successfully, but recovered three preparation segfaults through retries |

## Assessment of possible causes

### Diamond object-lifetime defect: confirmed

Memcheck identifies access after deallocation and a repeated free inside Diamond's implementation cleanup. Native CI traces implicate the same cleanup code. This is the strongest explanation for the investigated crashes. The exact sequence that exposes the defect, and the safest way to avoid it while preserving build settings, remain unresolved.

### Insufficient RAM: evidence argues against it here

A segfault can in principle result from mishandling an allocation failure; the signal alone does not rule that out. In these experiments, however, preparation used roughly 66 MiB RSS, sampled CI host-available memory remained above roughly 13 GiB across the matrix, and recorded OOM-kill counters were zero. Memcheck directly shows access to previously freed allocations.

Increasing available RAM does not repair that object lifetime. These measurements concern project preparation, not the maximum memory required for every later synthesis or place-and-route job.

### Container pruning or runtime libraries: not established as the trigger

The upstream container recipe installs Diamond, then copies an allowlist into a fresh runtime stage. It omits unused tools, device data and documentation rather than patching Diamond binaries. Matching native hashes helps exclude binary differences, but does not prove that all required non-binary data is present.

The tested glibc update and alternate runtime image did not eliminate crashes. The matched GHCR-based image now crashes locally too. A full-versus-pruned comparison in an otherwise identical environment remains missing, so pruning cannot be completely ruled out as a trigger. It should not be presented as the established cause.

### Host settings and memory layout: possible modifiers

The same container does not imply the same kernel, hardware, resource limits or memory layout. ASLR suppression stopping observed crashes is consistent with sensitivity to memory layout. It does not demonstrate that ASLR itself is defective. The other configuration changes continued to crash, and their differing counts alone do not prove causal improvements.

### Why retrying helps

A retry starts a new process and a fresh project. Allocation placement and contents of freed memory can differ between attempts. Invalid accesses can therefore happen to survive in one execution and fault in another. This interpretation is consistent with both the ASLR result and the runs that completed under Valgrind while still reporting errors.

Retries improve the chance of completing a build, but cannot guarantee absence of memory corruption. Likewise, a successful full build or a few hundred successful native preparations is not proof that the defect has gone away.

## How to continue

1. **Use the matched local reproducer for focused experiments.** Keep the pinned image, clean inputs and recorded limits. First establish a local Memcheck baseline; local native reproduction is already demonstrated, local Memcheck reproduction is not yet documented.
2. **Separate the strategy operations.** Test import, strategy selection and individual `set_value` operations independently under Memcheck. Recheck the no-strategy and minimal variants under Memcheck too: their zero native crashes may merely hide the same invalid accesses.
3. **Find a preparation sequence that preserves the intended build settings.** Check the resulting saved project, selected engine, strategy values, sources and constraints. Do not accept simply dropping required strategy configuration as a fix.
4. **Validate any candidate at both levels.** Require absence of the identified Memcheck errors, then repeated native preparations with retries disabled on local and CI environments, followed by all 81 program builds, artifact validation and packaging. Retain failing controls to demonstrate that the experiment still detects the defect.
5. **If no safe sequence exists, test a vendor fix or another supported Diamond version.** Assemble the small reproducer, stacks, memory-error logs and pinned environment for a Lattice bug report. Compare a full installation if needed to settle the remaining pruning question. No vendor report has been submitted as part of this work.
6. **Keep production mitigation bounded until a fix is validated.** Retain explicit close and the existing limited clean retry behavior; preserve failed-attempt evidence. Do not silently treat a crash as successful or adopt ASLR suppression as a proven correction.
7. **Simplify after validation.** Keep a small regression reproducer and useful failure capture, then retire the broad temporary diagnostic matrix. Fix its HOME artifact exclusion if it is used again.

These are proposed next experiments, not changes implemented by this report.

## Investigation paused and working branch restored

At the user's request on 2026-10-02, further experiments were stopped and the working checkout was returned to `feature/add_heartbeat` at `77b24e5` (the local and fetched remote branch agreed). That branch retains the existing bounded workaround: two attempts total, retrying an eligible SIGSEGV once, with a clean project reset for preparation failures. It does not contain the later diagnostic CI matrix changes.

Before switching, this report and `local_segfault.md` were saved on `codex/diamond-diagnosis`. Copies are retained in the restored checkout for convenience; the downloaded archives and ignored local reproduction evidence are retained too. No new diagnostic workflow was pushed or run during this final session.

An unfinished change to `toolchain/diagnose_diamond.py` had added preparation variants `import-only`, `import-select`, `options-only`, and `options-before-sources`, plus `--strategy-option` for testing individual options. The failing reference program currently has one generated option: `lse_vhdl2008=False`. These edits were **not tested or executed** and establish no additional findings. No focused workflow, memory-clean alternative, or production fix was completed.

The partial diagnostic edits and the pre-existing local changes to `programs/usercodes.json` were preserved together in a Git stash named `diamond-investigation-paused-2026-10-02`. Do not apply that stash wholesale to the restored feature branch: resume it on the investigation branch, or extract only the desired file. The report's earlier findings remain the evidence baseline for resuming work.

To resume, locate the named stash with `git stash list`, switch to `codex/diamond-diagnosis`, and inspect its patch before applying it. Start with the Memcheck checks listed above. Docker and Valgrind were unavailable inside the agent's workspace in the final session, although the mounted host Diamond installation was present; the successful local reproduction was performed in the separately documented host Docker environment.

## Evidence inventory

- [Local reproduction notes and exact Docker recipe](local_segfault.md).
- [Local/CI environment and outcome comparison](toolchain/build/local-ci-reproduction/comparison.json).
- [Pinned local provenance](toolchain/build/local-ci-reproduction/provenance.json).
- [Local failing attempt result](toolchain/build/local-ci-reproduction/matched-checkout/toolchain/build/local-matched/block-2/attempt-0083/result.json).
- [Local failing Tcl log](toolchain/build/local-ci-reproduction/matched-checkout/toolchain/build/local-matched/block-2/attempt-0083/diamond.log).
- [Matching CI Tcl log](toolchain/build/local-ci-reproduction/ci-reference/candidate-1/attempt-0051/diamond.log).
- [Memcheck artifact](diamond-cause-memcheck.zip); representative entry `candidate-1/attempt-0001/memcheck-27.log`.
- [Native exit traces](diamond-exit-traces-1.zip).
- [Main cause-matrix console logs](logs_100266503153.zip).
- Earlier console archives: `logs_100233056469.zip` (close comparison), `logs_100239709537.zip` (native traces), `logs_100248517175.zip` (glibc comparison), `logs_100218281459.zip` (successful production run with recovered crashes).

The linked ZIP files and build directories are local investigation artifacts, not embedded in this report. Retain them separately if cleaning the workspace or sharing this document; GitHub artifact retention is also finite.
