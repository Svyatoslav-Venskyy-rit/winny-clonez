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
Write-Host 'Preparing undertone evidence on Felucia...'
& (Join-Path $PSScriptRoot 'checkpoints\Felucia\undertone.ps1') @argsForFixture
Write-Host 'Preparing atmosphere evidence on Felucia...'
& (Join-Path $PSScriptRoot 'checkpoints\Felucia\atmosphere.ps1') @argsForFixture
Write-Host 'Preparing camouflage evidence on Felucia...'
& (Join-Path $PSScriptRoot 'checkpoints\Felucia\camouflage.ps1') @argsForFixture
Write-Host 'Preparing memorybank evidence on Felucia...'
& (Join-Path $PSScriptRoot 'checkpoints\Felucia\memorybank.ps1') @argsForFixture
Write-Host 'Felucia evidence preparation completed. Copy compiled executables to their mapped paths separately.'
