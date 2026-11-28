Python programmer API
=====================

The installed ``ultrazohm-cpld-user`` package and the developer checkout expose
``cpld_toolchain.programmer``. The CLI and Tk GUI use the same application layer.
Python callers do not need Tk, Typer, or a running GUI. Local firmware builds
still require the developer toolchain and its build dependencies.

Prepare and execute
-------------------

A workspace holds selected firmware, assignments, and operation records.
Paths supplied to methods are relative to the Python process's current directory;
use absolute paths when the workspace and current directory differ.

.. code-block:: python

   from cpld_toolchain.programmer import Programmer

   programmer = Programmer("./programmer-workspace", backend="foss")
   firmware = programmer.select_firmware("./firmware.zip")
   print(firmware["cycles"])  # Available releases and programs by target

   selection = {"release": "heartbeat_cvg", "s3c": "s3c_heartbeat"}
   plan = programmer.prepare_programming(
       selection,
       target="s3c",
       firmware=firmware["firmware"],
       expected_sha256=firmware["sha256"],
   )
   print(plan.summary)

   # Explicitly execute only after reviewing the plan and physical JTAG state.
   result = programmer.execute(plan)
   print(result["devices"], result["record"])

Preparation validates firmware and creates staging files; it does not access USB
or write Flash. Execution retains the existing firmware revalidation, USB locks,
Flash verification, and identity readback. Treat ``ProgrammingPlan`` as an opaque,
process-local object; do not construct, mutate, serialize, or reuse it across
software versions. Execute it with the same workspace and probe configuration.

For D-slots, use ``target="dslot"`` and supply all five assignments in
``selection["slots"]`` with string keys ``"1"`` through ``"5"``. A selection TOML
path can replace the dictionary. Omit ``firmware`` to program validated local
builds, optionally specifying ``release`` and ``build_backend``.

Other operations
----------------

* ``scan(target=None)`` returns detected devices and whether the chain matches.
  Omit the target to discover S3C versus D-slots.
* ``identify(target=None, firmware=None)`` reads installed firmware identities.
* ``load()`` returns the saved firmware catalog and assignments.
* ``save_assignments(selection, override=False)`` writes exactly the supplied
  assignments to ``selection.toml``. S3C-only selections remain S3C-only; if
  ``slots`` is supplied it must contain all five positions. Existing files raise
  an error unless replacement is explicit. The result includes the saved selection.
* ``initialize_assignments(...)`` explicitly creates the editable CLI template,
  including its historical default assignments. The CLI's ``init_programmer``
  keeps this behavior; normal saving never fills in defaults.
* ``releases()`` lists published firmware. ``download(release_id, commit=...)``
  downloads and selects that exact release.
* ``download_firmware(stable=True)`` downloads without changing the selection.
  Use ``branch`` and ``git_url`` for a branch, or the default checkout discovery
  with ``stable=False``.
* ``build_selection(path, release=None, target=None, backend="diamond")`` builds
  selected local programs through the developer backend.
* ``setup_drivers(device_id=None, default=False)`` configures Windows drivers.
  Use ``default=True`` for the installed application's platform default, including
  Linux USB permission rules. This explicit operation can request OS elevation.

Probe configuration belongs to the ``Programmer`` constructor: ``backend``,
``cable``, ``serial``, and ``probe_index``. Serial and index are mutually exclusive;
Diamond supports index selection but not a custom cable or serial.

Operations never ask application confirmation questions or exit Python.
Validation errors raise ``ProgrammerError``; OS and external-tool exceptions
remain available to callers. Library diagnostic text is quiet by default.
Pass ``on_event=callback`` to receive dictionaries containing ``operation`` and
``phase`` (``started``, ``log``, ``completed``, or ``failed``); log events also have
``text``. Callbacks must not raise. Events describe stages, not percentage progress.

