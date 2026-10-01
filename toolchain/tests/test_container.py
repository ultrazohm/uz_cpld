"""Container startup reports optional Diamond without changing command behavior."""
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ENTRYPOINT = Path(__file__).resolve().parents[2] / '.devcontainer/container-entrypoint'


class ContainerStartupTests(unittest.TestCase):
    def test_flasher_build_inputs_are_in_docker_context_allowlist(self):
        root = ENTRYPOINT.parents[1]
        rules = (root / '.dockerignore').read_text().splitlines()
        self.assertIn('*', rules)
        # This context excludes everything except explicit paths. Both files
        # and their parent directories must be allowed for COPY to see them.
        for name in ('flasher.py', 'openfpgaloader.json', 'openfpgaloader-usercode.patch',
                     'tests/usercode.cpp'):
            path = Path('toolchain/foss') / name
            self.assertTrue((root / path).is_file())
            self.assertIn('!' + path.as_posix(), rules)
            for parent in path.parents:
                if parent != Path('.'):
                    self.assertIn('!' + parent.as_posix() + '/', rules)

    def test_diamond_profiles_select_base_without_masking_embedded_installation(self):
        root = ENTRYPOINT.parents[1]
        dockerfile = (root / '.devcontainer/Dockerfile').read_text()
        self.assertIn('ARG TOOLCHAIN_BASE=ubuntu:${UBUNTU_VERSION}', dockerfile)
        self.assertIn('FROM ${TOOLCHAIN_BASE} AS toolchain', dockerfile)
        # FOSS compilation still uses its independent Ubuntu builder.
        self.assertIn('FROM ubuntu:${UBUNTU_VERSION} AS foss-builder', dockerfile)
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
                self.assertIn('--mac-address=10:91:d1:3d:14:ae', args)
                self.assertIn('--network=bridge', args)
                self.assertEqual('type=bind,source=/dev/bus/usb,target=/dev/bus/usb' in args, usb)
                if usb:
                    self.assertIn('--device-cgroup-rule=c 189:* rwm', args)
                    self.assertIn('--group-add=${localEnv:USB_DEVICE_GID:46}', args)
                if embedded:
                    self.assertEqual(build['args']['TOOLCHAIN_BASE'],
                                     '${localEnv:DIAMOND_IMAGE:lattice-diamond}:${localEnv:DIAMOND_TAG:3.14.0.75.2}')
                    self.assertFalse(any('/opt/diamond' in arg for arg in args))
                    self.assertEqual(config['containerEnv']['LM_LICENSE_FILE'],
                                     '/opt/diamond/license/license.dat')
                else:
                    self.assertNotIn('TOOLCHAIN_BASE', build.get('args', {}))
                    index = args.index('--volume')
                    self.assertEqual(args[index + 1],
                                     '${localEnv:DIAMOND_HOST_ROOT:uz-cpld-no-diamond}:/opt/diamond:ro')
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
