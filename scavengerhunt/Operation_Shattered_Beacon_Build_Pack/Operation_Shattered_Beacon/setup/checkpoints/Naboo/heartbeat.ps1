[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Naboo'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Telemetry' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Wreck'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
@'
RemoteAddress,RemotePort,OwningProcess
192.0.2.20,443,1200
192.0.2.77,7443,4242
192.0.2.77,443,8080
'@ | Set-Content "$dir\connections.csv" -Encoding ASCII
@'
ProcessId,Name,CommandLine
1200,medrelay.exe,"medrelay.exe --BeaconCode 1140"
4242,relay.exe,"relay.exe --BeaconCode 9771"
8080,inventory.exe,"inventory.exe --BeaconCode 3300"
'@ | Set-Content "$dir\processes.csv" -Encoding ASCII
