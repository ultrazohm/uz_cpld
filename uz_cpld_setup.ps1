# Run from any directory; setup opens an activated shell by default.
$ErrorActionPreference = 'Stop'
$setupExitCode = 1
Push-Location -LiteralPath $PSScriptRoot
try {
    $setupPython = $null
    $setupPythonArgs = @()
    foreach ($candidate in @('py', 'python', 'python3')) {
        $command = Get-Command $candidate -CommandType Application -ErrorAction SilentlyContinue
        if ($null -eq $command) { continue }
        $candidateArgs = @()
        if ($candidate -eq 'py') { $candidateArgs = @('-3') }
        & $command.Source @candidateArgs -c 'import sys; sys.exit(sys.version_info < (3, 8))' *> $null
        if ($LASTEXITCODE -eq 0) {
            $setupPython = $command.Source
            $setupPythonArgs = $candidateArgs
            break
        }
    }
    if ($null -eq $setupPython) {
        throw 'Setup requires Python 3.8 or newer. Install Python with its launcher or add it to PATH, then run this script again.'
    }
    & $setupPython @setupPythonArgs -m cpld_toolchain setup @args
    $setupExitCode = $LASTEXITCODE
}
catch {
    [Console]::Error.WriteLine($_.Exception.Message)
}
finally {
    Pop-Location
}
exit $setupExitCode
