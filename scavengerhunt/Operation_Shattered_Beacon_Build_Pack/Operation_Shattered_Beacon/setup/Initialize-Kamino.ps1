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
Write-Host 'Preparing routecache evidence on Kamino...'
& (Join-Path $PSScriptRoot 'checkpoints\Kamino\routecache.ps1') @argsForFixture
Write-Host 'Preparing launchwindow evidence on Kamino...'
& (Join-Path $PSScriptRoot 'checkpoints\Kamino\launchwindow.ps1') @argsForFixture
Write-Host 'Preparing ownercheck evidence on Kamino...'
& (Join-Path $PSScriptRoot 'checkpoints\Kamino\ownercheck.ps1') @argsForFixture
Write-Host 'Preparing checksum evidence on Kamino...'
& (Join-Path $PSScriptRoot 'checkpoints\Kamino\checksum.ps1') @argsForFixture
Write-Host 'Kamino evidence preparation completed. Copy compiled executables to their mapped paths separately.'
