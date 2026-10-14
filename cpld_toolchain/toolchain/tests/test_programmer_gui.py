"""Optional GUI boundaries and managed programmer integration."""
from contextlib import redirect_stdout, redirect_stderr
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import time
import unittest
from unittest.mock import patch

from cpld_toolchain import programmer_gui as gui, programmer_service as service
from cpld_toolchain.programmer_helper.tests import test_release as fixtures
from cpld_toolchain.toolchain.buildsystem.model import BuildError


class ProgrammerServiceTests(unittest.TestCase):
    def setUp(self):
        self.fixture = fixtures.ReleaseTests()
        self.fixture.setUp()
        self.addCleanup(self.fixture.doCleanups)
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name).resolve()
        self.request = dict(workspace=str(self.root), firmware=str(self.fixture.zip),
                            backend='foss', target='s3c', selection={'release': 'published', 's3c': 'controller'})

    def test_catalog_comes_from_validated_package_and_corruption_stops_before_usb(self):
        info = service.catalog(self.fixture.zip)
        self.assertIn('controller', info['cycles']['published']['s3c'])
        self.fixture.zip.write_bytes(b'corrupt')
        with patch('cpld_toolchain.programmer_helper.identify.identify') as identify:
            with self.assertRaises(Exception):
                service.operate(dict(self.request, action='identify'))
        identify.assert_not_called()

    def test_assignments_are_target_filtered_and_not_defaulted(self):
        info = {'cycles': {'release': {'s3c': ['controller'], 'dslot': ['adapter']}}}
        selection = {'release': 'release', 's3c': 'controller', 'slots': {str(i): 'adapter' for i in range(1, 6)}}
        service.validate_assignments(info, selection)
        selection['slots']['3'] = ''
        with self.assertRaisesRegex(BuildError, 'D3'):
            service.validate_assignments(info, selection, 'dslot')
        service.validate_assignments(info, selection, 's3c')

    def test_identify_uses_shared_reader_and_package_registry(self):
        with patch('cpld_toolchain.programmer_helper.identify.identify', return_value=[{'label': 's3c'}]) as identify:
            result = service.operate(dict(self.request, action='identify'))
        self.assertEqual(result['devices'], [{'label': 's3c'}])
        self.assertEqual(identify.call_args.kwargs['firmware'], self.fixture.zip)

    def test_identify_without_package_or_target_uses_read_only_discovery(self):
        request = dict(self.request, action='identify', firmware='')
        request.pop('target')
        with patch('cpld_toolchain.programmer_helper.identify.identify', return_value=[]) as identify:
            service.operate(request)
        identify.assert_called_once_with(self.root, None, 'foss', serial=None)

    def test_identify_s3c_without_package_keeps_explicit_target(self):
        with patch('cpld_toolchain.programmer_helper.identify.identify', return_value=[]) as identify:
            service.operate(dict(self.request, action='identify', firmware=''))
        identify.assert_called_once_with(self.root, 's3c', 'foss', serial=None)

    def test_package_checksum_matches_the_firmware_reviewed_in_the_window(self):
        with patch('cpld_toolchain.programmer_helper.identify.identify') as identify:
            with self.assertRaisesRegex(BuildError, 'changed after it was displayed'):
                service.operate(dict(self.request, action='identify', expected_sha256='0' * 64))
        identify.assert_not_called()

    def test_version_listing_does_not_select_or_download_firmware(self):
        with patch('cpld_toolchain.toolchain.firmware_download.available', return_value=[{'id': 12}]), \
                patch('cpld_toolchain.firmware_choice.select') as select:
            result = service.operate(dict(self.request, action='releases'))
        self.assertEqual(result['releases'], [{'id': 12}])
        select.assert_not_called()
        self.assertFalse((self.root / 'firmware.json').exists())

    def test_download_uses_exact_reviewed_release_and_saves_valid_snapshot(self):
        with patch('cpld_toolchain.toolchain.firmware_download.download_release', return_value=self.fixture.zip) as download:
            result = service.operate(dict(self.request, action='download', release_id=12, release_commit='a' * 40))
        download.assert_called_once_with(self.root, 'ultrazohm/uz_cpld', 12, expected_commit='a' * 40)
        self.assertTrue((self.root / 'firmware.json').exists())
        self.assertTrue(Path(result['firmware']).is_file())

    def test_failed_download_keeps_selected_firmware(self):
        from cpld_toolchain.firmware_choice import select
        select(self.root, self.fixture.zip)
        original = (self.root / 'firmware.json').read_bytes()
        with patch('cpld_toolchain.toolchain.firmware_download.download_release', side_effect=BuildError('offline')):
            with self.assertRaisesRegex(BuildError, 'offline'):
                service.operate(dict(self.request, action='download', release_id=12, release_commit='a' * 40))
        self.assertEqual((self.root / 'firmware.json').read_bytes(), original)

    def test_program_uses_managed_plan_execute_and_readback_result(self):
        run = self.root / 'run'
        run.mkdir()
        (run / 'result.json').write_text(json.dumps({'status': 'success', 'devices': [{'label': 's3c'}]}))
        with patch('cpld_toolchain.programmer_helper.program.plan', return_value=('published', self.root, [], [])) as plan, \
                patch('cpld_toolchain.programmer_helper.program.execute', return_value=run) as execute:
            result = service.operate(dict(self.request, action='program'))
        self.assertEqual(plan.call_args.kwargs['source'], 'zip')
        self.assertEqual(plan.call_args.kwargs['firmware'], self.fixture.zip)
        execute.assert_called_once()
        self.assertEqual(result['devices'], [{'label': 's3c'}])

    def test_invalid_assignment_never_plans_hardware_access(self):
        with patch('cpld_toolchain.programmer_helper.program.plan') as plan:
            with self.assertRaises(BuildError):
                service.operate(dict(self.request, action='program', selection={'release': 'published', 's3c': 'invalid'}))
        plan.assert_not_called()

    def test_diamond_scan_uses_vendor_id_field_and_managed_lock(self):
        raw = ''.join(f'Device{i} LCMXO2-2000HC: FLASH Display ID\nID: 0x012BB043\n'
                      'Operation Done. No errors.\n' for i in range(1, 6))
        with patch('cpld_toolchain.programmer_helper.program.require_usb_bus'), \
                patch('cpld_toolchain.programmer_helper.program.run_diamond', return_value=raw) as run:
            result = service.operate(dict(self.request, action='scan', target='dslot', backend='diamond'))
        self.assertTrue(result['chain_matches'])
        self.assertEqual(len(result['devices']), 5)
        run.assert_called_once()

    def test_foss_scan_reports_mismatched_chain_without_programming(self):
        from contextlib import nullcontext
        raw = 'index 0:\n idcode 0x012BC043\n'
        with patch('cpld_toolchain.programmer_helper.identify.programming_preflight'), \
                patch('cpld_toolchain.programmer_helper.program.require_usb_bus'), \
                patch('cpld_toolchain.programmer_helper.program.scan_command', return_value=('loader', '--detect')), \
                patch('cpld_toolchain.programmer_helper.usb.diamond_usb', return_value=nullcontext()), \
                patch('cpld_toolchain.programmer_helper.foss.run', return_value=raw):
            result = service.operate(dict(self.request, action='scan', target='dslot'))
        self.assertFalse(result['chain_matches'])
        self.assertIn('physical JTAG', result['message'])

    def test_foss_scan_without_target_recognizes_s3c(self):
        from contextlib import nullcontext
        request = dict(self.request, action='scan')
        request.pop('target')
        with patch('cpld_toolchain.programmer_helper.identify.programming_preflight'), \
                patch('cpld_toolchain.programmer_helper.program.require_usb_bus'), \
                patch('cpld_toolchain.programmer_helper.program.scan_command', return_value=('loader', '--detect')), \
                patch('cpld_toolchain.programmer_helper.usb.diamond_usb', return_value=nullcontext()), \
                patch('cpld_toolchain.programmer_helper.foss.run', return_value='index 0:\n idcode 0x012BC043\n'):
            result = service.operate(request)
        self.assertTrue(result['chain_matches'])
        self.assertEqual(result['devices'][0]['label'], 'S3C')
        self.assertEqual(result['target'], 's3c')

    def test_driver_restart_is_structured(self):
        def setup(*args, **kwargs):
            kwargs['report']({'restart_required': True, 'already_bound': False})
        with patch('cpld_toolchain.driver_setup.setup', side_effect=setup):
            result = service.operate(dict(self.request, action='drivers'))
        self.assertTrue(result['driver']['restart_required'])
        self.assertIn('Restart Windows', result['message'])

    def test_real_worker_protocol_runs_outside_checkout(self):
        request, response = self.root / 'request.json', self.root / 'response.json'
        request.write_text(json.dumps(dict(self.request, action='select')))
        command = gui.worker_command(request, response)
        env = dict(os.environ, PYTHONPATH=str(Path(service.__file__).resolve().parent.parent))
        result = subprocess.run(command, cwd=self.root, env=env, capture_output=True, text=True, timeout=30)
        self.assertEqual(result.returncode, 0, result.stderr)
        data = json.loads(response.read_text())
        self.assertTrue(data['ok'])
        self.assertTrue((self.root / 'firmware.json').exists())
        self.assertEqual(service.catalog(data['firmware'])['sha256'], data['sha256'])

    def test_worker_errors_are_json_and_do_not_change_saved_selection(self):
        saved = self.root / 'selection.toml'
        saved.write_text('existing')
        request, response = self.root / 'request.json', self.root / 'response.json'
        request.write_text(json.dumps(dict(self.request, action='program', selection={'release': 'missing'})))
        with redirect_stdout(io.StringIO()), redirect_stderr(io.StringIO()):
            self.assertEqual(service.worker(request, response), 2)
        self.assertFalse(json.loads(response.read_text())['ok'])
        self.assertEqual(saved.read_text(), 'existing')

    def test_save_snapshots_firmware_and_reloads_assignments(self):
        selection = {'release': 'published', 's3c': 'controller', 'slots': {str(i): 'adapter' for i in range(1, 6)}}
        with redirect_stdout(io.StringIO()):
            service.operate(dict(self.request, action='save', selection=selection))
        self.fixture.zip.unlink()
        result = service.operate({'workspace': str(self.root), 'action': 'load'})
        self.assertEqual(result['selection']['slots'], selection['slots'])
        self.assertEqual(result['selection']['release'], 'published')
        self.assertTrue(Path(result['firmware']).is_file())
        original = (self.root / 'selection.toml').read_bytes()
        with self.assertRaisesRegex(BuildError, 'already exists'):
            service.operate(dict(self.request, firmware=result['firmware'], action='save', selection=selection))
        self.assertEqual((self.root / 'selection.toml').read_bytes(), original)

    def test_cli_help_does_not_import_tk(self):
        result = subprocess.run([sys.executable, '-c',
            'import sys; from cpld_toolchain.standalone import main; main(["--help"]); '
            'assert "tkinter" not in sys.modules'], capture_output=True, text=True, timeout=30)
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_frozen_worker_uses_sibling_cli_and_paths_are_arguments(self):
        directory = self.root / 'programmer folder'
        request, result = self.root / 'request space.json', self.root / 'result space.json'
        with patch.object(sys, 'frozen', True, create=True), patch.object(sys, 'platform', 'win32'), \
                patch.object(sys, 'executable', str(directory / 'uz_cpld_gui.exe')):
            command = gui.worker_command(request, result)
        self.assertEqual(command, [str(directory / 'uz_cpld.exe'), '--programmer-gui-worker', str(request), str(result)])

    def test_frozen_worker_preserves_native_windows_paths_with_spaces(self):
        from pathlib import PureWindowsPath
        request = PureWindowsPath('C:/Programming station/request file.json')
        result = PureWindowsPath('C:/Programming station/result file.json')
        directory = PureWindowsPath('C:/Program Files/UltraZohm')
        with patch.object(gui, 'Path', PureWindowsPath), patch.object(sys, 'frozen', True, create=True), \
                patch.object(sys, 'platform', 'win32'), \
                patch.object(sys, 'executable', str(directory / 'uz_cpld_gui.exe')):
            command = gui.worker_command(request, result)
        self.assertEqual(command, [str(directory / 'uz_cpld.exe'), '--programmer-gui-worker', str(request), str(result)])

    def test_alternate_ui_runtime_retains_worker_interpreter_and_workspace(self):
        from argparse import Namespace
        args = Namespace(workspace=self.root, check=True)
        with patch.object(gui, 'tk_python', return_value='/usr/bin/python3'), \
                patch.object(gui.subprocess, 'call', return_value=0) as call, \
                patch.dict(os.environ, {}, clear=True), redirect_stdout(io.StringIO()):
            self.assertEqual(gui.alternate_runtime(args, False), 0)
        self.assertEqual(call.call_args.kwargs['env']['UZ_CPLD_GUI_WORKER_PYTHON'], sys.executable)
        self.assertEqual(call.call_args.args[0][-3:], ['--workspace', str(self.root), '--check'])
        with patch.object(sys, 'frozen', True, create=True), patch.object(gui, 'tk_python') as discover:
            self.assertIsNone(gui.alternate_runtime(args, True))
        discover.assert_not_called()

    def test_tk_discovery_searches_past_an_activated_broken_interpreter(self):
        broken = self.root / 'venv/bin/python3'
        working = self.root / 'system/bin/python3'
        for path in (broken, working):
            path.parent.mkdir(parents=True)
            path.touch()
        def which(name, path=None):
            candidate = Path(path) / name if path else self.root / 'missing'
            return str(candidate) if candidate.is_file() else None
        def probe(command, **kwargs):
            good = command[0] == str(working)
            return subprocess.CompletedProcess(command, 0 if good else 1,
                                               str(working) + '\n' if good else '', '')
        with patch.dict(os.environ, PATH=os.pathsep.join([str(broken.parent), str(working.parent)]), UZ_CPLD_GUI_PYTHON=''), \
                patch.object(sys, '_base_executable', str(broken), create=True), \
                patch.object(gui.shutil, 'which', side_effect=which), \
                patch.object(gui.subprocess, 'run', side_effect=probe) as run:
            self.assertEqual(gui.tk_python(), str(working))
        self.assertEqual(run.call_count, 2)

    def test_native_console_suppression_only_applies_to_windows_gui_workers(self):
        from cpld_toolchain import external
        with patch.dict(os.environ, UZ_CPLD_GUI_WORKER='1'), patch.object(sys, 'platform', 'win32'):
            self.assertIn('creationflags', external.process_options())
        with patch.dict(os.environ, UZ_CPLD_GUI_WORKER=''), patch.object(sys, 'platform', 'win32'):
            self.assertEqual(external.process_options(), {})
        with patch.dict(os.environ, UZ_CPLD_GUI_WORKER='1'), patch.object(sys, 'platform', 'linux'):
            self.assertEqual(external.process_options(), {})


