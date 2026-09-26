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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Salvage' -Force | Out-Null
$key = 'HKLM:\SOFTWARE\Republic\Salvage\DroidMemory'
New-Item -Path $key -Force | Out-Null
New-ItemProperty -Path $key -Name FragmentBytes -PropertyType Binary -Value ([byte[]](0x39,0x30,0x33,0x36)) -Force | Out-Null
