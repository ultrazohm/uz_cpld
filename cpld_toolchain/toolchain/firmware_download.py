"""Download the newest CI firmware release for the checkout's Git branch."""
import argparse
from datetime import datetime
import hashlib
from http.client import HTTPException
import json
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import sys
import tempfile
from urllib.error import HTTPError, URLError
from urllib.parse import urlparse
from urllib.request import HTTPRedirectHandler, Request, build_opener
from zipfile import BadZipFile, ZipFile

from cpld_toolchain import repository_root
from .buildsystem.model import BuildError

ASSET = 'uz-cpld-firmware.zip'
API = 'https://api.github.com'


def git(root, *args, optional=False):
    result = subprocess.run(['git', '-C', str(root), *args], capture_output=True, text=True)
    if result.returncode and not optional:
        raise BuildError('Cannot determine Git checkout configuration: ' + result.stderr.strip())
    return result.stdout.strip() if result.returncode == 0 else ''


def source(root, remote=None):
    branch = git(root, 'symbolic-ref', '--quiet', '--short', 'HEAD', optional=True)
    if not branch:
        raise BuildError('Firmware download requires a checked-out Git branch; HEAD is detached or this is not a Git checkout')
    tracking_remote = git(root, 'config', '--get', f'branch.{branch}.remote', optional=True)
    selected_remote = remote or tracking_remote or 'origin'
    if selected_remote == '.':
        raise BuildError('The current branch tracks a local branch; select a GitHub remote with --remote')
    ref = f'refs/heads/{branch}'
    if selected_remote == tracking_remote:
        ref = git(root, 'config', '--get', f'branch.{branch}.merge', optional=True) or ref
    if not ref.startswith('refs/heads/'):
        raise BuildError('The current branch must track a remote branch, not a tag')
    url = git(root, 'remote', 'get-url', selected_remote)
    match = re.fullmatch(r'(?:git@github\.com:|https://github\.com/|ssh://git@github\.com/)([A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+?)(?:\.git)?/?', url)
    if not match:
        raise BuildError(f'Remote {selected_remote!r} must reference a github.com repository using HTTPS or SSH')
    return match[1], ref


class AssetRedirect(HTTPRedirectHandler):
    """Do not forward API credentials to the asset storage host."""
    def redirect_request(self, request, fp, code, msg, headers, newurl):
        if urlparse(newurl).scheme != 'https':
            raise BuildError('GitHub download redirected to a non-HTTPS URL')
        redirected = super().redirect_request(request, fp, code, msg, headers, newurl)
        if redirected and urlparse(newurl).netloc != urlparse(request.full_url).netloc:
            redirected.remove_header('Authorization')
        return redirected


def request(path, *, binary=False):
    headers = {'Accept': 'application/octet-stream' if binary else 'application/vnd.github+json',
               'User-Agent': 'uz_cpld', 'X-GitHub-Api-Version': '2022-11-28'}
    token = os.environ.get('GH_TOKEN') or os.environ.get('GITHUB_TOKEN')
    if token:
        headers['Authorization'] = f'Bearer {token}'
    try:
        return build_opener(AssetRedirect()).open(Request(API + path, headers=headers), timeout=60)
    except HTTPError as exc:
        raise BuildError(f'GitHub API returned HTTP {exc.code}; check repository access and API rate limits. '
                         'For authenticated access set GH_TOKEN or GITHUB_TOKEN with repository contents read access.') from None
    except URLError as exc:
        raise BuildError(f'GitHub request failed: {exc.reason}') from None