class ProgrammerWindowTests(unittest.TestCase):
    def setUp(self):
        try:
            import tkinter as tk
            self.root = tk.Tk()
        except ImportError as exc:
            if os.environ.get('UZ_CPLD_REQUIRE_GUI_TESTS') == '1':
                self.fail(f'Required Tk runtime unavailable: {exc}')
            self.skipTest(f'Tk display unavailable: {exc}')
        except tk.TclError as exc:
            if os.environ.get('UZ_CPLD_REQUIRE_GUI_TESTS') == '1':
                self.fail(f'Required Tk display unavailable: {exc}')
            self.skipTest(f'Tk display unavailable: {exc}')
        self.root.withdraw()
        self.addCleanup(self.dispose_root)
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.start_patch = patch.object(gui.ProgrammerWindow, 'start')
        self.start = self.start_patch.start()
        self.addCleanup(self.start_patch.stop)
        self.window = gui.ProgrammerWindow(self.root, temporary.name)

    def dispose_root(self):
        # Destroying a Tk root does not cancel its timers. A later test's event
        # loop must not dispatch the previous window's queued startup callback.
        for timer in self.root.tk.call('after', 'info'):
            self.root.after_cancel(timer)
        self.root.destroy()

    def test_release_dropdown_filters_programs_without_silent_assignments(self):
        self.window.catalog = {'A': {'s3c': ['controller'], 'dslot': ['adapter']},
                               'B': {'s3c': ['other'], 'dslot': ['different']}}
        self.window.release.set('A')
        self.window.refresh_choices()
        self.assertEqual(self.window.program_boxes['1']['values'], ('adapter',))
        self.assertEqual(self.window.assignments['1'].get(), '')
        self.window.assignments['1'].set('adapter')
        self.window.release.set('B')
        self.window.refresh_choices()
        self.assertEqual(self.window.assignments['1'].get(), '')
        self.assertEqual(self.window.program_boxes['s3c']['values'], ('other',))

    def test_program_cancel_never_starts_worker_and_confirmation_defaults_no(self):
        self.window.catalog = {'A': {'s3c': ['controller'], 'dslot': ['adapter']}}
        self.window.release.set('A')
        self.window.assignments['s3c'].set('controller')
        with patch.object(self.window.message, 'askyesno', return_value=False) as confirm:
            self.window.program('s3c')
        self.assertEqual(confirm.call_args.kwargs['default'], 'no')
        self.start.assert_not_called()

    def test_identify_buttons_read_the_explicit_chain_without_a_selected_package(self):
        for text, target in (('Identify S3C', 's3c'), ('Identify D-slots', 'dslot')):
            self.start.reset_mock()
            button = next(widget for widget, _ in self.window.controls if widget.cget('text') == text)
            button.invoke()
            self.start.assert_called_once_with('identify', target=target)

    def test_program_buttons_keep_target_and_confirmation_assignments_together(self):
        self.window.catalog = {'A': {'s3c': ['controller'], 'dslot': ['adapter']}}
        self.window.release.set('A')
        self.window.assignments['s3c'].set('controller')
        for i in range(1, 6):
            self.window.assignments[str(i)].set('adapter')
        for target, text in (('s3c', 'S3C: controller'), ('dslot', 'D5: adapter')):
            self.start.reset_mock()
            with patch.object(self.window.message, 'askyesno', return_value=True) as confirm:
                self.window.program(target)
            self.assertIn(text, confirm.call_args.args[1])
            self.start.assert_called_once_with('program', target=target)

    def test_download_fetches_versions_without_prompting_for_branch(self):
        with patch.object(self.window.prompt, 'askstring') as prompt:
            self.window.download()
        self.start.assert_called_once_with('releases')
        prompt.assert_not_called()

    def test_version_dropdown_downloads_the_selected_older_release(self):
        versions = [dict(id=i, tag=f'firmware-ci-{i}-1', name=f'Build {i}',
                         published_at='2026-10-14T12:00:00Z', ref='refs/heads/master',
                         commit=str(i) * 40, prerelease=True) for i in (2, 1)]
        self.window.release_picker(versions)
        popup = next(child for child in self.root.winfo_children() if isinstance(child, self.window.tk.Toplevel))
        def descendants(widget):
            return [child for node in widget.winfo_children() for child in [node, *descendants(node)]]
        widgets = descendants(popup)
        box = next(widget for widget in widgets if isinstance(widget, self.window.ttk.Combobox))
        import gc
        gc.collect()
        self.assertEqual(box.current(), 0)
        self.assertIn('firmware-ci-2-1', box.get())
        box.current(1)
        box.event_generate('<<ComboboxSelected>>')
        button = next(widget for widget in widgets if isinstance(widget, self.window.ttk.Button)
                      and widget['text'] == 'Download & select')
        button.invoke()
        self.start.assert_called_once_with('download', release_id=1, release_commit='1' * 40)

    def test_cancel_version_picker_does_not_download(self):
        self.window.release_picker([dict(id=1, tag='firmware-ci-1-1', name='Build 1',
            published_at='2026-10-14T12:00:00Z', ref='refs/heads/master', commit='a' * 40, prerelease=True)])
        popup = next(child for child in self.root.winfo_children() if isinstance(child, self.window.tk.Toplevel))
        frame = popup.winfo_children()[0]
        buttons = frame.winfo_children()[-1]
        next(button for button in buttons.winfo_children() if button['text'] == 'Cancel').invoke()
        self.start.assert_not_called()

    def test_display_rows_preserve_unknown_identity_and_position(self):
        rows = gui.display_rows([{'label': 'slot3', 'idcode': '012BB043', 'usercode': 'FFFFFFFF', 'identity': None}])
        self.assertEqual(rows[0][0], 'D3')
        self.assertEqual(rows[0][2], 'Unknown firmware')

    def test_closing_during_operation_keeps_worker_alive(self):
        self.window.process = object()
        with patch.object(self.window.message, 'showinfo') as message, patch.object(self.root, 'destroy') as destroy:
            self.window.close()
        message.assert_called_once()
        destroy.assert_not_called()

    def test_results_and_footer_remain_accessible_on_small_displays(self):
        self.root.geometry('940x640')
        self.root.deiconify()
        self.root.update()
        # Windows delivers the canvas Configure event through its window event
        # queue; flushing idle callbacks alone leaves children at 1x1 pixels.
        deadline = time.monotonic() + 2
        while self.window.table.winfo_height() <= 100 and time.monotonic() < deadline:
            self.root.update()
            time.sleep(.01)
        self.assertGreater(self.window.table.winfo_height(), 100)
        self.window.canvas.yview_moveto(1)
        self.root.update()
        footer_button = self.window.controls[-1][0]
        self.assertLess(footer_button.winfo_rooty() + footer_button.winfo_height(),
                        self.root.winfo_rooty() + self.root.winfo_height())

    def test_high_dpi_rows_fit_fonts_and_small_screen_controls_reflow(self):
        from tkinter import font
        self.root.tk.call('tk', 'scaling', 2.0)
        for timer in self.root.tk.call('after', 'info'):
            self.root.after_cancel(timer)
        for child in self.root.winfo_children():
            child.destroy()
        self.window = gui.ProgrammerWindow(self.root, self.window.workspace)
        self.root.geometry(f'{self.window.px(780)}x{self.window.px(520)}')
        self.root.deiconify()
        deadline = time.monotonic() + 2
        while not getattr(self.window, 'stacked', False) and time.monotonic() < deadline:
            self.root.update()
            time.sleep(.01)
        style = self.window.ttk.Style(self.root)
        rowheight = int(style.lookup('Treeview', 'rowheight'))
        text_height = font.Font(self.root, font=style.lookup('Treeview', 'font')).metrics('linespace')
        self.assertGreater(rowheight, text_height)
        self.assertTrue(self.window.stacked)
        self.assertEqual(self.window.source_card.grid_info()['row'], 1)
        self.assertEqual(self.window.choices_card.winfo_manager(), 'pack')

    def test_device_positions_stay_visible_and_other_chain_results_are_retained(self):
        positions = ('S3C', 'D1', 'D2', 'D3', 'D4', 'D5')
        self.assertEqual(self.window.table.get_children(), positions)
        for position in positions:
            self.assertEqual(tuple(self.window.table.item(position, 'values')), (position, '', '', '', ''))
        self.window.show_devices([dict(label='s3c', idcode='012BC043', usercode='12345678', identity=None)])
        self.window.show_devices([dict(label='slot1', idcode='012BB043', usercode='ABCDEF01', identity=None)])
        self.assertEqual(self.window.table.item('S3C', 'values')[4], '12345678')
        self.assertEqual(self.window.table.item('D1', 'values')[4], 'ABCDEF01')
        self.window.clear_results()
        self.assertEqual(self.window.table.get_children(), positions)
        self.assertEqual(self.window.table.item('S3C', 'values')[4], '')

    def test_table_height_is_fixed_and_activity_is_next_to_actions(self):
        self.root.deiconify()
        self.root.update()
        height = self.window.table.winfo_height()
        self.assertFalse(any(isinstance(widget, self.window.ttk.Scrollbar)
                             for widget in self.window.table.master.winfo_children()))
        row = self.window.table.bbox('D5')
        self.assertTrue(row)
        self.assertLessEqual(row[1] + row[3], height)
        self.root.geometry('1060x1000')
        self.root.update()
        self.assertEqual(self.window.table.winfo_height(), height)
        self.assertEqual(self.window.progress.winfo_parent(), str(self.window.action_row))
        self.window.process = object()
        self.window.pulse_activity()
        self.assertEqual(self.window.activity_icon.itemcget('body', 'fill'), '#7600c9')
        self.window.stop_activity()
        self.assertIsNone(self.window.activity_timer)
        self.assertLessEqual(self.root.winfo_height(), self.root.winfo_screenheight())

    def test_action_order_and_startup_size_match_the_layout(self):
        buttons = [widget.cget('text') for widget in self.window.action_row.winfo_children()
                   if isinstance(widget, self.window.ttk.Button)]
        self.assertEqual(buttons, ['Scan', 'Identify S3C', 'Program S3C', 'Identify D-slots', 'Program D-slots'])
        self.assertFalse(any(widget.cget('text') == 'Probe options…' for widget, _ in self.window.controls))
        self.root.deiconify()
        self.root.update()
        area = self.window.work_area()
        expected = min(self.window.page.winfo_reqheight(), area[3] - area[1] - self.window.px(60))
        self.assertEqual(self.root.winfo_height(), expected)


if __name__ == '__main__':
    unittest.main()
