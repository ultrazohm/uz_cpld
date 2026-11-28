"""Public API contracts independent of Tk and command-line argument parsing."""
from contextlib import redirect_stdout
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from cpld_toolchain.programmer import Programmer, ProgrammerError, operate
from cpld_toolchain.programmer_helper.tests import test_release as fixtures


class ProgrammerAPITests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name).resolve()
        self.fixture = fixtures.ReleaseTests()
        self.fixture.setUp()
        self.addCleanup(self.fixture.doCleanups)
        self.selection = {'release': 'published', 's3c': 'controller'}

    def test_python_and_json_clients_load_identical_catalogs(self):
        api = Programmer(self.root)
        selected = api.select_firmware(self.fixture.zip)
        self.assertIn('published', selected['cycles'])
        self.assertEqual(api.load(), operate({'action': 'load', 'workspace': str(self.root)}))

    def test_prepare_has_no_usb_and_execute_returns_record(self):
        api = Programmer(self.root)
        with patch('cpld_toolchain.programmer_helper.program.require_usb_bus', side_effect=AssertionError('USB')):
            prepared = api.prepare_programming(self.selection, target='s3c', firmware=self.fixture.zip)
        self.assertEqual(prepared.summary['target'], 's3c')
        self.assertEqual(prepared.summary['assignments'][0]['program'], 'controller')
        directory = self.root / 'result'
        directory.mkdir()
        (directory / 'result.json').write_text(json.dumps({'devices': [{'label': 's3c'}]}))
        with patch('cpld_toolchain.programmer_helper.program.execute', return_value=directory) as execute:
            result = api.execute(prepared)
        self.assertEqual(result['devices'], [{'label': 's3c'}])
        self.assertEqual(execute.call_args.args[2], 's3c')

    def test_changed_package_and_wrong_probe_fail_before_execution(self):
        api = Programmer(self.root)
        with patch('cpld_toolchain.programmer_helper.program.plan') as plan:
            with self.assertRaisesRegex(ProgrammerError, 'changed'):
                api.prepare_programming(self.selection, target='s3c', firmware=self.fixture.zip,
                                        expected_sha256='0' * 64)
        plan.assert_not_called()
        prepared = api.prepare_programming(self.selection, target='s3c', firmware=self.fixture.zip)
        with patch('cpld_toolchain.programmer_helper.program.execute') as execute:
            with self.assertRaises(ProgrammerError):
                Programmer(self.root, serial='another-probe').execute(prepared)
        execute.assert_not_called()

    def test_local_builds_and_probe_options_reach_shared_planner(self):
        api = Programmer(self.root, cable='custom', probe_index=2)
        with patch('cpld_toolchain.programmer_helper.program.plan', return_value=('original', self.root, [], [])) as plan:
            api.prepare_programming(self.selection, target='dslot', build_backend='foss')
        self.assertEqual(plan.call_args.args[3:8], ('dslots', 'foss', 'custom', None, 2))
        self.assertEqual(plan.call_args.kwargs['source'], 'local')
        self.assertEqual(plan.call_args.kwargs['build_backend'], 'foss')

    def test_library_is_quiet_and_callback_can_print(self):
        output = io.StringIO()
        with redirect_stdout(output):
            Programmer(self.root).save_assignments(self.selection)
        self.assertEqual(output.getvalue(), '')
        events = []
        def callback(event):
            events.append(event)
            if event['phase'] == 'log':
                print(event['text'], end='')
        with redirect_stdout(output):
            Programmer(self.root, on_event=callback).save_assignments(self.selection, override=True)
        self.assertIn('Saved assignments', output.getvalue())
        self.assertEqual(events[-1]['phase'], 'completed')

    def test_invalid_probe_configuration_and_target_do_not_access_hardware(self):
        for options in ({'backend': 'bad'}, {'probe_index': -1}, {'probe_index': 1, 'serial': 'abc'},
                        {'backend': 'diamond', 'serial': 'abc'}):
            with self.subTest(options=options), self.assertRaises(ProgrammerError):
                Programmer(self.root, **options)
        with self.assertRaises(ProgrammerError):
            Programmer(self.root).prepare_programming(self.selection, target=None)

    def test_public_worker_handles_load_and_failure_without_tk(self):
        repo = Path(__file__).resolve().parents[3]
        request, response = self.root / 'request.json', self.root / 'response.json'
        for action, expected in [('load', 0), ('unsupported', 2)]:
            request.write_text(json.dumps({'action': action, 'workspace': str(self.root)}))
            run = subprocess.run([sys.executable, '-m', 'cpld_toolchain.programmer', str(request), str(response)],
                                 cwd=repo, capture_output=True, text=True)
            self.assertEqual(run.returncode, expected, run.stderr)
            self.assertEqual(json.loads(response.read_text())['ok'], expected == 0)

    def test_save_rejects_incomplete_slots_without_inventing_assignments(self):
        api = Programmer(self.root)
        bad = dict(self.selection, slots={'1': 'adapter'})
        with self.assertRaisesRegex(ProgrammerError, 'missing'):
            api.save_assignments(bad)
        self.assertFalse((self.root / 'selection.toml').exists())
        from cpld_toolchain.toolchain.buildsystem.model import read_toml
        api.save_assignments(self.selection)
        self.assertEqual(read_toml(self.root / 'selection.toml'), self.selection)
        with self.assertRaisesRegex(ProgrammerError, 'already exists'):
            api.save_assignments(dict(self.selection, s3c='other'))
        self.assertEqual(read_toml(self.root / 'selection.toml'), self.selection)
        with self.assertRaises(ProgrammerError):
            api.prepare_programming(self.root / 'selection.toml', target='dslot', firmware=self.fixture.zip)

    def test_json_and_python_save_have_identical_validation_and_results(self):
        first, second = Programmer(self.root / 'python'), Programmer(self.root / 'json')
        partial = dict(self.selection, slots={'1': 'adapter'})
        for action in (lambda: first.save_assignments(partial),
                       lambda: second.request('save', selection=partial)):
            with self.assertRaises(ProgrammerError):
                action()
        a = first.save_assignments(self.selection)
        b = second.request('save', selection=self.selection)
        self.assertEqual(a['selection'], b['selection'])
        self.assertEqual(Path(a['path']).read_bytes(), Path(b['path']).read_bytes())

    def test_foss_scan_accepts_alternate_probe_without_identity_preflight(self):
        from cpld_toolchain.programmer_helper import program
        for options in ({'probe_index': 1}, {'cable': 'custom_adapter'}):
            with self.subTest(options=options), \
                    patch('cpld_toolchain.programmer_helper.identify.programming_preflight', side_effect=AssertionError('programming preflight')), \
                    patch('cpld_toolchain.toolchain.foss.flasher.verify', side_effect=AssertionError('identity receipt')), \
                    patch.object(program, 'require_usb_bus'), \
                    patch.object(program, 'loader_path', return_value=Path('/mock/loader')), \
                    patch('cpld_toolchain.programmer_helper.foss.run', return_value='index 0:\n idcode 0x012BC043\n') as run:
                result = Programmer(self.root, **options).scan(target='s3c')
            self.assertTrue(result['chain_matches'])
            command = run.call_args.args[0]
            if 'probe_index' in options:
                self.assertEqual(command[command.index('--cable-index') + 1], '1')
            else:
                self.assertIn('custom_adapter', command)

    def test_driver_setup_does_not_require_writable_workspace(self):
        from cpld_toolchain import driver_setup, workspace
        def setup(action, device_id=None, report=None):
            self.assertEqual(workspace.current(), self.root)
            report(dict(already_bound=True, restart_required=False))
        with workspace.use(self.root), \
                patch('cpld_toolchain.workspace.prepare', side_effect=PermissionError('read-only install')), \
                patch.object(driver_setup, 'setup', side_effect=setup):
            self.assertEqual(driver_setup.main(['setup_foss_drivers']), 0)
            self.assertEqual(Programmer(self.root).setup_drivers()['driver']['already_bound'], True)

    def test_diagnostics_do_not_replace_stdout_or_capture_other_threads(self):
        from threading import Thread
        from cpld_toolchain.diagnostics import emit
        output, events = io.StringIO(), []
        original = sys.stdout
        def backend(*args, **kwargs):
            self.assertIs(sys.stdout, output)
            thread = Thread(target=lambda: print('unrelated thread'))
            thread.start()
            thread.join()
            emit('backend diagnostic')
            return []
        with redirect_stdout(output), patch('cpld_toolchain.programmer_helper.identify.identify', side_effect=backend):
            Programmer(self.root, on_event=events.append).identify()
        self.assertIs(sys.stdout, original)
        self.assertEqual(output.getvalue(), 'unrelated thread\n')
        self.assertEqual([e['text'] for e in events if e['phase'] == 'log'], ['backend diagnostic\n'])

    def test_json_preparation_and_execution_work_across_instances(self):
        prepared = Programmer(self.root).request('prepare', selection=self.selection,
            target='s3c', firmware=str(self.fixture.zip))
        self.assertEqual(prepared['summary']['assignments'][0]['program'], 'controller')
        directory = self.root / 'record'
        directory.mkdir()
        (directory / 'result.json').write_text(json.dumps({'devices': [{'label': 's3c'}]}))
        with patch('cpld_toolchain.programmer_helper.program.execute', return_value=directory) as execute:
            result = Programmer(self.root).request('execute', plan_id=prepared['plan_id'],
                                                  review_sha256=prepared['review_sha256'])
        self.assertEqual(result['devices'], [{'label': 's3c'}])
        execute.assert_called_once()

    def test_json_execution_rejects_changed_record_or_package_before_hardware(self):
        api = Programmer(self.root)
        prepared = api.prepare_review(self.selection, target='s3c', firmware=self.fixture.zip)
        path = self.root / 'build/programmer/plans' / (prepared['plan_id'] + '.json')
        before = path.read_bytes()
        record = json.loads(before)
        record['request']['target'] = 'dslot'
        path.write_text(json.dumps(record))
        with patch('cpld_toolchain.programmer_helper.program.execute') as execute:
            with self.assertRaisesRegex(ProgrammerError, 'changed after review'):
                api.execute_review(prepared['plan_id'], prepared['review_sha256'])
            path.write_bytes(before)
            from zipfile import ZipFile
            with ZipFile(self.fixture.zip, 'a') as archive:
                archive.comment = b'changed after review'
            with self.assertRaisesRegex(ProgrammerError, 'changed'):
                api.execute_review(prepared['plan_id'], prepared['review_sha256'])
        execute.assert_not_called()

    def test_json_local_prepare_and_build_selection_delegate_all_options(self):
        from cpld_toolchain.programmer_helper import program
        api = Programmer(self.root)
        with patch.object(program, 'plan', return_value=('published', self.root, [], [])) as plan:
            prepared = api.request('prepare', selection=self.selection, target='s3c',
                                   source='local', build_backend='foss', release='published')
        self.assertEqual(plan.call_args.kwargs['source'], 'local')
        self.assertEqual(plan.call_args.kwargs['build_backend'], 'foss')
        self.assertEqual(plan.call_args.args[2], 'published')
        self.assertIn('plan_id', prepared)
        with patch.object(program, 'build_selection', return_value={'programs': ['controller']}) as build:
            result = api.request('build_selection', selection=str(self.root / 'selection.toml'),
                                 target='s3c', release='published', build_backend='foss')
        self.assertEqual(result, {'programs': ['controller']})
        self.assertEqual(build.call_args.kwargs, {'target': 's3c', 'backend': 'foss'})
        self.assertEqual(build.call_args.args[2], 'published')
        with self.assertRaisesRegex(ProgrammerError, 'source=local'):
            api.request('program', selection=self.selection, target='s3c', source='local', firmware=str(self.fixture.zip))

    def test_worker_prepare_persists_review_and_worker_rejects_bad_checksum(self):
        repo = Path(__file__).resolve().parents[3]
        request, response = self.root / 'request.json', self.root / 'response.json'
        request.write_text(json.dumps(dict(action='prepare', workspace=str(self.root),
            target='s3c', selection=self.selection, firmware=str(self.fixture.zip))))
        command = [sys.executable, '-m', 'cpld_toolchain.programmer', str(request), str(response)]
        first = subprocess.run(command, cwd=repo, capture_output=True, text=True)
        self.assertEqual(first.returncode, 0, first.stderr)
        prepared = json.loads(response.read_text())
        self.assertEqual(prepared['summary']['target'], 's3c')
        request.write_text(json.dumps(dict(action='execute', workspace=str(self.root),
            plan_id=prepared['plan_id'], review_sha256='0' * 64)))
        second = subprocess.run(command, cwd=repo, capture_output=True, text=True)
        self.assertEqual(second.returncode, 2)
        self.assertIn('changed after review', json.loads(response.read_text())['message'])

    def test_review_execution_rejects_changed_local_firmware_and_wrong_probe(self):
        from dataclasses import replace
        from cpld_toolchain.programmer_helper import program
        api = Programmer(self.root)
        prepared = api.prepare_programming(self.selection, target='s3c', firmware=self.fixture.zip)
        with patch.object(api, 'prepare_programming', return_value=prepared):
            record = api.prepare_review(self.selection, target='s3c')
        with patch.object(program, 'execute') as execute:
            with self.assertRaisesRegex(ProgrammerError, 'different workspace'):
                Programmer(self.root, serial='other').execute_review(record['plan_id'], record['review_sha256'])
            modified = replace(prepared, steps=tuple(replace(step, sha256='f' * 64) for step in prepared.steps))
            with patch.object(api, 'prepare_programming', return_value=modified):
                with self.assertRaisesRegex(ProgrammerError, 'inputs changed'):
                    api.execute_review(record['plan_id'], record['review_sha256'])
        execute.assert_not_called()

    def test_gui_blank_probe_fields_are_normalized_before_identity_preflight(self):
        from cpld_toolchain.programmer_helper import identify
        real_preflight = identify.preflight
        def read(root, chain, backend, cable, serial, probe_index):
            real_preflight(backend, cable, serial, probe_index)
            return []  # Real preflight, but no USB access.
        for backend in ('diamond', 'foss'):
            with self.subTest(backend=backend), \
                    patch.object(identify, 'identify', side_effect=read) as reader, \
                    patch('cpld_toolchain.toolchain.foss.flasher.verify', return_value={}):
                result = operate(dict(action='identify', workspace=str(self.root), backend=backend,
                    serial='', cable='', device_id='', firmware='', expected_sha256='',
                    selection={}, target='s3c'))
            self.assertEqual(result['devices'], [])
            self.assertIsNone(reader.call_args.args[3])
            self.assertIsNone(reader.call_args.args[4])

    def test_unknown_program_options_fail_before_planning_or_hardware(self):
        for extra in ({'dry_run': True}, {'expected_sha265': '0' * 64}, {'build_backed': 'foss'}):
            with self.subTest(extra=extra), \
                    patch('cpld_toolchain.programmer_helper.program.plan') as plan, \
                    patch('cpld_toolchain.programmer_helper.program.execute') as execute:
                with self.assertRaisesRegex(ProgrammerError, 'Unsupported program options'):
                    operate(dict(action='program', workspace=str(self.root), target='s3c',
                        selection=self.selection, firmware=str(self.fixture.zip), **extra))
                plan.assert_not_called()
                execute.assert_not_called()
        with self.assertRaisesRegex(ProgrammerError, 'boolean'):
            Programmer(self.root).request('save', selection=self.selection, override='false')
