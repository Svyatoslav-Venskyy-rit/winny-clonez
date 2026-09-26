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
$dir = 'C:\Republic\Hunt\Orders'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$orders = @{ 'amber.txt'='TRANSPORT-2'; 'silver.txt'='TRANSPORT-7'; 'copper.txt'='TRANSPORT-9'; 'ivory.txt'='TRANSPORT-4' }
foreach ($name in $orders.Keys) {
    [IO.File]::WriteAllText((Join-Path $dir $name), "RescueTarget=$($orders[$name])`r`n", [Text.Encoding]::ASCII)
}
$actual = (Get-FileHash "$dir\silver.txt" -Algorithm SHA256).Hash
if ($actual -ne '26857272E7964FADE24DCC4851B6024EFC50B72E9BC60187CCA5E9530C2842BA') { throw 'Fixture bytes do not match the compiled trusted digest.' }
Write-Host "Trusted fixture hash verified: $actual"

