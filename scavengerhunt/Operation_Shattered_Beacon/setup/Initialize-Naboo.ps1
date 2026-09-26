[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ErrorActionPreference = 'Stop'
$argsForFixture = @{}
foreach ($key in $PSBoundParameters.Keys) { $argsForFixture[$key] = $PSBoundParameters[$key] }
Write-Host 'Preparing departure evidence on Naboo...'
& (Join-Path $PSScriptRoot 'checkpoints\Naboo\departure.ps1') @argsForFixture
Write-Host 'Preparing watchman evidence on Naboo...'
& (Join-Path $PSScriptRoot 'checkpoints\Naboo\watchman.ps1') @argsForFixture
Write-Host 'Preparing heartbeat evidence on Naboo...'
& (Join-Path $PSScriptRoot 'checkpoints\Naboo\heartbeat.ps1') @argsForFixture
Write-Host 'Preparing system66 evidence on Naboo...'
& (Join-Path $PSScriptRoot 'checkpoints\Naboo\system66.ps1') @argsForFixture
Write-Host 'Naboo evidence preparation completed. Copy compiled executables to their mapped paths separately.'
