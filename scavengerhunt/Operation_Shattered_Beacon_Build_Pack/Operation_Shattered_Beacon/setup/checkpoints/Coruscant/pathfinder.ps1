[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Coruscant'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Dispatch' -Force | Out-Null
foreach ($folder in 'Vendor','Trusted') {
    $dir = "C:\Republic\Hunt\$folder"
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Set-Content "$dir\dispatch.exe" 'INERT HUNT PLACEHOLDER - DO NOT EXECUTE' -Encoding ASCII
}
Set-Content 'C:\Republic\Hunt\Vendor\dispatch-code.txt' '5502' -Encoding ASCII
Set-Content 'C:\Republic\Hunt\Trusted\dispatch-code.txt' '1188' -Encoding ASCII
