"""Container startup reports optional Diamond without changing command behavior."""
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ENTRYPOINT = Path(__file__).resolve().parents[3] / '.devcontainer/container-entrypoint'


class ContainerStartupTests(unittest.TestCase):
    def test_flasher_build_inputs_are_in_docker_context_allowlist(self):
        root = ENTRYPOINT.parents[1]
        rules = (root / '.dockerignore').read_text().splitlines()
        self.assertIn('*', rules)
        # This context excludes everything except explicit paths. Both files
        # and their parent directories must be allowed for COPY to see them.
        test_files = sorted((root / 'cpld_toolchain/toolchain/foss/tests').glob('*'))
        for name in ('flasher.py', 'openfpgaloader.json', 'openfpgaloader-usercode.patch',
                     *(f'tests/{p.name}' for p in test_files if p.suffix in ('.cpp', '.py'))):
            path = Path('cpld_toolchain/toolchain/foss') / name
            self.assertTrue((root / path).is_file())
            self.assertIn('!' + path.as_posix(), rules)
            for parent in path.parents:
                if parent != Path('.'):
                    self.assertIn('!' + parent.as_posix() + '/', rules)

    def test_diamond_profiles_select_base_without_masking_embedded_installation(self):
        root = ENTRYPOINT.parents[1]
        dockerfile = (root / '.devcontainer/Dockerfile').read_text()
        self.assertIn('ARG TOOLCHAIN_BASE=ubuntu:${UBUNTU_VERSION}', dockerfile)
        self.assertIn('FROM ${TOOLCHAIN_BASE} AS toolchain-runtime', dockerfile)
        # FOSS compilation still uses its independent Ubuntu builder.
        self.assertIn('FROM ubuntu:${UBUNTU_VERSION} AS foss-build-base', dockerfile)
        for relative, embedded, usb in (
            ('.devcontainer/devcontainer.json', False, False),
            ('.devcontainer/usb/devcontainer.json', False, True),
            ('.devcontainer/diamond/devcontainer.json', True, False),
            ('.devcontainer/diamond-usb/devcontainer.json', True, True),
        ):
            with self.subTest(profile=relative):
                path = root / relative
                config = json.loads(path.read_text())
                build = config['build']
                self.assertEqual((path.parent / build['context']).resolve(), root)
                self.assertEqual((path.parent / build['dockerfile']).resolve(),
                                 root / '.devcontainer/Dockerfile')
                self.assertEqual(build['target'], 'toolchain')
                self.assertEqual(config['remoteUser'], 'vscode')
                self.assertFalse(config['overrideCommand'])
                args = config['runArgs']
                self.assertIn('--network=name=bridge,mac-address=10:91:d1:3d:14:ae', args)
                self.assertIn('--cap-add=NET_ADMIN', args)
                self.assertEqual(config['postStartCommand'], 'bash .devcontainer/setup-network.sh')
                self.assertEqual(config['waitFor'], 'postStartCommand')
                self.assertEqual('type=bind,source=/dev/bus/usb,target=/dev/bus/usb' in args, usb)
                if usb:
                    self.assertIn('--device-cgroup-rule=c 189:* rwm', args)
                    self.assertIn('--group-add=${localEnv:USB_DEVICE_GID:46}', args)
                if embedded:
                    self.assertEqual(build['args']['TOOLCHAIN_BASE'],
                                     '${localEnv:DIAMOND_IMAGE:lattice-diamond}:${localEnv:DIAMOND_TAG:3.14.0.75.2}')
                    self.assertFalse(any('/opt/diamond' in arg for arg in args))
                    self.assertNotIn('initializeCommand', config)
                    self.assertEqual(config['containerEnv']['LM_LICENSE_FILE'],
                                     '/opt/diamond/license/license.dat')
                else:
                    self.assertNotIn('TOOLCHAIN_BASE', build.get('args', {}))
                    self.assertEqual(config['initializeCommand'],
                                     ['bash', '${localWorkspaceFolder}/.devcontainer/prepare-host.sh'])
                    index = args.index('--mount')
                    self.assertEqual(args[index + 1],
                                     'type=bind,source=${localWorkspaceFolder}/.devcontainer/.local/diamond,target=/opt/diamond,readonly')
                    self.assertEqual(config['containerEnv']['LM_LICENSE_FILE'],
                                     '${localEnv:LM_LICENSE_FILE}')

    def run_entrypoint(self, root, *command, override=None):
        env = dict(os.environ, DIAMOND_ROOT=str(root))
        env.pop('DIAMOND_CLI', None)
        if override is not None:
            env['DIAMOND_CLI'] = str(override)
        return subprocess.run(['bash', str(ENTRYPOINT), *command], env=env,
                              capture_output=True, text=True, timeout=10)

    def test_missing_diamond_does_not_block_command_or_change_exit_code(self):
        with tempfile.TemporaryDirectory() as temp:
            result = self.run_entrypoint(temp, 'bash', '-c', 'printf "%s" "$1"; exit 7',
                                         'test', 'argument with spaces')
        self.assertEqual(result.returncode, 7)
        self.assertEqual(result.stdout, 'argument with spaces')
        self.assertIn('Diamond not found:', result.stderr)

    def test_found_diamond_is_not_executed(self):
        with tempfile.TemporaryDirectory(prefix='diamond install ') as temp:
            launcher = Path(temp) / 'bin/lin64/diamondc'
            launcher.parent.mkdir(parents=True)
            launcher.write_text('#!/bin/sh\necho "unexpected license check" >&2\nexit 1\n')
            launcher.chmod(0o755)
            result = self.run_entrypoint(temp, 'true')
        self.assertEqual(result.returncode, 0)
        self.assertIn('Diamond found:', result.stderr)
        self.assertNotIn('unexpected license check', result.stderr)

    def test_executable_override_matches_backend_lookup(self):
        with tempfile.TemporaryDirectory() as temp:
            result = self.run_entrypoint(temp, 'true', override='true')
        self.assertEqual(result.returncode, 0)
        self.assertIn('Diamond found: true', result.stderr)


class HostDiamondSetupTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='diamond host ')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.script = self.root / '.devcontainer/prepare-host.sh'
        self.script.parent.mkdir()
        shutil.copy2(ENTRYPOINT.with_name('prepare-host.sh'), self.script)
        self.state = self.script.parent / '.local'
        # This child process has an isolated home, like a different Docker host.
        self.env = {key: value for key, value in os.environ.items()
                    if key not in ('DIAMOND_ROOT', 'DIAMOND_HOST_ROOT', 'LM_LICENSE_FILE')}
        self.env['HOME'] = str(self.root / 'home')

    def install(self, path):
        launcher = path / 'bin/lin64/diamondc'
        launcher.parent.mkdir(parents=True)
        launcher.write_text('#!/bin/sh\necho unexpected-launch >&2\nexit 1\n')
        launcher.chmod(0o755)
        return path

    def prepare(self, **env):
        return subprocess.run(['bash', str(self.script)], env={**self.env, **env},
                              capture_output=True, text=True, timeout=10)

    def test_default_installation_is_detected_and_saved_without_running_it(self):
        path = self.install(Path(self.env['HOME']) / 'lscc/diamond/3.14')
        result = self.prepare()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.state / 'diamond').resolve(), path)
        self.assertEqual((self.state / 'diamond-root').read_text().strip(), str(path))
        self.assertNotIn('unexpected-launch', result.stderr)

    def test_runtime_variable_is_accepted_and_selection_survives_lost_environment(self):
        path = self.install(self.root / "custom Diamond ' $tools")
        result = self.prepare(DIAMOND_ROOT=str(path), DIAMOND_HOST_ROOT='')
        self.assertEqual(result.returncode, 0, result.stderr)
        result = self.prepare()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.state / 'diamond').resolve(), path)

    def test_host_override_takes_precedence_and_can_disable_diamond(self):
        path = self.install(self.root / 'custom')
        result = self.prepare(DIAMOND_HOST_ROOT=str(path), DIAMOND_ROOT='/not-present')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.state / 'diamond').resolve(), path)
        result = self.prepare(DIAMOND_HOST_ROOT='none')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.state / 'diamond').resolve(), self.state / 'empty-diamond')
        self.assertEqual(self.prepare().returncode, 0)
        self.assertEqual((self.state / 'diamond').resolve(), self.state / 'empty-diamond')

    def test_missing_default_allows_foss_and_detects_a_later_installation(self):
        result = self.prepare()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.state / 'diamond').is_dir())
        self.assertFalse((self.state / 'diamond-root').exists())
        path = self.install(Path(self.env['HOME']) / 'lscc/diamond/3.14')
        self.assertEqual(self.prepare().returncode, 0)
        self.assertEqual((self.state / 'diamond').resolve(), path)

    def test_invalid_explicit_or_saved_path_fails_without_replacing_mount(self):
        path = self.install(self.root / 'custom')
        self.assertEqual(self.prepare(DIAMOND_ROOT=str(path)).returncode, 0)
        result = self.prepare(DIAMOND_HOST_ROOT=str(self.root / 'typo'))
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Full Diamond launcher not found', result.stderr)
        self.assertEqual((self.state / 'diamond').resolve(), path)
        (path / 'bin/lin64/diamondc').chmod(0o644)
        result = self.prepare()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Full Diamond launcher not found', result.stderr)
