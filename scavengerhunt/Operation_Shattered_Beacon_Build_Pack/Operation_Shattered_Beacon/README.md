# Operation Shattered Beacon — organizer build pack

21 checkpoint C sources, evidence setup scripts for five hosts, and private answer/scoring keys. Based on organizer guide revision 2. Your original prologue is separate; add the three lines in `organizer/prologue-addition.c.txt` to its success branch.

## What is ready

- `src/HOST/*.c`: 21 populated checkpoints, including system66, with pre-briefing entry gates, a separate answer prompt, story text, scoring flags, and exact next-host/path/password handoffs.
- `setup/Initialize-HOST.ps1`: prepares that host's evidence using its per-checkpoint scripts. Does not copy binaries.
- `setup/Setup-Dns.ps1`: adds the hunt TXT record on the authoritative Windows DNS server.
- `Build.ps1`: compiles all checkpoints with the MSVC toolchain and sorts them into `bin/HOST/<relative-path>`.
- `organizer/`: passwords, flags, guide, prologue addition. Keep private.
- `tests/`: portable gate test runner and recorded validation results.

This ZIP contains source and setup scripts, not precompiled Windows executables. No host has been changed. The Windows setup scripts and MSVC build require a Windows lab validation pass; the C programs can also be compiled/tested locally with GCC for gate behavior.

## Build on your organizer Windows machine

1. Extract this ZIP into a private organizer folder.
2. Open **Developer PowerShell for Visual Studio** with the C/C++ desktop build tools installed.
3. Change into this folder and run the command below. Enter the actual DNS server IP at the prompt. Use the domain configured in your lab.

```powershell
$dns = Read-Host 'Actual lab DNS server IP'
.\Build.ps1 -DnsServer $dns -Domain 'clone.wars'
```

The DNS address and domain are compiled into twinvoice's gated briefing. Changing them means rebuilding. No placeholder DNS IP is shipped. Ordinary sources retain the guide's entry passwords, answers, and route. Scoring flags are generated in this pack and recorded in the private key.

## Prepare evidence

Use elevated **64-bit Windows PowerShell 5.1** on each destination. Prepare fixtures before opening the competition. Keep setup files in an organizer-only staging location during preparation and remove them afterward; they contain puzzle answers. Do not distribute this full ZIP to players.

First, on your authoritative DNS server:

```powershell
.\setup\Setup-Dns.ps1 -Domain 'clone.wars'
```

Then run the matching command on each named host. Coruscant requires the same actual DNS IP used at build time. You do not need DNS-server management tools on Coruscant unless it is also your DNS server.

```powershell
# On Coruscant:
$dns = Read-Host 'Actual lab DNS server IP'
.\setup\Initialize-Coruscant.ps1 -DnsServer $dns -Domain 'clone.wars'
# On Kamino:
.\setup\Initialize-Kamino.ps1
# On Felucia:
.\setup\Initialize-Felucia.ps1
# On Naboo:
.\setup\Initialize-Naboo.ps1
# On Alderaan:
.\setup\Initialize-Alderaan.ps1
```

The default reader is the built-in Administrators group, matching Administrator-based play. For a different participant group, pass `-HuntReader 'DOMAIN\HuntPlayers'` to the applicable initializer. Use your real domain/group name. An inherited deny can still block access; verify using the actual account.

Host checks compare the real Windows computer name to the planet name. If you deliberately use other computer names, pass `-AllowDifferentComputerName` only after confirming which planet that machine represents.

Kamino's identity fixture normally creates a **disabled local** CT-6116 account. If Kamino is a domain controller, first create a dedicated disabled domain account CT-6116, then pass `-RookAccount 'DOMAIN\CT-6116'`. The account must resolve and its account portion must be CT-6116. Assigning ownership requires suitable administrator/restore rights. The script stops if the owner cannot be changed.

These are initial provisioning scripts, not a universal repair/cleanup system. Existing service/task names trigger a stop rather than silently replacing unknown objects. After a partial run, inspect the failure and rerun only the needed `setup/checkpoints/HOST/<name>.ps1` scripts. Those scripts accept the same parameters as the host initializer. Do not bypass an existing-object conflict without verifying its origin.

## Put executables on hosts

Copy the **contents** of each `bin/HOST` directory to `C:\Republic\Hunt` on that host, preserving subdirectories. For example:

| Build output | Destination |
|---|---|
| `bin/Coruscant/Balcony/patio.exe` | Coruscant: `C:\Republic\Hunt\Balcony\patio.exe` |
| `bin/Naboo/Circuit/system66.exe` | Naboo: `C:\Republic\Hunt\Circuit\system66.exe` |
| `bin/Alderaan/Control/lastlight.exe` | Alderaan: `C:\Republic\Hunt\Control\lastlight.exe` |

Do not copy C source, headers, object files, setup scripts, or organizer keys into player-accessible directories. No deployment, Ansible edits, or remote execution is performed by this pack.

## Two-stage behavior

Each executable initially displays only the generic locked prompt. A correct **entry password** reveals the briefing. A correct **challenge answer** then displays the story, flag, and next stage's entry password. Wrong entry passwords never print the briefing. Restarting locks the program again. There is no global unlock file shared by teams.

For patio: enter `vanguard-k7m4p9`, investigate the hidden note, then submit `lantern`. Entering `lantern` at the first prompt fails.

The final executable shows the clone ending by default. For the droid ending, launch `lastlight.exe --droid`. This option changes only the ending; the scoreboard must independently identify the team and award the correct faction's points. Flags are the same for both factions, recorded once per stage per team. Maximum scores: blue 520; red 260.

These are local gameplay gates, not strong protection against binary string extraction, patching, shared passwords, or early reading of evidence. Require prior-stage completion per team on the scoreboard/referee ledger to enforce scored progression. No scoreboard service is included.

## Byte-sensitive fixtures

- The checksum setup writes explicit ASCII bytes with CRLF. Its verified digest is already in checksum.c; no manual digest editing is necessary. Changing silver.txt's bytes requires updating the compiled digest.
- The DNS record/domain/address must agree with Build.ps1's parameters.
- Create the alternate stream and hard link on their destination NTFS volumes.
- Set final packet timestamps after copying those evidence files. Copying only the compiled Control/lastlight.exe does not change packet timestamps.
- Inert service/task fixtures stay disabled. The system66 XML is never registered or executed. The two dispatch.exe props are text placeholders and are not checkpoint programs.

## Run a pilot

Open the five authorized host sessions in advance. Verify the setup-specific checks in the guide, then complete the 21-stage chain with the player account type. The guide's 72-minute solving estimate does not include slow reconnects or build/provisioning time. Confirm all hints, flag awards, and the prologue handoff before the event.

Review `tests/validation-results.md` for exactly what was tested here and what remains Windows-only.
