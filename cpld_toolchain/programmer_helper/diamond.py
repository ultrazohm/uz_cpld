"""Native programmer invocation; Linux retains the vendor environment wrapper."""
import sys
from cpld_toolchain.toolchain.diamond import executable, environment as tool_environment


def command(root, xcf, log):
    if sys.platform == 'win32':
        # Resolve installation availability at execution, allowing offline plans.
        return (str(executable('programmer', required=False)), '-infile', str(xcf), '-logfile', str(log))
    return ('bash', str(root / 'cpld_toolchain/programmer_helper/diamond_program.sh'), str(xcf), str(log))


def environment(command):
    return tool_environment(command[0]) if sys.platform == 'win32' else None
