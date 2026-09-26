[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Alderaan'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Archive' -Force | Out-Null
$target = 'C:\Republic\Hunt\Signals\DAWN.txt'
$link = 'C:\Republic\Hunt\Archive\routine.txt'

New-Item -ItemType Directory `
    -Path 'C:\Republic\Hunt\Signals','C:\Republic\Hunt\Archive' `
    -Force | Out-Null

if (Test-Path -LiteralPath $link) {
    # Verify this is actually another name for DAWN.txt.
    $links = & fsutil.exe hardlink list $link
    if ($LASTEXITCODE -ne 0) {
        throw 'Could not inspect the existing routine.txt hard links.'
    }

    $normalizedLinks = @($links | ForEach-Object { $_.Trim() })

    if ($normalizedLinks -notcontains '\Republic\Hunt\Signals\DAWN.txt') {
        throw 'routine.txt exists but is not a hard link to Signals\DAWN.txt. Inspect it before changing it.'
    }

    Write-Host 'routine.txt already has the correct hard link; reusing it.'
}
else {
    if (-not (Test-Path -LiteralPath $target)) {
        Set-Content -LiteralPath $target `
            -Value 'Final authorization record retained under an alternate name.' `
            -Encoding ASCII
    }

    New-Item -ItemType HardLink -Path $link -Target $target | Out-Null
    Write-Host 'Created routine.txt hard link.'
}

& fsutil.exe hardlink list $link
if ($LASTEXITCODE -ne 0) {
    throw 'Final hard-link verification failed.'
}
