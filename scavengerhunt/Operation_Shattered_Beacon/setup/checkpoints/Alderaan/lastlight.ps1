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
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Control' -Force | Out-Null
$dir = 'C:\Republic\Hunt\FinalPackets'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$packets = @(
    @{Name='packet-d.txt'; Digit='2'; Time='2026-01-01T00:01:00Z'},
    @{Name='packet-a.txt'; Digit='7'; Time='2026-01-01T00:02:00Z'},
    @{Name='packet-c.txt'; Digit='1'; Time='2026-01-01T00:03:00Z'},
    @{Name='packet-b.txt'; Digit='4'; Time='2026-01-01T00:04:00Z'}
)
foreach ($packet in $packets) {
    $file = Join-Path $dir $packet.Name
    Set-Content $file $packet.Digit -Encoding ASCII
    (Get-Item $file).LastWriteTimeUtc = [DateTimeOffset]::Parse($packet.Time).UtcDateTime
}
Get-ChildItem $dir -Filter 'packet-*.txt' -File | Sort-Object LastWriteTimeUtc | Select-Object Name,LastWriteTimeUtc
