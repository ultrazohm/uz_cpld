"""Render possible FSM transitions found in catalog VHDL sources."""
import json
import re
import shutil
import subprocess

from cpld_toolchain.toolchain.buildsystem.model import BuildError
from cpld_toolchain.toolchain.buildsystem.ghdl import read_vhdl
from cpld_toolchain.toolchain.buildsystem.workflow import digest, locked, safe_directory, write_json


_TYPE = re.compile(r'\btype\s+(\w+)\s+is\s*\(([^()]*)\)\s*;', re.I)
_BRANCH = re.compile(r'\bwhen\s+([^;]*?)\s*=>', re.I | re.S)


def _transitions(section, signal):
    """Read assignments and their effective guards in an if/elsif/else tree."""
    tokens = re.compile(
        rf'\bend\s+if\s*;|\belsif\s+([^;]*?)\s+then\b|'
        rf'\bif\s+([^;]*?)\s+then\b|\belse\b|'
        rf'\b{re.escape(signal)}\s*<=\s*(\w+)\s*;', re.I | re.S)
    stack = []
    path = []
    assignments = []
    for token in tokens.finditer(section):
        keyword = token.group(0).split(None, 1)[0].lower()
        if keyword == 'if':
            condition = ' '.join(token.group(2).split())
            frame = {'parent': path, 'prior': [condition], 'else_seen': False}
            stack.append(frame)
            path = path + [condition]
        elif keyword == 'elsif':
            if not stack or stack[-1]['else_seen']:
                raise BuildError(f'Invalid elsif in FSM {signal}')
            condition = ' '.join(token.group(1).split())
            frame = stack[-1]
            path = frame['parent'] + [f'not ({prior})' for prior in frame['prior']] + [condition]
            frame['prior'].append(condition)
        elif keyword == 'else':
            if not stack or stack[-1]['else_seen']:
                raise BuildError(f'Invalid else in FSM {signal}')
            frame = stack[-1]
            path = frame['parent'] + [f'not ({prior})' for prior in frame['prior']]
            frame['else_seen'] = True
        elif keyword == 'end':
            if not stack:
                raise BuildError(f'Unmatched end if in FSM {signal}')
            path = stack.pop()['parent']
        else:
            assignments.append((token.group(3), ' and '.join(path) if path else 'always'))
    if stack:
        raise BuildError(f'Unclosed if statement in FSM {signal}')
    return assignments


def extract_state_machines(source):
    """Find enumerated VHDL FSMs and source-level transition guards."""
    code = '\n'.join(line.split('--', 1)[0] for line in source.splitlines())
    machines = []
    for declared in _TYPE.finditer(code):
        states = [name.strip() for name in declared.group(2).split(',')]
        if not all(re.fullmatch(r'[A-Za-z]\w*', name) for name in states):
            continue
        signal_pattern = re.compile(
            rf'\bsignal\s+(\w+)\s*:\s*{re.escape(declared.group(1))}\b'
            r'\s*(?::=\s*(\w+))?\s*;', re.I)
        for signal in signal_pattern.finditer(code):
            name, initial = signal.groups()
            selected = re.search(rf'\bcase\s+{re.escape(name)}\s+is\b', code, re.I)
            if selected is None:
                continue
            end = re.search(r'\bend\s+case\s*;', code[selected.end():], re.I)
            if end is None:
                raise BuildError(f'Unclosed case statement for FSM {name}')
            body = code[selected.end():selected.end() + end.start()]
            if re.search(r'\bcase\s+\w+\s+is\b', body, re.I):
                raise BuildError(f'Nested case statement in FSM {name} is unsupported')
            branches = list(_BRANCH.finditer(body))
            lookup = {state.lower(): state for state in states}
            if len(branches) != len(re.findall(r'\bwhen\b', body, re.I)):
                raise BuildError(f'Unsupported when expression in FSM {name}')
            choices = []
            named = set()
            for index, branch in enumerate(branches):
                origins = [value.strip().lower() for value in branch.group(1).split('|')]
                if origins == ['others']:
                    if index != len(branches) - 1:
                        raise BuildError(f'others must be the last branch in FSM {name}')
                else:
                    for origin in origins:
                        if origin not in lookup:
                            raise BuildError(f'Unsupported state choice {origin!r} in FSM {name}')
                        if origin in named:
                            raise BuildError(f'Duplicate state {origin} in FSM {name}')
                        named.add(origin)
                choices.append(origins)
            edges = set()
            for index, branch in enumerate(branches):
                origins = choices[index]
                if origins == ['others']:
                    origins = [state for state in lookup if state not in named]
                if not origins:
                    continue
                stop = branches[index + 1].start() if index + 1 < len(branches) else len(body)
                section = body[branch.end():stop]
                for target, condition in _transitions(section, name):
                    if target.lower() not in lookup:
                        raise BuildError(f'Unknown transition target {target} in FSM {name}')
                    for origin in origins:
                        edges.add((lookup[origin], lookup[target.lower()], condition))
            if not branches:
                raise BuildError(f'No state branches found in FSM {name}')
            # Calls to procedures that assign the state are not expanded by
            # this source-level extractor. Do not publish an empty graph as
            # if it described such a controller's transitions.
            if not edges:
                continue
            if initial and initial.lower() not in lookup:
                raise BuildError(f'Unknown initial state {initial} in FSM {name}')
            machines.append((name, states, lookup[initial.lower()] if initial else None,
                             sorted(edges, key=lambda edge: (states.index(edge[0]),
                                                             states.index(edge[1]), edge[2]))))
    return machines


