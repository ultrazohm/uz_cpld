"""Native programmer invocation; Linux retains the vendor environment wrapper."""
import sys
from pathlib import Path
from cpld_toolchain.toolchain.diamond import executable, environment as tool_environment


def command(root, xcf, log):
    if sys.platform == 'win32':
        # Resolve installation availability at execution, allowing offline plans.
        return (str(executable('programmer', required=False)), '-infile', str(xcf), '-logfile', str(log))
    return ('bash', str(Path(__file__).with_name('diamond_program.sh')), str(xcf), str(log))


def environment(command):
    if sys.platform == 'win32':
        return tool_environment(command[0])
    binary = executable('programmer', required=False)
    env = tool_environment(binary)
    env['CPLD_PGRCMD'] = str(binary)
    root = binary.parent.parent.parent
    if root.name.lower() == 'programmer':
        root = root.parent
    env.setdefault('DIAMOND_ROOT', str(root))
    return env
