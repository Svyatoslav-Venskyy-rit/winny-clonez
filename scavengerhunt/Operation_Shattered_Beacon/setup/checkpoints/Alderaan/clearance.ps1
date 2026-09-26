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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Records' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Records'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
@'
TOP SECRET - ACCESS DENIED
This heading is a classification label, not a Windows permission.
Brotherhood word: BROTHER
'@ | Set-Content "$dir\clearance.txt" -Encoding ASCII
icacls.exe "$dir\clearance.txt" /grant "${HuntReader}:(R)"
if ($LASTEXITCODE -ne 0) { throw 'Read grant failed' }
icacls.exe "$dir\clearance.txt"
