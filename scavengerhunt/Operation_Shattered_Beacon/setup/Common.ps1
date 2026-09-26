# Dot-source from the per-checkpoint scripts. Windows PowerShell 5.1, elevated.
$ErrorActionPreference = 'Stop'
if (-not [Environment]::Is64BitProcess) { throw 'Run 64-bit Windows PowerShell.' }
$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    throw 'Run PowerShell as Administrator.'
}
if ($ExpectedHost -and $env:COMPUTERNAME -ne $ExpectedHost -and -not $AllowDifferentComputerName) {
    throw "Expected host $ExpectedHost, found $env:COMPUTERNAME. Check destination; use -AllowDifferentComputerName only for deliberate lab aliases."
}
if (-not $HuntReader) {
    $HuntReader = ([Security.Principal.SecurityIdentifier]::new('S-1-5-32-544')).Translate([Security.Principal.NTAccount]).Value
}
$HuntRoot = 'C:\Republic\Hunt'
New-Item -ItemType Directory -Path $HuntRoot -Force | Out-Null
icacls.exe $HuntRoot /grant "${HuntReader}:(OI)(CI)(RX)" | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Hunt read permission setup failed.' }
