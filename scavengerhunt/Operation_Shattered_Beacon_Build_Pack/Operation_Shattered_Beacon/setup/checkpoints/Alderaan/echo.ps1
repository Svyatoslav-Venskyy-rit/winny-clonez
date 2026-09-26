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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Signals','C:\Republic\Hunt\Archive' -Force | Out-Null
Set-Content 'C:\Republic\Hunt\Signals\DAWN.txt' 'Final authorization record retained under an alternate name.' -Encoding ASCII
if (Test-Path 'C:\Republic\Hunt\Archive\routine.txt') {
    throw 'routine.txt already exists; inspect it before recreating the hunt hard link'
}
New-Item -ItemType HardLink -Path 'C:\Republic\Hunt\Archive\routine.txt' -Target 'C:\Republic\Hunt\Signals\DAWN.txt' | Out-Null
fsutil.exe hardlink list 'C:\Republic\Hunt\Archive\routine.txt'
