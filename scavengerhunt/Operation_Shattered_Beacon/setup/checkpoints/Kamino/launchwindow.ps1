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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Flight' -Force | Out-Null
$scheduler = New-Object -ComObject Schedule.Service
$scheduler.Connect()
try { $null = $scheduler.GetFolder('\Republic') }
catch { $null = $scheduler.GetFolder('\').CreateFolder('Republic') }
if (Get-ScheduledTask -TaskPath '\Republic\' -TaskName MidnightLaunch -ErrorAction SilentlyContinue) {
    throw 'MidnightLaunch already exists; verify the existing hunt fixture before replacing it'
}
$action = New-ScheduledTaskAction -Execute "$env:SystemRoot\System32\cmd.exe" -Argument '/c echo LaunchCode=2187 Destination=Felucia'
$principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount
$settings = New-ScheduledTaskSettingsSet -Disable
$definition = New-ScheduledTask -Action $action -Principal $principal -Settings $settings
Register-ScheduledTask -TaskPath '\Republic\' -TaskName MidnightLaunch -InputObject $definition | Out-Null
