[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Felucia'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Weather' -Force | Out-Null
[Environment]::SetEnvironmentVariable('REPUBLIC_WEATHER','RAIN','Machine')
[Environment]::GetEnvironmentVariable('REPUBLIC_WEATHER','Machine')
