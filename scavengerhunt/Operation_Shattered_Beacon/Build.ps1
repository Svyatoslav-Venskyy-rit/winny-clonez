[CmdletBinding()]
param(
    [Parameter(Mandatory=$true)][System.Net.IPAddress]$DnsServer,
    [ValidatePattern('^[A-Za-z0-9.-]+$')][string]$Domain = 'clone.wars'
)
$ErrorActionPreference = 'Stop'
if (-not (Get-Command cl.exe -ErrorAction SilentlyContinue)) {
    throw 'Open a Visual Studio Developer PowerShell so cl.exe is on PATH.'
}

function CString([string]$Text) {
    return '"' + $Text.Replace('\','\\').Replace('"','\"').Replace("`r",'\r').Replace("`n",'\n') + '"'
}

function Expression([string]$Source, [string]$Name) {
    $match = [regex]::Match($Source, '(?m)^static const char ' + $Name + '\[\] = (.+);\r?$')
    if (-not $match.Success) { throw "Missing C constant $Name" }
    return $match.Groups[1].Value
}

$manifest = @(Get-Content "$PSScriptRoot\organizer\manifest.json" -Raw | ConvertFrom-Json)
$campaign = Get-Content "$PSScriptRoot\Campaign.json" -Raw | ConvertFrom-Json
if ($manifest.Count -ne 21 -or @($campaign.late).Count -ne 11) {
    throw 'Incomplete campaign.'
}

$late = @{}
foreach ($item in $campaign.late) {
    $late[[int]$item.stage] = $item
}

$config = "#define HUNT_DNS_SERVER $(CString $DnsServer.ToString())`n#define HUNT_DOMAIN $(CString $Domain)`n"
[IO.File]::WriteAllText("$PSScriptRoot\include\hunt_config.h", $config)

$objects = "$PSScriptRoot\build-objects"
New-Item -ItemType Directory -Path $objects -Force | Out-Null

# Prevent stale binaries from entering the new archives.
if (Test-Path "$PSScriptRoot\bin") {
    Remove-Item "$PSScriptRoot\bin" -Recurse -Force
}

foreach ($stage in $manifest) {
    $n = [int]$stage.stage
    $original = Get-Content (Join-Path $PSScriptRoot $stage.source) -Raw -Encoding UTF8

    if ($n -le 10) {
        $brief = Expression $original 'BRIEFING'
        $old = Expression $original 'SUCCESS_TEXT'
        $cut = $old.IndexOf('\n\nCarry token:')
        if ($cut -lt 0) { throw "Missing original handoff in stage $n" }

        $blue = $old.Substring(0, $cut) + '"'
        $red = CString $campaign.red_early[$n - 1]
    } else {
        $briefText = [string]$late[$n].briefing
        if ($n -eq 17) {
            $briefText += "`nRepublic domain: $Domain`nRepublic DNS server: $DnsServer"
        }

        $brief = CString $briefText
        $key = if ($n -lt 21) { [string]$manifest[$n].entry } else { '' }
        $blue = CString $late[$n].blue.Replace('{key}', $key)
        $red = CString $late[$n].red.Replace('{key}', $key)
    }

    $handoff = ''
    if ($n -lt 21) {
        $next = $manifest[$n]
        $handoff = "Carry token: $($stage.carry.ToUpperInvariant())"

        if ($n -eq 4) {
            $handoff += "`nSave transmission half A: MERCY"
        }
        if ($n -eq 16) {
            $handoff += "`nSave transmission half B: BEACON"
        }

        if ($n -lt 10) {
            $handoff += "`nNext host: $($next.host)`nNext terminal: C:\Republic\Hunt\$($next.path)"
        } else {
            $handoff += "`n$($late[$n + 1].route)"
        }

        if ($n -le 10) {
            $handoff += "`nNext entry password: $($next.entry)"
        }
    }

    $flagLine = if ($n -eq 21) {
        'puts(' + (CString ('Scoring flag: ' + $stage.flag)) + ');'
    } else {
        ''
    }

    $generated = @"
#include "checkpoint_runtime.h"

static int choose_team(void)
{
    char team[32];
    int result;
    for (;;) {
        fputs("Which team are you? [red/blue]: ", stdout);
        fflush(stdout);
        result = read_line(team, sizeof team);
        if (result == 0) return -1;
        if (result == 1) {
            if (!strcmp(team, "red") || !strcmp(team, "Red") || !strcmp(team, "RED")) return 1;
            if (!strcmp(team, "blue") || !strcmp(team, "Blue") || !strcmp(team, "BLUE")) return 0;
        }
        puts("Enter red or blue.");
    }
}

int main(void)
{
    int red;
    puts("Recovered communications terminal locked.");
    if (!prompt_until_match("Entry password: ", $(CString $stage.entry))) return 0;
    red = choose_team();
    if (red < 0) return 0;

    if (red) puts("Separatist spy unit: reconstruct the forged front-line message from the surviving evidence. Republic dialogue is intercepted enemy traffic.");
    else puts("Republic investigator: recover the substituted message and expose the Separatist scheme.");

    puts("\nEntry phrase accepted. Mission briefing follows.");
    puts($brief);
    puts("Submit words in lowercase; preserve leading zeroes in codes.");

    if (!prompt_until_match("Challenge answer: ", $(CString $stage.answer))) return 0;

    puts("\nEvidence accepted.");
    if (red) puts($red);
    else puts($blue);

    puts($(CString $handoff));
    $flagLine

    puts("Press Enter to exit...");
    (void)getchar();
    return 0;
}
"@

    $source = Join-Path $objects ("stage-$n.c")
    [IO.File]::WriteAllText(
        $source,
        $generated,
        [Text.UTF8Encoding]::new($false)
    )

    $destination = Join-Path "$PSScriptRoot\bin\$($stage.host)" $stage.path
    New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null

    & cl.exe /nologo /W4 /WX /TC /utf-8 "/I$PSScriptRoot\include" $source "/Fe:$destination" "/Fo:$objects\stage-$n.obj"
    if ($LASTEXITCODE -ne 0) {
        throw "Build failed: stage $n"
    }
}

Write-Host 'Built 21 team-aware terminals. Deploy-HuntLayout.ps1 installs their final locations.'