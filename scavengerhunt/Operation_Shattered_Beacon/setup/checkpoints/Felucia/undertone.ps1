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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Relay' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Balcony'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\inspection.txt" 'The visible report is for the Senate. The second stream is for my brothers.' -Encoding ASCII
Set-Content "$dir\inspection.txt" -Stream comlink -Value 'Authentication word: SENTINEL' -Encoding ASCII
Get-Item "$dir\inspection.txt" -Stream *
