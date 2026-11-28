"""Allow publication only while this run still represents the branch head."""
import json
import os
from pathlib import Path
import re
import subprocess
from urllib.parse import quote


def is_current(repository, ref, commit):
    if not ref.startswith('refs/heads/'):
        return False
    if not re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', repository):
        raise ValueError('Invalid GitHub repository')
    if not re.fullmatch(r'[0-9a-f]{40}', commit):
        raise ValueError('Invalid workflow commit')
    endpoint = f'repos/{repository}/git/ref/{quote(ref.removeprefix("refs/"), safe="/")}'
    # An API/authentication failure must fail the step, never allow publishing.
    response = subprocess.check_output(['gh', 'api', endpoint], text=True)
    return json.loads(response)['object']['sha'] == commit


def main():
    current = is_current(os.environ['GITHUB_REPOSITORY'], os.environ['GITHUB_REF'], os.environ['GITHUB_SHA'])
    message = ('Publication permitted: workflow commit is the current branch head.' if current else
               'Publication skipped: this run no longer represents the branch head.')
    print(message)
    with Path(os.environ['GITHUB_OUTPUT']).open('a', encoding='utf-8') as stream:
        stream.write(f'current={str(current).lower()}\n')
    with Path(os.environ['GITHUB_STEP_SUMMARY']).open('a', encoding='utf-8') as stream:
        stream.write(message + '\n')


if __name__ == '__main__':
    main()
