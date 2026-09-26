[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Coruscant'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Balcony' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Balcony'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\maintenance.txt" 'Recognition word: LANTERN' -Encoding ASCII -Force
attrib.exe +h "$dir\maintenance.txt"
