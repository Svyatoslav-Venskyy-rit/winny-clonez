[CmdletBinding()]
param([ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars')
$ErrorActionPreference = 'Stop'
# Run ON your authoritative Windows DNS server as Administrator.
Import-Module DnsServer
Get-DnsServerZone -Name $Domain -ErrorAction Stop | Out-Null
$existing = @(Get-DnsServerResourceRecord -ZoneName $Domain -Name 'mercy-beacon.hunt' -RRType TXT -ErrorAction SilentlyContinue)
if ($existing.Count -eq 0) {
    Add-DnsServerResourceRecord -ZoneName $Domain -Name 'mercy-beacon.hunt' -Txt -DescriptiveText 'ANCHOR'
} else {
    $text = @($existing | ForEach-Object { $_.RecordData.DescriptiveText })
    if ($existing.Count -ne 1 -or $text.Count -ne 1 -or $text[0] -cne 'ANCHOR') {
        throw 'Conflicting existing TXT record; inspect it before changing it.'
    }
    Write-Host 'Correct hunt TXT record already exists.'
}
