# Finding a safe path through Diamond project preparation

Date: 2026-10-02

## Objective

Find a supported Tcl preparation sequence that preserves the intended project settings and avoids Diamond's invalid memory accesses. A sequence that merely stops segfaulting is not sufficient.

## Evidence so far

`diamond-cause-memcheck.zip` confirms use-after-free and double-free in Diamond 3.14's `libprojmngr.so.1.0.0` during project cleanup. The traces show implementation data being freed before `LSECompStatusController` destruction calls `unregisterInjecter`, which accesses that freed data.

All 20 instrumented preparation runs reported memory errors, although none produced a native segfault under Valgrind. Disabling ASLR prevented native crashes in a separate 200-attempt sample, but has not been shown to eliminate the invalid accesses.

The detailed Memcheck reproducer uses an LSE-configured program. Preparation crashes have also been observed in Synplify-configured programs, but an identical underlying cause has not been established for those failures. An LSE controller may be created during initial project creation before the requested engine is selected; this remains a hypothesis to test.

Removing explicit `prj_project close` did not fix the crashes: automatic cleanup at process exit still exercised the failing path.

See [diamond-crash-findings.md](diamond-crash-findings.md) for the consolidated evidence and [local_segfault.md](local_segfault.md) for the local reproduction recipe.

## Experimental plan

### 1. Establish memory-check controls

Run both sequences under Valgrind using the same pinned image, program, environment and inputs:

- Full production preparation: confirm the known errors remain detectable.
- Minimal project creation, save and close: determine whether basic project creation already triggers the defect.

Use fresh projects and processes, disable retries, and retain Tcl scripts, logs, saved projects and Memcheck allocation/free stacks. Confirm Valgrind actually instrumented `pnmainc` and that the intended commands completed. A Tcl error, timeout or missing memory-check report is not a clean result.

Judge results by invalid reads, writes and frees, not only the process exit signal. Keep ASLR configuration identical between variants; ASLR suppression is a separate mitigation experiment.

### 2. Isolate the required operations

Starting from the minimal sequence, add these operations individually:

1. Explicit synthesis-engine selection.
2. Strategy import.
3. Strategy activation.
4. Source addition.
5. Each strategy option.

Respect dependencies: activating an imported strategy requires importing it first. Test combinations where needed. Once a sequence reproduces the defect, remove individual commands to determine which are necessary rather than attributing the defect solely to the last command added.

For the existing reference program, `original/uz_d_voltage_013_tx30`, the generated strategy option is `lse_vhdl2008=False`. An option may change the manifestation of an existing defect without introducing it, so inspect the memory stacks as well as error counts.

### 3. Compare synthesis engines

Repeat otherwise-identical preparation experiments with LSE and Synplify. Use the corresponding engine-specific options and record those differences explicitly.

Compare allocation and destruction stacks to determine whether the LSE controller remains involved after selecting Synplify, and whether an engine transition contributes to the defect. Do not assume switching production programs to Synplify is a fix.

### 4. Test supported alternatives at the failing boundary

Depending on the isolated trigger, investigate:

- Configuring the existing strategy instead of importing another.
- Selecting the synthesis engine earlier or later.
- Selecting the intended engine during project creation, if Diamond supports it.
- Opening an existing project template instead of creating a project through the failing sequence.

These are hypotheses, not validated workarounds. Verify supported commands before implementing them. Preserve required source lists, constraints, device selection, synthesis engine, language standard and strategy values.

### 5. Validate a candidate

An acceptable alternative must:

- Complete preparation successfully and retain the intended settings in the saved project.
- Pass repeated Memcheck runs without the identified invalid memory accesses.
- Pass repeated native preparation tests locally and in CI without retries, with a failing control demonstrating that the experiment still detects the original defect.
- Build all catalog programs and pass existing synthesis, timing-report and exported-artifact validation, followed by packaging.

Successful builds alone do not establish hardware timing acceptance or prove the absence of every possible vendor defect. Report exactly what was checked.

## Decision point

**The first decisive question is whether minimal create/save/close is memory-clean.**

If it is clean, isolate the additional operation or combination that exposes the defect and seek an equivalent supported sequence.

If it already reports the same errors, prioritize opening an existing project, testing another Diamond version, or obtaining a vendor patch. Reordering strategy operations is then less likely to address the underlying problem.

ASLR suppression remains a temporary symptom mitigation. A fundamental vendor fix would correct the internal object lifetime so the controller cannot access implementation state after its destruction.

## Current status

This document records the proposed investigation. The focused experiment sequence and a memory-clean alternative have not been completed. Earlier partial diagnostic edits are preserved in the stash named `diamond-investigation-paused-2026-10-02`; inspect them on the investigation branch before resuming work.