def export_state_diagrams(build):
    """Export SVG/PDF state graphs from the manifest's VHDL, if any are found."""
    with locked(build):
        output = safe_directory(build, build.build_root / 'state-diagrams')
        if output.exists():
            shutil.rmtree(output)
        output.mkdir(parents=True)
        (output / 'metadata').mkdir()
        sources = {str(src.path.relative_to(build.root)): digest(src.path) for src in build.sources}
        machines = [(path, machine) for path, src in zip(sources, build.sources)
                    for machine in extract_state_machines(read_vhdl(src.path))]
        if not machines:
            return None
        if not shutil.which('dot'):
            raise BuildError('Graphviz dot is missing; rebuild the toolchain container')
        diagrams = []
        for index, (path, (name, states, initial, edges)) in enumerate(machines, 1):
            stem = f'state-diagram-{index}'
            lines = ['digraph fsm {', '  rankdir=TB;',
                     '  node [shape=box, style=rounded];', '  edge [fontsize=9];']
            for state in states:
                lines.append(f'  {json.dumps(state)};')
            if initial:
                lines.extend(['  start [shape=point];',
                              f'  start -> {json.dumps(initial)};'])
            for origin, target, condition in edges:
                label = re.sub(r'\s+and\s+', '\nAND ', condition, flags=re.I)
                lines.append(f'  {json.dumps(origin)} -> {json.dumps(target)} '
                             f'[label={json.dumps(label)}];')
            lines.append('}')
            (output / f'{stem}.dot').write_text('\n'.join(lines) + '\n')
            for fmt in ('svg', 'pdf'):
                subprocess.run(['dot', f'-T{fmt}', f'{stem}.dot', '-o', f'{stem}.{fmt}'],
                               cwd=output, check=True)
            diagrams.append({'name': name, 'source': path, 'stem': stem,
                             'states': states, 'initial': initial, 'transitions': edges,
                             'outputs': {f'{stem}.{fmt}': digest(output / f'{stem}.{fmt}')
                                         for fmt in ('svg', 'pdf')}})
        if sources != {str(src.path.relative_to(build.root)): digest(src.path) for src in build.sources}:
            raise BuildError(f'{build.name}: VHDL changed during state diagram generation')
        write_json(output / 'metadata/state-diagrams.json', {
            'program': build.name, 'release_cycle': build.release_cycle, 'inputs': sources, 'diagrams': diagrams,
            'meaning': 'Edges show source-level guards, including prior false elsif/else branches. '
                       'They are not reachability proofs; implicit holds are omitted.',
            'tool': subprocess.check_output(['dot', '-V'], stderr=subprocess.STDOUT, text=True).strip(),
        })
        return output
