[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Alderaan'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Depot' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Depot\Medical'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\dispatch.txt" 'Shipment category: TRANSPORT' -Encoding ASCII
icacls.exe $dir /grant "${HuntReader}:(OI)(CI)(RX)"
if ($LASTEXITCODE -ne 0) { throw 'NTFS read grant failed' }
$share = Get-SmbShare -Name 'RepublicSupply$' -ErrorAction SilentlyContinue
if ($share -and $share.Path -ne $dir) { throw 'Share name already used for another path' }
if (-not $share) {
    New-SmbShare -Name 'RepublicSupply$' -Path $dir -ReadAccess $HuntReader | Out-Null
} else {
    Grant-SmbShareAccess -Name 'RepublicSupply$' -AccountName $HuntReader -AccessRight Read -Force | Out-Null
}
