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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Evidence' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Evidence'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
if (-not [Diagnostics.EventLog]::SourceExists('RepublicComms')) {
    New-EventLog -LogName RepublicHunt -Source RepublicComms
}
if ([Diagnostics.EventLog]::LogNameFromSourceName('RepublicComms','.') -ne 'RepublicHunt') {
    throw 'RepublicComms already belongs to another log. Resolve the fixture-name conflict first.'
}
Write-EventLog -LogName RepublicHunt -Source RepublicComms -EventId 4101 -EntryType Information -Message 'Result=RECEIVED; PacketCode=8110'
Start-Sleep -Seconds 1
Write-EventLog -LogName RepublicHunt -Source RepublicComms -EventId 4101 -EntryType Information -Message 'Result=RECEIVED; PacketCode=0427'
Start-Sleep -Seconds 1
Write-EventLog -LogName RepublicHunt -Source RepublicComms -EventId 4101 -EntryType Information -Message 'Result=FAILED; PacketCode=9900'
wevtutil.exe epl RepublicHunt "$dir\balcony.evtx" /ow:true
if ($LASTEXITCODE -ne 0) { throw 'Event export failed' }
Get-WinEvent -Path "$dir\balcony.evtx" -MaxEvents 3 | Format-List TimeCreated,Id,ProviderName,Message
