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
$expectedExecute = "$env:SystemRoot\System32\cmd.exe"
$expectedArguments = '/c echo LaunchCode=2187 Destination=Felucia'

$existing = Get-ScheduledTask -TaskPath '\Republic\' `
    -TaskName MidnightLaunch -ErrorAction SilentlyContinue

if ($null -eq $existing) {
    $action = New-ScheduledTaskAction `
        -Execute $expectedExecute -Argument $expectedArguments

    $principal = New-ScheduledTaskPrincipal `
        -UserId 'SYSTEM' -LogonType ServiceAccount

    $settings = New-ScheduledTaskSettingsSet -Disable

    $definition = New-ScheduledTask `
        -Action $action -Principal $principal -Settings $settings

    Register-ScheduledTask -TaskPath '\Republic\' `
        -TaskName MidnightLaunch -InputObject $definition | Out-Null

    Write-Host 'Created MidnightLaunch hunt fixture.'
}
else {
    $actions = @($existing.Actions)

    if (
        $actions.Count -ne 1 -or
        $actions[0].Execute -ne $expectedExecute -or
        $actions[0].Arguments -ne $expectedArguments -or
        $existing.Settings.Enabled -ne $false -or
        $existing.Principal.UserId -notin @(
            'SYSTEM', 'NT AUTHORITY\SYSTEM', 'S-1-5-18'
        ) -or
        $existing.Principal.LogonType -ne 'ServiceAccount' -or
        @($existing.Triggers).Count -gt 0
    ) {
        throw 'MidnightLaunch exists but does not match the expected hunt fixture. Inspect it before changing it.'
    }

    Write-Host 'MidnightLaunch already matches the hunt fixture; reusing it.'
}
