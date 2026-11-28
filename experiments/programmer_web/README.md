# Programmer web GUI prototype

An isolated experimental GUI. All files live in this directory; the existing
toolchain, Tk GUI, packaging, and CI configuration are unchanged.

The same HTML/CSS/JavaScript runs as an editor tab inside VS Code or as a
standalone application. There is no frontend build step or npm dependency.
Real operations use `cpld_toolchain.programmer.operate`; the prototype adds
transport and presentation only.

## Try it without hardware

From the repository root:

```sh
python3 experiments/programmer_web/standalone.py --demo
```

This opens a browser on a loopback URL. Demo mode is explicitly marked in the
UI and simulates **every** operation, including downloads, file saving, driver
setup, and programming. It does not invoke real programmer operations or access hardware.

To print the URL without opening the browser, add `--no-open`.

## VS Code editor tab

Launch an Extension Development Host with the prototype directory:

```sh
code --new-window --extensionDevelopmentPath="$PWD/experiments/programmer_web" "$PWD"
```

In that new window, run **UltraZohm: Open Programmer Demo** from the Command
Palette. For real operations, use **UltraZohm: Open Programmer Preview**.
Close the existing programmer tab before switching between demo and real mode.

Set `uzCpldPreview.pythonPath` to the Python executable in your toolchain
environment if the default Python does not have the toolchain dependencies.
The bridge locates this checkout automatically; a writable programmer workspace
can be selected independently with **Change…**.

The UI uses the actual active VS Code theme's CSS variables for backgrounds,
foregrounds, buttons, inputs, dropdowns, borders, links, and focus indicators.
Changing themes updates the existing view without a reload. It also uses VS
Code's font, native file/folder dialogs, editor tab, progress indicator, and
Output channel. It does not override VS Code's theme variables.

This is a local UI extension because the USB probe is local. For SSH, WSL, and
container workspaces, choose a **local** writable workspace and local firmware
ZIP. Remote builds and transferring firmware from a remote workspace are not
implemented in this prototype.

## Standalone desktop window

Use Python with the existing toolchain dependencies and optional `pywebview`:

```sh
python -m pip install pywebview
python experiments/programmer_web/standalone.py --desktop --demo
```

pywebview also requires a platform webview backend (for example, GTK/WebKit or
Qt on Linux). The browser launcher needs only Python's standard library for
demo mode. Standalone appearance follows the OS light/dark preference; it does
not need a running VS Code instance.

For real use, omit `--demo` and choose a writable workspace:

```sh
python experiments/programmer_web/standalone.py --workspace /path/to/workspace
```

The standalone host listens only on `127.0.0.1`, uses a per-launch API token,
and rejects requests using other Host headers. Browser mode accepts local ZIP
and workspace paths; desktop mode provides native dialogs.

## Implemented workflows

- Load or change workspace; select and validate a ZIP; list/download published
  firmware, with testing releases explicitly selectable.
- Choose a release and S3C or all five D-slot assignments; save assignments.
- Select FOSS/Diamond, serial/cable/probe index; scan and read identities.
- Prepare a review with the API, display assignments/checksums, require physical
  chain confirmation, and execute using the returned plan ID and checksum.
- Driver setup on Windows; terminal instructions for Linux USB permissions.
- Live diagnostic output, busy state, readback table, keyboard navigation, and
  responsive layout.

The API owns validation, firmware checks, locks, planning, programming, and
verification. `bridge.py` delegates to the shared `cpld_toolchain.programmer.worker` protocol.
The standalone host uses the shared Python client; VS Code uses a JavaScript
client for the same versioned JSON request, event, and result messages. No web server is needed inside VS Code.

Closing the VS Code panel leaves an active operation running; completion is
reported through VS Code and the Output channel. The standalone server likewise
keeps jobs independent of a browser tab, and waits for an active worker on normal
shutdown. There is deliberately no forced cancellation button for Flash writes.
Surviving an editor/process crash and packaged installers are outside this
prototype's scope.

## Validation

Transport tests (use the same Python environment as the toolchain):

```sh
python -m unittest discover -s experiments/programmer_web/tests -p 'test_transport.py' -v
```

Browser workflow/theme tests additionally need Playwright and a Chrome/Chromium
executable. Set `CHROME_PATH` if it is not `/usr/bin/google-chrome`:

```sh
python -m pip install playwright
python -m unittest discover -s experiments/programmer_web/tests -p 'test_browser.py' -v
```

These tests use demo mode for all hardware operations. Real USB programming and
platform-specific pywebview dialogs require manual validation on a connected
machine. Existing project test and CI configuration does not include this
experimental directory.

The prototype was also exercised in an actual VS Code Extension Development
Host: demo scan/programming completed, and changing between Default Light
Modern, Default Dark Modern, and Default High Contrast updated the embedded
page without recreating its JavaScript state.
