[CmdletBinding()]
param(
    [string]$HuntReader,
    [string]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars',
    [string]$RookAccount,
    [switch]$AllowDifferentComputerName
)
$ExpectedHost = 'Felucia'
. (Join-Path $PSScriptRoot '..\..\Common.ps1')
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Wreck' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Wreck'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$build = Join-Path $env:TEMP ('HuntBuild-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $build | Out-Null
Set-Content "$build\salvage.txt" 'Salvage word: VIOLET' -Encoding ASCII
Compress-Archive -Path "$build\salvage.txt" -DestinationPath "$build\sensor.zip"
Copy-Item "$build\sensor.zip" "$dir\sensor-image.jpg" -Force
Remove-Item -LiteralPath $build -Recurse -Force
