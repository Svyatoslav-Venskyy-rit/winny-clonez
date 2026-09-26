[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][System.Net.IPAddress]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars'
)
$ErrorActionPreference = 'Stop'
if (-not (Get-Command cl.exe -ErrorAction SilentlyContinue)) {
    throw 'Open a Visual Studio Developer PowerShell (or Developer Command Prompt and invoke powershell) so cl.exe is on PATH.'
}
$config = @(
    '/* Generated organizer build configuration. */',
    ('#define HUNT_DNS_SERVER "' + $DnsServer.ToString() + '"'),
    ('#define HUNT_DOMAIN "' + $Domain + '"')
)
$config | Set-Content (Join-Path $PSScriptRoot 'include\hunt_config.h') -Encoding ASCII
$manifest = Get-Content (Join-Path $PSScriptRoot 'organizer\manifest.json') -Raw | ConvertFrom-Json
$include = Join-Path $PSScriptRoot 'include'
$objects = Join-Path $PSScriptRoot 'build-objects'
New-Item -ItemType Directory -Path $objects -Force | Out-Null
foreach ($stage in $manifest) {
    $source = Join-Path $PSScriptRoot $stage.source
    $destination = Join-Path (Join-Path (Join-Path $PSScriptRoot 'bin') $stage.host) $stage.path
    $object = Join-Path $objects ([IO.Path]::GetFileNameWithoutExtension($stage.path) + '.obj')
    New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
    & cl.exe /nologo /W4 /WX /TC /utf-8 "/I$include" $source "/Fe:$destination" "/Fo:$object"
    if ($LASTEXITCODE -ne 0) { throw "Build failed: $($stage.source)" }
}
Write-Host 'Built 21 executables under bin\HOST\... . Deploy only those executable trees, not the organizer pack.'
