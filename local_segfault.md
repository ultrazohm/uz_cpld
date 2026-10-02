# Local reproduction of the Diamond CI segfault

Date: 2026-10-02

The native crash **reproduced locally using the actual GitHub Container Registry image**, with the CI preparation inputs and effective container limits. Diamond exited with **SIGSEGV (`-11`) during `prj_project close`**, after `prj_project save` completed successfully.

The failure occurred on overall attempt **183 of 200** (block 2, attempt 83). The failed Tcl log is **byte-for-byte identical** to the CI reference lane's `candidate-1/attempt-0051/diamond.log`. All 21 failures in that CI reference lane also exited `-11` at `prj_project close`.

This closes the gap described in `codex-crash.md`: earlier local tests used a full installation and a locally pruned copy, rather than the image pulled from GHCR.

## Pinned inputs

- Source commit: `a96dc0497633a9a804421833364142c29e56c8e5`.
- CI reference: [Isolate Diamond crash causes, run 37017235837](https://github.com/ultrazohm/uz_cpld/actions/runs/37017235837), `reference` lane.
- GHCR base image, pulled by the digest recorded in CI:

  ```text
  ghcr.io/schindlerto/lattice-diamond@sha256:7181d9ed28fa1804f3fc120ae6f05ea8ebc76d1df1d4e88d0fa5006d025bc509
  ```

- Toolchain layer: built from the unchanged `.devcontainer/Dockerfile` at that commit, using target `toolchain` and the pinned image as `TOOLCHAIN_BASE`.
- Local toolchain tag: `uz-cpld-local-ci-a96dc04`.
- Recorded derived image ID: `sha256:adcf045707edcc34039700e1a54ed863100f143f38d993c31cfb908b4bf8a7c1`.

The completed toolchain image was rebuilt locally; it was not downloaded as a prebuilt CI toolchain image. Comparison against CI nevertheless confirmed identical installed Debian package versions and all **769 recorded native-file hashes**, including the captured Diamond and system-library files.

## Results

| Run | Result |
| --- | --- |
| Local production workflow: synthesis smoke test, all catalogs, packaging | All 81 builds passed; packaging exited 0; no retry logs |
| Local preparation replay with workflow launch options and local inherited limits | 400 successes; 0 segfaults |
| Local preparation replay with clean CI inputs and explicitly matched CI limits | 199 successes; 1 segfault in 200 attempts |
| GitHub CI reference lane | 21 segfaults in 400 attempts: 10 control, 11 candidate |

The preparation replays were sequential, without retries, and exercised project creation/save/close before synthesis. Each local replay block ran in a fresh container.

The first local replay followed the production build, which had allocated a new firmware identity. Its Tcl script, strategy and source hashes matched CI, but its constraints differed. The second local replay used a separate clean checkout: **all preparation input hashes, including constraints, matched CI**.

## Settings used for the reproduced failure

The matched run used the same numeric user as CI, **1001:1001**, with no corresponding passwd account. Using the local host's UID 1000 would instead select the image's `vscode` account and would not match CI.

| Setting | Value |
| --- | --- |
| Platform | `linux/amd64` |
| Init | `--init` |
| Network | Bridge, MAC `10:91:d1:3d:14:ae` |
| User | `1001:1001`, no passwd account |
| HOME | `/tmp` |
| License variable | `LM_LICENSE_FILE=/opt/diamond/license/license.dat` |
| Workspace and working directory | `/work` |
| Inherited Qt variable | `QT_GRAPHICSSYSTEM=native` |
| Core limit | `0` |
| Stack soft/hard limits | `16777216` bytes / unlimited |
| Open-file soft/hard limits | `65536` / `65536` |
| Pending-signal soft/hard limits | `63848` / `63848` |
| Shared memory | 64 MiB |
| CPU affinity | CPUs `0-3` |
| PID cgroup limit | `19154` |
| Replay mode and timeout | `traced`, 30 seconds per attempt |
| Program | `original/uz_d_voltage_013_tx30` |

These inherited limits were taken from the actual CI environment artifact, not assumed from the YAML alone. All captured process limits, CPU affinity, captured Diamond environments, source hashes and preparation input hashes matched the CI reference.

The matched replay command, run from the clean checkout with an existing toolchain image, was equivalent to:

```bash
docker run --rm --init --platform linux/amd64 \
  --network=name=bridge,mac-address=10:91:d1:3d:14:ae \
  --user 1001:1001 --env HOME=/tmp \
  --env LM_LICENSE_FILE=/opt/diamond/license/license.dat \
  --mount "type=bind,source=$PWD,target=/work" -w /work \
  --ulimit core=0 --ulimit stack=16777216:-1 \
  --ulimit nofile=65536:65536 --ulimit sigpending=63848:63848 \
  --shm-size 64m --cpuset-cpus 0-3 --pids-limit 19154 \
  uz-cpld-local-ci-a96dc04 \
  python3 -m toolchain.diagnose_diamond replay \
  --output /work/toolchain/build/local-matched/block-1 \
  --mode traced --attempts 100 --timeout 30
```

The command was run twice with separate output directories (`block-1` and `block-2`). The clean checkout was owned by UID/GID 1001 during execution so Git and workspace writes behaved as in CI. Ownership was restored to the local user afterward. Replay requires a fresh output directory.

## Failure evidence

The final trace lines were:

```text
UZ_CPLD_DIAMOND_BEFORE 7: prj_project save
UZ_CPLD_DIAMOND_AFTER 7: prj_project save
UZ_CPLD_DIAMOND_BEFORE 8: prj_project close
```

The result recorded:

- Native return code: `-11` (`SIGSEGV`).
- Timeout: false.
- Peak process RSS: **66,032 KiB**.
- OOM and OOM-kill counters: zero.
- Duration: approximately 1.26 seconds.

Evidence is retained under [`toolchain/build/local-ci-reproduction/`](toolchain/build/local-ci-reproduction/):

- [Local crash result](toolchain/build/local-ci-reproduction/matched-checkout/toolchain/build/local-matched/block-2/attempt-0083/result.json).
- [Local crash log](toolchain/build/local-ci-reproduction/matched-checkout/toolchain/build/local-matched/block-2/attempt-0083/diamond.log).
- [Saved project from the failed attempt](toolchain/build/local-ci-reproduction/matched-checkout/toolchain/build/local-matched/block-2/attempt-0083/project/).
- [Matching CI failure log](toolchain/build/local-ci-reproduction/ci-reference/candidate-1/attempt-0051/diamond.log).
- [Environment, package, hash and outcome comparison](toolchain/build/local-ci-reproduction/comparison.json).
- [Pinned provenance and image ID](toolchain/build/local-ci-reproduction/provenance.json).
- [Production output](toolchain/build/local-ci-reproduction/production.log).
- [Production and initial replay recipe](toolchain/build/local-ci-reproduction/run.sh).
- [Matched-limit replay recipe](toolchain/build/local-ci-reproduction/run-matched.sh).

These evidence paths are local build artifacts; this Markdown file alone does not preserve their contents if the build directory is removed. Original working files were not edited by the reproduction.

## Interpretation and remaining differences

The CI failure stage is reproducible locally with the GHCR image. It is intermittent and occurred less frequently in this local sample: 1/200 versus CI's 21/400. A passing production build or a short preparation test therefore does not establish that the crash is absent.

This experiment **does not establish the root cause or identify which setting changes the failure frequency**. Multiple resource settings and the firmware identity constraints differed between the two local replays, so attributing the failure to stack size, UID, CPU affinity, pruning, or another single factor would be unsupported.

The local host used kernel `7.0.0-34-generic`; CI used `6.8.0-1064-azure`. Among the compared system settings, `vm.max_map_count` remained different: local `1048576`, CI `262144`. Physical CPU, host RAM, container runtime, storage and scheduling also remain host-dependent.

No core dump was generated because the CI configuration uses `--ulimit core=0`. The matching SIGSEGV and identical Tcl trace establish the same observed failure stage, but do not establish an identical native stack.
