"""Check that a Sphinx site can be served below a GitHub Pages project path."""
import argparse
from html.parser import HTMLParser
from pathlib import Path
import shutil
from urllib.parse import unquote, urlsplit


class Links(HTMLParser):
    def __init__(self):
        super().__init__()
        self.urls = []

    def handle_starttag(self, tag, attrs):
        self.urls.extend(value for key, value in attrs
                         if key in ('href', 'src') and value)


def clean(path):
    """Remove stale HTML without following symlinks in the output path."""
    path = Path(path).absolute()
    if any(p.is_symlink() for p in (path, *path.parents)):
        raise ValueError(f'Refusing to clean a symlinked output path: {path}')
    if path.exists():
        shutil.rmtree(path)


def check(path):
    """Reject missing assets, escaping URLs and unsupported artifact links."""
    root = Path(path).resolve()
    if not (root / '.nojekyll').is_file():
        raise ValueError('Missing .nojekyll; enable sphinx.ext.githubpages')
    if not (root / 'index.html').is_file():
        raise ValueError('Missing index.html')
    count = 0
    for source in root.rglob('*'):
        if source.is_symlink() or (source.is_file() and source.stat().st_nlink > 1):
            raise ValueError(f'Pages artifacts cannot contain links: {source}')
        if source.suffix != '.html' or not source.is_file():
            continue
        count += 1
        parser = Links()
        parser.feed(source.read_text(encoding='utf-8'))
        for url in parser.urls:
            parts = urlsplit(url)
            if parts.scheme or parts.netloc or not parts.path:
                continue
            local = unquote(parts.path)
            target = (source.parent / local).resolve()
            if local.startswith('/') or not target.is_relative_to(root):
                raise ValueError(f'{source.relative_to(root)}: URL escapes project site: {url}')
            if target.is_dir():
                target /= 'index.html'
            if not target.is_file():
                raise ValueError(f'{source.relative_to(root)}: missing asset: {url}')
    return count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('path', type=Path)
    parser.add_argument('--clean', action='store_true')
    args = parser.parse_args()
    try:
        if args.clean:
            clean(args.path)
        else:
            print(f'Pages site verified: {check(args.path)} HTML files')
    except (OSError, ValueError) as exc:
        parser.exit(1, f'{exc}\n')


if __name__ == '__main__':
    main()
