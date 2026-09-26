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
Write-Host 'Preparing stockroom evidence on Alderaan...'
& (Join-Path $PSScriptRoot 'checkpoints\Alderaan\stockroom.ps1') @argsForFixture
Write-Host 'Preparing clearance evidence on Alderaan...'
& (Join-Path $PSScriptRoot 'checkpoints\Alderaan\clearance.ps1') @argsForFixture
Write-Host 'Preparing coldmemory evidence on Alderaan...'
& (Join-Path $PSScriptRoot 'checkpoints\Alderaan\coldmemory.ps1') @argsForFixture
Write-Host 'Preparing echo evidence on Alderaan...'
& (Join-Path $PSScriptRoot 'checkpoints\Alderaan\echo.ps1') @argsForFixture
Write-Host 'Preparing lastlight evidence on Alderaan...'
& (Join-Path $PSScriptRoot 'checkpoints\Alderaan\lastlight.ps1') @argsForFixture
Write-Host 'Alderaan evidence preparation completed. Copy compiled executables to their mapped paths separately.'