def latest(repository, ref):
    matches = []
    page = 1
    while True:
        with request(f'/repos/{repository}/releases?per_page=100&page={page}') as response:
            releases = json.load(response)
        if not isinstance(releases, list):
            raise BuildError('GitHub returned an invalid release listing')
        for release in releases:
            body = release.get('body') or ''
            if (release.get('draft') or not release.get('published_at') or
                    not re.fullmatch(r'firmware-ci-\d+-\d+', release.get('tag_name', '')) or
                    re.findall(r'^Source ref: ([^\r\n]+)\r?$', body, re.MULTILINE) != [ref]):
                continue
            commits = re.findall(r'^Source commit: ([0-9a-fA-F]{40})\r?$', body, re.MULTILINE)
            assets = [asset for asset in release.get('assets', [])
                      if asset.get('name') == ASSET and asset.get('state') == 'uploaded']
            if len(commits) == 1 and len(assets) == 1:
                matches.append((release, assets[0], commits[0].lower()))
        if len(releases) < 100:
            break
        page += 1
    if not matches:
        raise BuildError(f'No published CI firmware with {ASSET} found for {repository} on {ref}')
    return max(matches, key=lambda item: (datetime.fromisoformat(item[0]['published_at'].replace('Z', '+00:00')),
                                          item[0]['id']))


def verify(path, commit, asset):
    """Verify the downloaded archive in place; never extract untrusted paths."""
    if path.stat().st_size != asset['size']:
        raise BuildError('Downloaded firmware size does not match the GitHub asset')
    with path.open('rb') as stream:
        digest = hashlib.sha256()
        for block in iter(lambda: stream.read(1024 * 1024), b''):
            digest.update(block)
    expected = asset.get('digest')
    if expected and expected != 'sha256:' + digest.hexdigest():
        raise BuildError('Downloaded firmware SHA-256 does not match the GitHub asset')
    with ZipFile(path) as archive:
        names = archive.namelist()
        if len(names) != len(set(names)) or 'manifest.json' not in names:
            raise BuildError('Firmware archive has duplicate entries or no manifest.json')
        manifest = json.loads(archive.read('manifest.json'))
        if (not isinstance(manifest, dict) or manifest.get('schema_version') != 1 or manifest.get('git_revision') != commit or
                manifest.get('backend') not in ('diamond', 'foss') or
                not isinstance(manifest.get('builds'), list) or not manifest['builds'] or
                not isinstance(manifest.get('identity_registry'), dict)):
            raise BuildError('Firmware manifest has an unsupported schema or does not match the release commit')
        declared = {'manifest.json'}
        for build in manifest['builds']:
            if not isinstance(build, dict):
                raise BuildError('Firmware manifest contains an invalid build entry')
            files = build.get('files')
            if not isinstance(files, dict) or not files:
                raise BuildError('Firmware manifest contains a build without files')
            for name, expected in files.items():
                parts = PurePosixPath(name)
                if (parts.is_absolute() or '..' in parts.parts or '\\' in name or
                        parts.as_posix() != name or parts.suffix not in ('.bit', '.jed') or name in declared):
                    raise BuildError('Firmware manifest contains an invalid or duplicate path')
                digest = hashlib.sha256()
                with archive.open(name) as stream:
                    for block in iter(lambda: stream.read(1024 * 1024), b''):
                        digest.update(block)
                if digest.hexdigest() != expected:
                    raise BuildError(f'Firmware checksum mismatch: {name}')
                declared.add(name)
        if set(names) != declared:
            raise BuildError('Firmware archive contains files not declared in its manifest')


def download(root, *, remote=None, output=None):
    repository, ref = source(root, remote)
    release, asset, commit = latest(repository, ref)
    destination = Path(output) if output else Path(root) / 'build/downloads' / release['tag_name'] / ASSET
    if destination.is_symlink():
        raise BuildError('Download output must not be a symlink')
    print(f"Firmware: {repository} {ref} — {release['tag_name']} ({commit})")
    destination.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix='.firmware-', dir=destination.parent) as temporary:
        staged = Path(temporary) / ASSET
        with request(f'/repos/{repository}/releases/assets/{int(asset["id"])}', binary=True) as response, staged.open('wb') as stream:
            shutil.copyfileobj(response, stream)
        verify(staged, commit, asset)
        staged.replace(destination)
    print(f'Downloaded: {destination}')
    return destination


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=repository_root())
    parser.add_argument('--remote')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args(argv)
    try:
        download(args.root.resolve(), remote=args.remote, output=args.output)
        return 0
    except (BuildError, OSError, ValueError, KeyError, TypeError, BadZipFile, HTTPException, RuntimeError) as exc:
        print(f'Firmware download failed: {exc}', file=sys.stderr)
        return 1


if __name__ == '__main__':
    raise SystemExit(main())