Calls are synchronous. Diagnostics use an operation-local context rather than
redirecting process-global stdout; unrelated threads' output is unaffected.
Callbacks run on the calling thread and must not raise. Use worker processes to
keep GUI event loops responsive. Hardware access remains serialized by backend
locks. Native tools may also write their own diagnostics.

JSON worker for another interface
---------------------------------

Run one request in an isolated process::

   python -m cpld_toolchain.programmer request.json response.json

For example, ``request.json`` can contain:

.. code-block:: json

   {"action": "load", "workspace": "/absolute/path/to/workspace"}

Supported actions include ``load``, ``select``, ``releases``, ``download``,
``download_firmware``, ``save``, ``initialize``, ``scan``, ``identify``,
``build_selection``, ``prepare``, ``execute``, ``program``, and ``drivers``.
The same protocol is available through ``operate(request)`` or
``Programmer.request(action, **options)``. Response files contain ``ok: true`` and
operation fields, or ``ok: false`` and ``message``. Exit codes are 0 and 2.
Redirect worker stdout/stderr to diagnostics, separately from the JSON response.

Prepare a reviewed plan in one worker request:

.. code-block:: json

   {
     "action": "prepare",
     "workspace": "/absolute/path/to/workspace",
     "backend": "foss",
     "target": "s3c",
     "firmware": "/absolute/path/to/firmware.zip",
     "selection": {"release": "heartbeat_cvg", "s3c": "s3c_heartbeat"}
   }

The response includes ``summary``, firmware checksums, ``plan_id``, and
``review_sha256``. Display the summary and retain both returned values. After
confirmation, execute from another worker process:

.. code-block:: json

   {
     "action": "execute",
     "workspace": "/absolute/path/to/workspace",
     "backend": "foss",
     "plan_id": "<returned plan_id>",
     "review_sha256": "<returned review_sha256>"
   }

The plan record is stored under ``build/programmer/plans`` in the workspace.
Execution verifies the record checksum and workspace/probe configuration, then
reconstructs the backend plan and compares firmware bytes and identities with
what was reviewed before contacting hardware. Changed inputs require a new
review. The same operations are available through ``prepare_review(...)`` and
``execute_review(plan_id, review_sha256)`` in Python. Records are data only and
never contain executable Python objects. Keep them only as long as needed;
cleanup invalidates their IDs. Executing the same valid plan again is explicit
and repeats programming; plan IDs are not single-use tokens.

``program`` prepares and executes immediately and corresponds to the Python
``program(...)`` method. Callers must confirm before submitting this action.
Both ``prepare`` and ``program`` accept a selection dictionary or TOML path,
``target``, ``release``, ``build_backend``, optional ``firmware``, and optional
``expected_sha256``. Omit ``firmware`` for local builds. An explicit ``source``
may be ``local`` or ``zip`` and must agree with the firmware argument.
``build_selection`` takes ``selection``, optional ``target`` and ``release``,
and ``build_backend`` (default ``diamond``).

``select`` takes ``firmware``. ``download`` takes ``release_id`` and
``release_commit`` and selects that exact release. ``download_firmware`` accepts
``stable``, ``git_url``, ``branch``, ``remote`` and ``output`` and does not select.
``save`` takes ``selection``, optional ``destination`` and ``override``;
optionally supply ``firmware`` and ``expected_sha256`` to validate assignments
against a package and select its snapshot. ``initialize`` explicitly uses the
legacy template defaults. ``scan`` and ``identify`` accept an optional target;
identify may also receive firmware and its expected checksum.

Unknown action options (including ``dry_run``) are rejected before execution;
use ``prepare`` for a review without hardware access.

All requests can specify ``backend``, ``serial``, ``cable``, and ``probe_index``;
execution must use the same configuration as preparation. ``drivers`` accepts
``device_id`` and ``default_driver`` and does not require a writable workspace.
The existing ``cpld_toolchain.programmer_service`` entry point remains compatible.
