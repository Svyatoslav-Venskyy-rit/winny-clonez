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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Escort' -Force | Out-Null
$expectedPath = "$env:SystemRoot\System32\cmd.exe /c exit 0"
$expectedDescription = 'Courier fallback extraction word: HOLDFAST'

$svc = Get-CimInstance Win32_Service -Filter "Name='RepublicEscort'"

if ($null -eq $svc) {
    New-Service -Name RepublicEscort `
        -DisplayName 'Republic Escort Record' `
        -BinaryPathName $expectedPath `
        -StartupType Disabled `
        -Description $expectedDescription | Out-Null

    Write-Host 'Created RepublicEscort hunt fixture.'
}
else {
    if (
        $svc.PathName -ne $expectedPath -or
        $svc.DisplayName -ne 'Republic Escort Record' -or
        $svc.Description -ne $expectedDescription -or
        $svc.StartMode -ne 'Disabled'
    ) {
        throw 'RepublicEscort exists but does not match the expected hunt fixture. Inspect it before changing it.'
    }

    Write-Host 'RepublicEscort already matches the hunt fixture; reusing it.'
}

Get-CimInstance Win32_Service -Filter "Name='RepublicEscort'" |
    Select-Object Name, State, StartMode, Description
