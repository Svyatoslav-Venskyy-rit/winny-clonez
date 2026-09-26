[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][string]$Planet
)

$ErrorActionPreference = 'Stop'
. (Join-Path $PSScriptRoot 'Common.ps1')

$campaign = Get-Content (Join-Path $PSScriptRoot '..\Campaign.json') -Raw |
    ConvertFrom-Json

$manifest = @(
    Get-Content (Join-Path $PSScriptRoot '..\deployment-manifest.json') -Raw |
        ConvertFrom-Json
)

if ($env:COMPUTERNAME -ine $Planet) {
    throw "Wrong destination: $env:COMPUTERNAME / $Planet"
}

function Relocate([string]$Source, [string]$Destination) {
    if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
        throw "Missing fixture: $Source"
    }

    $hash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    $time = (Get-Item -LiteralPath $Source -Force).LastWriteTimeUtc

    New-Item -ItemType Directory -Path (Split-Path $Destination -Parent) -Force |
        Out-Null

    # These destinations are dedicated Republic hunt files, never Windows components.
    if (Test-Path -LiteralPath $Destination) {
        Remove-Item -LiteralPath $Destination -Force
    }

    Move-Item -LiteralPath $Source -Destination $Destination

    if ((Get-FileHash -LiteralPath $Destination -Algorithm SHA256).Hash -ne $hash) {
        throw "Relocation hash mismatch: $Destination"
    }

    if ((Get-Item -LiteralPath $Destination -Force).LastWriteTimeUtc -ne $time) {
        throw "Relocation timestamp mismatch: $Destination"
    }

    icacls.exe $Destination /grant "${HuntReader}:(RX)" | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Read grant failed: $Destination"
    }
}

foreach ($item in $campaign.late) {
    $stage = @($manifest | Where-Object { $_.stage -eq $item.stage })

    if ($stage.Count -ne 1) {
        throw 'Invalid campaign stage mapping.'
    }

    if ($stage[0].host -ne $Planet) {
        continue
    }

    foreach ($move in $item.moves.PSObject.Properties) {
        Relocate (Join-Path $HuntRoot $move.Name) ([string]$move.Value)
    }

    Relocate (Join-Path $HuntRoot $stage[0].path) ([string]$item.exe)
}

if ($Planet -eq 'Coruscant') {
    $dir = 'C:\ProgramData\Republic\Dispatch'
    New-Item -ItemType Directory -Path $dir -Force | Out-Null

    @'
Offline launch reconstruction. Not the live system PATH.
Command=dispatch.exe
LaunchDirectory=C:\ProgramData\Republic\Dispatch
SearchPath=C:\Program Files\Republic Dispatch\Vendor;C:\Program Files\Republic Dispatch\Trusted
No candidate exists in LaunchDirectory. Search directories from left to right.
Read the selected candidate's adjacent dispatch-code.txt; never execute the placeholders.
'@ | Set-Content "$dir\launch.txt" -Encoding ASCII
}

if ($Planet -eq 'Felucia') {
    $old = 'HKLM:\SOFTWARE\Republic\Salvage\DroidMemory'
    $new = 'HKLM:\SOFTWARE\Republic\Diagnostics\DroidMemory'

    $bytes = (Get-ItemProperty -LiteralPath $old -Name FragmentBytes).FragmentBytes

    New-Item -Path $new -Force | Out-Null
    New-ItemProperty -Path $new -Name FragmentBytes -PropertyType Binary `
        -Value $bytes -Force | Out-Null

    if (
        [Convert]::ToBase64String((Get-ItemProperty $new).FragmentBytes) -ne
        [Convert]::ToBase64String($bytes)
    ) {
        throw 'Registry fragment verification failed.'
    }

    Remove-ItemProperty -LiteralPath $old -Name FragmentBytes
}

if ($Planet -eq 'Alderaan') {
    $links = & fsutil.exe hardlink list 'C:\Users\Public\Documents\Republic Archive\routine.txt'

    if (
        $LASTEXITCODE -ne 0 -or
        @($links | ForEach-Object { $_.Trim() }) -notcontains
        '\ProgramData\Republic\Signals\DAWN.txt'
    ) {
        throw 'Relocated hard-link fixture failed verification.'
    }
}

foreach ($stage in $manifest | Where-Object { $_.host -eq $Planet }) {
    $path = Join-Path $HuntRoot $stage.path

    if ($stage.stage -gt 10) {
        $path = ($campaign.late |
            Where-Object { $_.stage -eq $stage.stage }).exe

        if (Test-Path -LiteralPath (Join-Path $HuntRoot $stage.path)) {
            throw 'Old terminal survived relocation.'
        }
    }

    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Missing terminal: $path"
    }
}

Write-Host "All $Planet terminals and relocated evidence verified."