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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Directory' -Force | Out-Null
if (-not $DnsServer) { throw 'Provide -DnsServer with the actual authoritative DNS server IP.' }
$answers = Resolve-DnsName -Name "mercy-beacon.hunt.$Domain" -Type TXT -Server $DnsServer -ErrorAction Stop
$strings = @($answers | Where-Object { $_.Type -eq 'TXT' } | ForEach-Object { $_.Strings })
if ($strings.Count -ne 1 -or $strings[0] -cne 'ANCHOR') { throw 'Expected exactly one TXT string: ANCHOR.' }
Write-Host 'TXT lookup verified from this host.'

