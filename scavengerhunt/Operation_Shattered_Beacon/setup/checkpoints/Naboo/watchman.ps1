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
$svc = Get-Service -Name RepublicEscort -ErrorAction SilentlyContinue
if ($svc) { throw 'RepublicEscort already exists; verify it is your hunt fixture before reusing it' }
New-Service -Name RepublicEscort -DisplayName 'Republic Escort Record' -BinaryPathName "$env:SystemRoot\System32\cmd.exe /c exit 0" -StartupType Disabled -Description 'Courier fallback extraction word: HOLDFAST' | Out-Null
Get-CimInstance Win32_Service -Filter "Name='RepublicEscort'" | Select-Object Name,State,StartMode,Description
