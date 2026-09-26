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
Write-Host 'Preparing patio evidence on Coruscant...'
& (Join-Path $PSScriptRoot 'checkpoints\Coruscant\patio.ps1') @argsForFixture
Write-Host 'Preparing receiver evidence on Coruscant...'
& (Join-Path $PSScriptRoot 'checkpoints\Coruscant\receiver.ps1') @argsForFixture
Write-Host 'Preparing pathfinder evidence on Coruscant...'
& (Join-Path $PSScriptRoot 'checkpoints\Coruscant\pathfinder.ps1') @argsForFixture
Write-Host 'Preparing twinvoice evidence on Coruscant...'
& (Join-Path $PSScriptRoot 'checkpoints\Coruscant\twinvoice.ps1') @argsForFixture
Write-Host 'Coruscant evidence preparation completed. Copy compiled executables to their mapped paths separately.'
