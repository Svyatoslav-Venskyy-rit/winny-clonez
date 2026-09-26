[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Kamino'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Comms' -Force | Out-Null
$key = 'HKLM:\SOFTWARE\Republic\Comms\Balcony'
New-Item -Path $key -Force | Out-Null
New-ItemProperty -Path $key -Name RouteCode -PropertyType String -Value '7341' -Force | Out-Null
