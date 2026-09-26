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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Courier' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Courier'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$ws = New-Object -ComObject WScript.Shell
$shortcut = $ws.CreateShortcut("$dir\Departure.lnk")
$shortcut.TargetPath = "$env:SystemRoot\System32\cmd.exe"
$shortcut.Arguments = '/c echo Courier REED: departure cancelled'
$shortcut.Description = 'Courier departure record'
$shortcut.Save()
