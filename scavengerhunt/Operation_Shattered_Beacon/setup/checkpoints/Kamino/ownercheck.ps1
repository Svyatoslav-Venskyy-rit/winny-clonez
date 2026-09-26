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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Records' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Records'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\rook-report.txt" 'Report filed before the evacuation order was issued.' -Encoding ASCII
icacls.exe "$dir\rook-report.txt" /grant "${HuntReader}:(R)"
if ($LASTEXITCODE -ne 0) { throw 'Read grant failed' }

if ($RookAccount) {
    $ownerAccount = $RookAccount
} else {
    $role = (Get-CimInstance Win32_ComputerSystem).DomainRole
    if ($role -ge 4) { throw 'On a DC, first create a dedicated disabled domain account CT-6116, then pass -RookAccount DOMAIN\CT-6116.' }
    if (-not (Get-LocalUser -Name 'CT-6116' -ErrorAction SilentlyContinue)) {
        New-LocalUser -Name 'CT-6116' -NoPassword -Disabled -Description 'Disabled hunt evidence identity' | Out-Null
    }
    if ((Get-LocalUser -Name 'CT-6116').Enabled) { throw 'The hunt identity must remain disabled.' }
    $ownerAccount = "$env:COMPUTERNAME\CT-6116"
}
if (($ownerAccount -split '\\')[-1] -ine 'CT-6116') { throw 'The evidence owner account must end in CT-6116.' }
icacls.exe "$dir\rook-report.txt" /setowner $ownerAccount
if ($LASTEXITCODE -ne 0) { throw 'Owner change failed; use an account with restore/owner-assignment rights.' }
(Get-Acl "$dir\rook-report.txt").Owner

