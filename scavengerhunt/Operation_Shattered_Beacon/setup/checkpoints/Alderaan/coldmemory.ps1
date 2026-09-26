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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Analysis' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Wreck'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$plain = "Write-Output 'CLANKER'"
$encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($plain))
Set-Content "$dir\last-command.txt" "powershell.exe -EncodedCommand $encoded" -Encoding ASCII
