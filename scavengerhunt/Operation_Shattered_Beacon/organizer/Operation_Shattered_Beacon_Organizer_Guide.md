# Operation Shattered Beacon

## Organizer guide — revision 2, contains all passwords and answers

An original Clone Wars fan-fiction Windows scavenger hunt. Blue players are Republic clones. Red players are Separatist droids reconstructing the same intelligence for a smaller reward.

**This revision replaces the grouped planet route.** The player changes hosts after every checkpoint. Your existing executable is the prologue, followed by **21 challenges**: the original 20 plus **system66.exe**. There are 22 encounters including your opener. Coruscant, Kamino, Felucia, and Naboo each host four checkpoints; Alderaan hosts five.

All checkpoint executables have non-sequential names. The number in **system66.exe** is a fictional circuit designation, not a stage index. Stage numbers in this organizer document are administrative labels only: do not print them in executable titles, distribute a route manifest, or put them in player filenames.

The story follows CT-6116 “Rook,” a clone technician accused of desertion. His interrupted warning reveals that Separatists substituted a medical convoy’s evacuation order. He is actually rescuing wounded clones aboard Transport Seven. A balcony transmitter on Coruscant holds one half of his warning; a destroyed tactical droid on Felucia holds the other. Relay copies and logistics records send the players between fronts rather than completing one planet at a time.

**Timing:** 72 minutes of estimated solving, including the new identity puzzle. With pre-opened host sessions, aim for 80–90 minutes total; experienced teams with hints may finish in 45–60. Twenty host changes can exceed 90 minutes if every move requires a fresh login, so provide five already-authorized sessions and prompt hints. These are estimates, not playtest results.

## Two passwords at every checkpoint

The required runtime order is:

1. Display only a generic locked-terminal message and `Entry password:`.
2. Reject incorrect entry passwords without showing the briefing, target path, hint, puzzle answer prompt, next destination, or success text.
3. On the correct entry password, reveal that checkpoint’s briefing.
4. Prompt separately for `Challenge answer:`. A wrong answer retries this second prompt.
5. Only after a correct answer, show the story, carry token, scoring flag, next host, next executable’s full path, and its **entry password**.

On restart the entry gate locks again. Do not use a shared `.unlocked` file, HKLM completion marker, or global flag that opens a stage for every team. Entry passwords, puzzle answers, and carry tokens are distinct fields. Five puzzle answers still combine a prior carry token and newly recovered evidence; entry passwords protect the briefing independently of those combinations.

**Prologue change:** Keep your existing `keenlysemireboot` check. Add these lines only inside its successful-password branch, after the story:

```c
puts("Next host: Coruscant");
puts("Next terminal: C:\\Republic\\Hunt\\Balcony\\patio.exe");
puts("Entry password: vanguard-k7m4p9");
```

Opening `patio.exe` and typing `lantern` at the entry prompt must fail. The player first enters `vanguard-k7m4p9`, receives the hidden-file briefing, then submits `lantern` at the answer prompt. Every subsequent stage follows that pattern.

**Scope of the gate:** This prevents ordinary play from revealing briefings early. It does not prove a player’s identity or stop someone who extracts strings, patches a local binary, shares passwords, or reads static evidence ahead of time. For strict scored progression, require the scoreboard/referee to confirm each team’s previous checkpoint before accepting the next flag. For strict secrecy of future briefings against local administrators, serve those briefings from a team-authenticated external service after server-side prerequisite checks. The local C template below is the simple gameplay implementation, not that stronger service.

Keep source, this document, setup scripts, and the complete answer/password matrix off player hosts. The previous success screen provides the exact next path; do not make sequence-number searches part of the route. Discovering all executables should still reveal only locked prompts during ordinary execution.

## Common preparation — run once per host before its setup blocks

Use elevated **64-bit Windows PowerShell 5.1**. Evidence uses NTFS, and the examples target Windows Server 2019. These snippets create fixtures; they do not compile or deploy checkpoint programs. Each checkpoint section lists its executable path, gate values, evidence files/objects, simple setup commands, player briefing, solution, and success output.

Run this in the same PowerShell session as the per-challenge blocks. The default reader is the built-in Administrators group, suitable when competitors are using Administrator; replace it with your actual hunt user/group if needed. Use the same chosen identity in each host’s session.

```powershell
$ErrorActionPreference = 'Stop'
$HuntRoot = 'C:\Republic\Hunt'
$HuntReader = ([System.Security.Principal.SecurityIdentifier]::new('S-1-5-32-544')).Translate([System.Security.Principal.NTAccount]).Value
New-Item -ItemType Directory -Path $HuntRoot -Force | Out-Null
icacls.exe $HuntRoot /grant "${HuntReader}:(OI)(CI)(RX)"
if ($LASTEXITCODE -ne 0) { throw 'Hunt read permission setup failed' }
```

Run only the sections assigned to the host you are on. One exception is the DNS creation command, which explicitly runs on the DNS server. Do not point fixture paths at real service data. All ordinary clue inspections are read-only; no challenge requires stopping services, executing captured commands, changing a system clock, or obtaining a SYSTEM shell.

For each checkpoint, create its executable directory using the supplied command, customize the C template in the appendix on your build machine, compile it, and copy only the resulting executable to the stated host/path. Keep both faction runs independent. Rules should prohibit altering hunt evidence to prevent another team’s progress; privileged participants can otherwise delete or modify fixtures.

## Private route and password matrix

The entry password for each row is awarded only by the preceding row’s successful completion. Row 1 is awarded by your prologue. All strings are case-sensitive lowercase; preserve leading zeros and hyphens.

| Stage | Host | Executable under C:\Republic\Hunt | Entry password (before briefing) | Challenge answer (after briefing) | Carry token | Solve minutes |
|---|---|---|---|---|---|---:|
| 01 | Coruscant | `Balcony\patio.exe` | `vanguard-k7m4p9` | `lantern` | `balcony` | 2 |
| 02 | Kamino | `Comms\routecache.exe` | `a2c7e62469a9` | `7341` | `witness` | 3 |
| 03 | Felucia | `Relay\undertone.exe` | `16e79f560e5e` | `sentinel` | `senate` | 3 |
| 04 | Coruscant | `Evidence\receiver.exe` | `6217fb0a2f5e` | `senate-0427` | `river` | 4 |
| 05 | Naboo | `Courier\departure.exe` | `d1aa9f07a324` | `reed` | `pilot` | 2 |
| 06 | Alderaan | `Depot\stockroom.exe` | `62389486780f` | `transport` | `hangar` | 3 |
| 07 | Naboo | `Escort\watchman.exe` | `f1a869b2a61e` | `holdfast` | `marsh` | 3 |
| 08 | Kamino | `Flight\launchwindow.exe` | `cbc06ca86f8a` | `marsh-2187` | `rainfall` | 4 |
| 09 | Felucia | `Weather\atmosphere.exe` | `767b3c73489d` | `rain` | `cadet` | 3 |
| 10 | Kamino | `Records\ownercheck.exe` | `b5ec655ae633` | `ct-6116` | `rook` | 3 |
| 11 | Alderaan | `Records\clearance.exe` | `f28188ee9138` | `brother` | `brother` | 4 |
| 12 | Coruscant | `Dispatch\pathfinder.exe` | `b18b3a8611aa` | `brother-5502` | `spore` | 3 |
| 13 | Felucia | `Wreck\camouflage.exe` | `63ac4790a278` | `violet` | `wreck` | 4 |
| 14 | Naboo | `Telemetry\heartbeat.exe` | `acb34e839938` | `9771` | `signal` | 4 |
| 15 | Alderaan | `Analysis\coldmemory.exe` | `5f2629e19bb3` | `clanker` | `clanker` | 4 |
| 16 | Felucia | `Salvage\memorybank.exe` | `b914579c0e6c` | `clanker-9036` | `alderaan` | 4 |
| 17 | Coruscant | `Directory\twinvoice.exe` | `0c40567c1f56` | `mercy-beacon-anchor` | `council` | 3 |
| 18 | Kamino | `Orders\checksum.exe` | `6c8b44f52764` | `transport-7` | `rescue` | 4 |
| 19 | Alderaan | `Archive\echo.exe` | `64b943fe7386` | `dawn` | `dawn` | 4 |
| 20 | Naboo | `Circuit\system66.exe` | `feecf4e893ff` | `system` | `nova` | 3 |
| 21 | Alderaan | `Control\lastlight.exe` | `90149c7d22e1` | `nova-2714` | `complete` | 5 |

## Checkpoints in player travel order

### 01 — The Major on the Balcony

**Host:** Coruscant  
**Executable:** `C:\Republic\Hunt\Balcony\patio.exe`

**Entry password — required before showing any briefing:** `vanguard-k7m4p9`. Awarded by the successful prologue.

**Player briefing — display only after entry password succeeds:**
> KSSSH—Major Venn here. Welcome to Coruscant, trooper. We found the transmitter under the Senate balcony. The maintenance droid insists this directory is empty. Convenient. Inspect `C:\Republic\Hunt\Balcony` and recover the technician’s recognition word. Remember: what a console chooses to show is not everything the disk holds. Submit the word in lowercase.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Balcony\maintenance.txt`, with its Hidden attribute set.

**Simple setup — on Coruscant unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Balcony' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Balcony'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\maintenance.txt" 'Recognition word: LANTERN' -Encoding ASCII
attrib.exe +h "$dir\maintenance.txt"
```

The compiled executable stays visible. Only the evidence note is hidden.

**Organizer solution:** `Get-ChildItem 'C:\Republic\Hunt\Balcony' -Force`, then read the discovered file. Hidden is a display attribute, not an access-control mechanism.

**Exact challenge answer — accepted only after entry authentication:** `lantern`.

**Success transmission — only after both checks succeed:**
> Venn: “Good eyes. The maintenance note says the transmitter’s routing configuration was mirrored to Kamino. Follow that record. Whoever left this wanted a clone who would check the evidence.”
>
> Carry token: BALCONY.
> Next host: Kamino.
> Next terminal: `C:\Republic\Hunt\Comms\routecache.exe`.
> Next entry password: `a2c7e62469a9`.

**Hint:** PowerShell’s file listing has an option that includes hidden items.

### 02 — The Senator’s Routing Number

**Host:** Kamino  
**Executable:** `C:\Republic\Hunt\Comms\routecache.exe`

**Entry password — required before showing any briefing:** `a2c7e62469a9`. Awarded by the successful `patio.exe` on Coruscant.

**Player briefing — display only after entry password succeeds:**
> The seal reads REPUBLIC / COMMS / BALCONY. The sender did not leave the route in a document. Search the machine-wide Republic communications settings. Recover the four-digit `RouteCode`, preserving any leading zeros.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create A custom machine registry key; no separate clue file.

**Simple setup — on Kamino unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Comms' -Force | Out-Null
$key = 'HKLM:\SOFTWARE\Republic\Comms\Balcony'
New-Item -Path $key -Force | Out-Null
New-ItemProperty -Path $key -Name RouteCode -PropertyType String -Value '7341' -Force | Out-Null
```

Run this in 64-bit Windows PowerShell on Kamino. This is the replicated routing record for the device recovered on Coruscant.

**Organizer solution:** `Get-ItemProperty 'HKLM:\SOFTWARE\Republic\Comms\Balcony'`. Read the `RouteCode` property, not the registry key’s name.

**Exact challenge answer — accepted only after entry authentication:** `7341`.

**Success transmission — only after both checks succeed:**
> Kamino records officer: “Route 7341 belongs to medical logistics. A relay station on Felucia cached the balcony inspection before the sender disappeared. Its final line mentions a second voice.”
>
> Carry token: WITNESS.
> Next host: Felucia.
> Next terminal: `C:\Republic\Hunt\Relay\undertone.exe`.
> Next entry password: `16e79f560e5e`.

**Hint:** HKLM stores machine-wide settings; the clue names the key hierarchy.

### 03 — A Second Voice

**Host:** Felucia  
**Executable:** `C:\Republic\Hunt\Relay\undertone.exe`

**Entry password — required before showing any briefing:** `16e79f560e5e`. Awarded by the successful `routecache.exe` on Kamino.

**Player briefing — display only after entry password succeeds:**
> The Felucia relay copy `C:\Republic\Hunt\Balcony\inspection.txt` looks like an ordinary maintenance report. Its last line reads: “The visible report is for the Senate. The second stream is for my brothers.” Find the second voice and submit its authentication word.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Balcony\inspection.txt` and its NTFS named stream `comlink`.

**Simple setup — on Felucia unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Relay' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Balcony'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\inspection.txt" 'The visible report is for the Senate. The second stream is for my brothers.' -Encoding ASCII
Set-Content "$dir\inspection.txt" -Stream comlink -Value 'Authentication word: SENTINEL' -Encoding ASCII
Get-Item "$dir\inspection.txt" -Stream *
```

Run on Felucia: this is a relay copy of the balcony report. Create the stream after copying/deploying files to this NTFS volume.

**Organizer solution:** ```powershell
Get-Item 'C:\Republic\Hunt\Balcony\inspection.txt' -Stream *
Get-Content 'C:\Republic\Hunt\Balcony\inspection.txt' -Stream comlink
```

**Exact challenge answer — accepted only after entry authentication:** `sentinel`.

**Success transmission — only after both checks succeed:**
> Unknown clone: “The evacuation order is wrong. I split my warning because the droids were reading our dispatches.” Venn: “This relay copy points back to the original receive log on Coruscant. Find the last successful packet.”
>
> Carry token: SENATE.
> Next host: Coruscant.
> Next terminal: `C:\Republic\Hunt\Evidence\receiver.exe`.
> Next entry password: `6217fb0a2f5e`.

**Hint:** A single NTFS filename can have more than its default data stream.

### 04 — The Broken Interception

**Host:** Coruscant  
**Executable:** `C:\Republic\Hunt\Evidence\receiver.exe`

**Entry password — required before showing any briefing:** `6217fb0a2f5e`. Awarded by the successful `undertone.exe` on Felucia.

**Player briefing — display only after entry password succeeds:**
> Open `C:\Republic\Hunt\Evidence\balcony.evtx`. For provider `RepublicComms`, find the newest Event ID 4101 whose message says `Result=RECEIVED`. Extract `PacketCode`. Enter the previous checkpoint’s carry token, a hyphen, then this code. Failed receptions are not valid packets.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Evidence\balcony.evtx`; dedicated `RepublicHunt` event log and `RepublicComms` source used to generate it.

**Simple setup — on Coruscant unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Evidence' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Evidence'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
if (-not [Diagnostics.EventLog]::SourceExists('RepublicComms')) {
    New-EventLog -LogName RepublicHunt -Source RepublicComms
}
if ([Diagnostics.EventLog]::LogNameFromSourceName('RepublicComms','.') -ne 'RepublicHunt') {
    throw 'RepublicComms already belongs to another log. Resolve the fixture-name conflict first.'
}
Write-EventLog -LogName RepublicHunt -Source RepublicComms -EventId 4101 -EntryType Information -Message 'Result=RECEIVED; PacketCode=8110'
Start-Sleep -Seconds 1
Write-EventLog -LogName RepublicHunt -Source RepublicComms -EventId 4101 -EntryType Information -Message 'Result=RECEIVED; PacketCode=0427'
Start-Sleep -Seconds 1
Write-EventLog -LogName RepublicHunt -Source RepublicComms -EventId 4101 -EntryType Information -Message 'Result=FAILED; PacketCode=9900'
wevtutil.exe epl RepublicHunt "$dir\balcony.evtx" /ow:true
if ($LASTEXITCODE -ne 0) { throw 'Event export failed' }
Get-WinEvent -Path "$dir\balcony.evtx" -MaxEvents 3 | Format-List TimeCreated,Id,ProviderName,Message
```

Keep the source registered on Coruscant so the saved log message renders there. Rerunning adds records, but the newest successful packet still reads 0427. Do not clear real system logs.

**Organizer solution:** Open the saved log in Event Viewer or use `Get-WinEvent -Path 'C:\Republic\Hunt\Evidence\balcony.evtx'`; filter provider, ID, and success status, then sort `TimeCreated` descending. The latest success is 0427, even though a later failed attempt exists.

**Exact challenge answer — accepted only after entry authentication:** `senate-0427`.

**Success transmission — only after both checks succeed:**
> “This is CT-6116. Medical convoy AUREK is being redirected. The Senate order has been substituted. Authentication phrase, first half: MERCY. Preserve it. My courier reached Naboo. If command brands me a deserter, ask why a deserter would transmit his own number.” Venn: “Find that courier.”
>
> Carry token: RIVER.
> Save transmission half A: MERCY.
> Next host: Naboo.
> Next terminal: `C:\Republic\Hunt\Courier\departure.exe`.
> Next entry password: `d1aa9f07a324`.

**Hint:** Filter for successful reception before choosing the newest record.

### 05 — The Courier’s Disappearing Act

**Host:** Naboo  
**Executable:** `C:\Republic\Hunt\Courier\departure.exe`

**Entry password — required before showing any briefing:** `d1aa9f07a324`. Awarded by the successful `receiver.exe` on Coruscant.

**Player briefing — display only after entry password succeeds:**
> Naboo’s landing officer hands you a shortcut labeled “Courier Departure.” He swears the courier vanished through it. Inspect `C:\Republic\Hunt\Courier\Departure.lnk` without launching it. The real destination is less interesting than the courier’s callsign in its arguments.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Courier\Departure.lnk`, a real Windows shortcut.

**Simple setup — on Naboo unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Courier' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Courier'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$ws = New-Object -ComObject WScript.Shell
$shortcut = $ws.CreateShortcut("$dir\Departure.lnk")
$shortcut.TargetPath = "$env:SystemRoot\System32\cmd.exe"
$shortcut.Arguments = '/c echo Courier REED: departure cancelled'
$shortcut.Description = 'Courier departure record'
$shortcut.Save()
```

Do not create an ordinary text file with a .lnk suffix; it must be a genuine shortcut.

**Organizer solution:** Shortcut Properties → Target, or:
```powershell
$ws = New-Object -ComObject WScript.Shell
$lnk = $ws.CreateShortcut('C:\Republic\Hunt\Courier\Departure.lnk')
$lnk | Select-Object TargetPath, Arguments, WorkingDirectory
```

**Exact challenge answer — accepted only after entry authentication:** `reed`.

**Success transmission — only after both checks succeed:**
> Reed’s note: “Droids were waiting at my departure gate. Someone had the flight plan before I filed it. I sent the dispatch ahead to the supply depot on Alderaan. Follow the share, not the label.”
>
> Carry token: PILOT.
> Next host: Alderaan.
> Next terminal: `C:\Republic\Hunt\Depot\stockroom.exe`.
> Next entry password: `62389486780f`.

**Hint:** A shortcut stores a destination and optional command-line arguments.

### 06 — The Quiet Supply Depot

**Host:** Alderaan  
**Executable:** `C:\Republic\Hunt\Depot\stockroom.exe`

**Entry password — required before showing any briefing:** `62389486780f`. Awarded by the successful `departure.exe` on Naboo.

**Player briefing — display only after entry password succeeds:**
> The logistics share is named `RepublicSupply$`. Inspect its configuration on Alderaan and find its actual local backing directory. Read `dispatch.txt` there and recover the shipment category. Do not assume the share name is the folder name.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Depot\Medical\dispatch.txt` and the SMB share `RepublicSupply$` on Alderaan.

**Simple setup — on Alderaan unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Depot' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Depot\Medical'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\dispatch.txt" 'Shipment category: TRANSPORT' -Encoding ASCII
icacls.exe $dir /grant "${HuntReader}:(OI)(CI)(RX)"
if ($LASTEXITCODE -ne 0) { throw 'NTFS read grant failed' }
$share = Get-SmbShare -Name 'RepublicSupply$' -ErrorAction SilentlyContinue
if ($share -and $share.Path -ne $dir) { throw 'Share name already used for another path' }
if (-not $share) {
    New-SmbShare -Name 'RepublicSupply$' -Path $dir -ReadAccess $HuntReader | Out-Null
} else {
    Grant-SmbShareAccess -Name 'RepublicSupply$' -AccountName $HuntReader -AccessRight Read -Force | Out-Null
}
```

The courier forwarded this dispatch to Alderaan. Inspect the share locally on Alderaan; networking between teams is not a dependency for reading the backing file.

**Organizer solution:** `Get-SmbShare -Name 'RepublicSupply$' | Select-Object Name,Path`, then read `dispatch.txt` at the returned path. The trailing `$` hides normal share browsing; it is not a password.

**Exact challenge answer — accepted only after entry authentication:** `transport`.

**Success transmission — only after both checks succeed:**
> Alderaan quartermaster: “This transport record refers to a Naboo escort that never reported for duty. Its registration survives. Find out what the courier left in that record.”
>
> Carry token: HANGAR.
> Next host: Naboo.
> Next terminal: `C:\Republic\Hunt\Escort\watchman.exe`.
> Next entry password: `f1a869b2a61e`.

**Hint:** Enumerate the share’s local path rather than relying on Explorer’s network list.

### 07 — The Escort That Never Started

**Host:** Naboo  
**Executable:** `C:\Republic\Hunt\Escort\watchman.exe`

**Entry password — required before showing any briefing:** `f1a869b2a61e`. Awarded by the successful `stockroom.exe` on Alderaan.

**Player briefing — display only after entry password succeeds:**
> Inspect the Windows service named `RepublicEscort`. Recover the extraction word in its description. The escort may be stopped. Do not start it: the service record is the evidence.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create The disabled service `RepublicEscort`; no runnable service program or separate clue file.

**Simple setup — on Naboo unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Escort' -Force | Out-Null
$svc = Get-Service -Name RepublicEscort -ErrorAction SilentlyContinue
if ($svc) { throw 'RepublicEscort already exists; verify it is your hunt fixture before reusing it' }
New-Service -Name RepublicEscort -DisplayName 'Republic Escort Record' -BinaryPathName "$env:SystemRoot\System32\cmd.exe /c exit 0" -StartupType Disabled -Description 'Courier fallback extraction word: HOLDFAST' | Out-Null
Get-CimInstance Win32_Service -Filter "Name='RepublicEscort'" | Select-Object Name,State,StartMode,Description
```

This is intentionally an inert service record, not a working service binary. Never enable or start it. Its description is all the player needs.

**Organizer solution:** `Get-CimInstance Win32_Service -Filter "Name='RepublicEscort'" | Select-Object Name,State,StartMode,Description,PathName`. The basic Services view or `Get-Service` default output might not expose the field the player needs.

**Exact challenge answer — accepted only after entry authentication:** `holdfast`.

**Success transmission — only after both checks succeed:**
> Reed: “CT-6116 is a technician from Kamino. His brothers call him Rook. I sent his launch schedule back to the cloning facility. The request was disabled, but its instructions should still be there.”
>
> Carry token: MARSH.
> Next host: Kamino.
> Next terminal: `C:\Republic\Hunt\Flight\launchwindow.exe`.
> Next entry password: `cbc06ca86f8a`.

**Hint:** Service metadata survives even when no service process is running.

### 08 — The Midnight Launch

**Host:** Kamino  
**Executable:** `C:\Republic\Hunt\Flight\launchwindow.exe`

**Entry password — required before showing any briefing:** `cbc06ca86f8a`. Awarded by the successful `watchman.exe` on Naboo.

**Player briefing — display only after entry password succeeds:**
> Inspect the disabled task `MidnightLaunch` in Task Scheduler’s `\Republic\` folder. Read the action arguments and recover `LaunchCode`. Do not run the task. Submit the previous carry token followed by a hyphen and the launch code.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create A disabled task named `MidnightLaunch` in Task Scheduler folder `\Republic\` on Kamino.

**Simple setup — on Kamino unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Flight' -Force | Out-Null
$scheduler = New-Object -ComObject Schedule.Service
$scheduler.Connect()
try { $null = $scheduler.GetFolder('\Republic') }
catch { $null = $scheduler.GetFolder('\').CreateFolder('Republic') }
if (Get-ScheduledTask -TaskPath '\Republic\' -TaskName MidnightLaunch -ErrorAction SilentlyContinue) {
    throw 'MidnightLaunch already exists; verify the existing hunt fixture before replacing it'
}
$action = New-ScheduledTaskAction -Execute "$env:SystemRoot\System32\cmd.exe" -Argument '/c echo LaunchCode=2187 Destination=Felucia'
$principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount
$settings = New-ScheduledTaskSettingsSet -Disable
$definition = New-ScheduledTask -Action $action -Principal $principal -Settings $settings
Register-ScheduledTask -TaskPath '\Republic\' -TaskName MidnightLaunch -InputObject $definition | Out-Null
```

No trigger is installed, and the task is disabled. This is the launch request mirrored to Kamino, not something players must run.

**Organizer solution:** ```powershell
$task = Get-ScheduledTask -TaskPath '\Republic\' -TaskName 'MidnightLaunch'
$task.Actions | Format-List Execute, Arguments, WorkingDirectory
```

**Exact challenge answer — accepted only after entry authentication:** `marsh-2187`.

**Success transmission — only after both checks succeed:**
> Kamino flight controller: “The launch would have supplied Felucia’s weather relay. Rook hid a rendezvous word in that station’s machine environment. Visit the relay, then bring its receipt back here.”
>
> Carry token: RAINFALL.
> Next host: Felucia.
> Next terminal: `C:\Republic\Hunt\Weather\atmosphere.exe`.
> Next entry password: `767b3c73489d`.

**Hint:** Inspect the action, not just the trigger time or the last run result.

### 09 — Orders in the Atmosphere

**Host:** Felucia  
**Executable:** `C:\Republic\Hunt\Weather\atmosphere.exe`

**Entry password — required before showing any briefing:** `767b3c73489d`. Awarded by the successful `launchwindow.exe` on Kamino.

**Player briefing — display only after entry password succeeds:**
> Felucia’s weather terminal reads: “A process inherits its atmosphere when it begins.” Recover the **machine-scoped** environment variable `REPUBLIC_WEATHER`. A value from only your current shell is not sufficient evidence.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create Machine-scoped environment variable `REPUBLIC_WEATHER`; no clue file.

**Simple setup — on Felucia unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Weather' -Force | Out-Null
[Environment]::SetEnvironmentVariable('REPUBLIC_WEATHER','RAIN','Machine')
[Environment]::GetEnvironmentVariable('REPUBLIC_WEATHER','Machine')
```

The weather value is stored on Felucia. Existing shells may retain old process-scoped values; the explicit Machine lookup is the intended solve.

**Organizer solution:** `[Environment]::GetEnvironmentVariable('REPUBLIC_WEATHER','Machine')`.

**Exact challenge answer — accepted only after entry authentication:** `rain`.

**Success transmission — only after both checks succeed:**
> Felucia relay operator: “Rook passed this station before the fighting. We retained his weather word, but Kamino still holds his original report. Check the owner identity—anyone can type a clone number inside a document.”
>
> Carry token: CADET.
> Next host: Kamino.
> Next terminal: `C:\Republic\Hunt\Records\ownercheck.exe`.
> Next entry password: `b5ec655ae633`.

**Hint:** Machine, user, and current-process environment scopes are different.

### 10 — More Than a Number

**Host:** Kamino  
**Executable:** `C:\Republic\Hunt\Records\ownercheck.exe`

**Entry password — required before showing any briefing:** `b5ec655ae633`. Awarded by the successful `atmosphere.exe` on Felucia.

**Player briefing — display only after entry password succeeds:**
> Inspect the owner of `C:\Republic\Hunt\Records\rook-report.txt`. Resolve the owner’s security identifier to its account name. Submit only the account portion, without the computer or domain prefix.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Records\rook-report.txt` and a disabled identity `CT-6116` that owns the file.

**Simple setup — on Kamino unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Records' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Records'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\rook-report.txt" 'Report filed before the evacuation order was issued.' -Encoding ASCII
icacls.exe "$dir\rook-report.txt" /grant "${HuntReader}:(R)"
if ($LASTEXITCODE -ne 0) { throw 'Read grant failed' }
# Member-server setup: Kamino must not be a domain controller for these local-user commands.
if (-not (Get-LocalUser -Name 'CT-6116' -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name 'CT-6116' -NoPassword -Disabled -Description 'Disabled hunt evidence identity' | Out-Null
}
if ((Get-LocalUser -Name 'CT-6116').Enabled) { throw 'The hunt identity must remain disabled' }
icacls.exe "$dir\rook-report.txt" /setowner "$env:COMPUTERNAME\CT-6116"
if ($LASTEXITCODE -ne 0) { throw 'Owner change failed; use an account with restore/owner-assignment rights' }
(Get-Acl "$dir\rook-report.txt").Owner
```

Run elevated in 64-bit Windows PowerShell. If Kamino is a DC, create a dedicated disabled domain account CT-6116 in AD Users and Computers instead; omit the local-user commands and use DOMAIN\CT-6116 in /setowner. Confirm the owner resolves and participants can still read the file.

**Organizer solution:** `(Get-Acl 'C:\Republic\Hunt\Records\rook-report.txt').Owner`. If needed, call the returned ACL’s `GetOwner([System.Security.Principal.SecurityIdentifier])` method and translate that SID to `[System.Security.Principal.NTAccount]`. Expected resolved account ends in `\CT-6116`.

**Exact challenge answer — accepted only after entry authentication:** `ct-6116`.

**Success transmission — only after both checks succeed:**
> Kamino records officer: “That is Rook’s account. The report predates the forged order. He sent a clearance memo to Alderaan, where a classification label convinced everyone to stop reading.”
>
> Carry token: ROOK.
> Next host: Alderaan.
> Next terminal: `C:\Republic\Hunt\Records\clearance.exe`.
> Next entry password: `f28188ee9138`.

**Hint:** The NTFS owner is metadata, not the author’s name typed inside the report.

### 11 — A Clearance That Means Nothing

**Host:** Alderaan  
**Executable:** `C:\Republic\Hunt\Records\clearance.exe`

**Entry password — required before showing any briefing:** `f28188ee9138`. Awarded by the successful `ownercheck.exe` on Kamino.

**Player briefing — display only after entry password succeeds:**
> `C:\Republic\Hunt\Records\clearance.txt` begins with “TOP SECRET—ACCESS DENIED.” Is that statement true? Inspect its ACL and read the file using your current authorized account. Submit its brotherhood word. Your report must explain why the file is readable.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Records\clearance.txt` with an explicit read grant for hunt participants.

**Simple setup — on Alderaan unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Records' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Records'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
@'
TOP SECRET - ACCESS DENIED
This heading is a classification label, not a Windows permission.
Brotherhood word: BROTHER
'@ | Set-Content "$dir\clearance.txt" -Encoding ASCII
icacls.exe "$dir\clearance.txt" /grant "${HuntReader}:(R)"
if ($LASTEXITCODE -ne 0) { throw 'Read grant failed' }
icacls.exe "$dir\clearance.txt"
```

Create in a fresh hunt directory without inherited deny entries. Verify read access using the actual participant identity; players do not modify the ACL.

**Organizer solution:** `Get-Acl` or `icacls` on the file, plus `Get-Content`. Players must distinguish a warning in file contents from Windows access enforcement. Reading the token alone is not full evidence credit; identify the applicable read grant.

**Exact challenge answer — accepted only after entry authentication:** `brother`.

**Success transmission — only after both checks succeed:**
> Rook: “They stamped the substitute order with every clearance word they knew. A label is not authority. Coruscant’s dispatch archive has two utilities with the same name. Find which one the launch path would select.”
>
> Carry token: BROTHER.
> Next host: Coruscant.
> Next terminal: `C:\Republic\Hunt\Dispatch\pathfinder.exe`.
> Next entry password: `b18b3a8611aa`.

**Hint:** The DACL controls access; a line of text saying ACCESS DENIED does not.

### 12 — First in Line

**Host:** Coruscant  
**Executable:** `C:\Republic\Hunt\Dispatch\pathfinder.exe`

**Entry password — required before showing any briefing:** `b18b3a8611aa`. Awarded by the successful `clearance.exe` on Alderaan.

**Player briefing — display only after entry password succeeds:**
> This fixture recreates the droids’ dispatch search. The command is exactly `dispatch.exe`. It exists nowhere in the launch directory. The search path is exactly `C:\Republic\Hunt\Vendor;C:\Republic\Hunt\Trusted`. Determine which candidate is found first and read that candidate’s adjacent `dispatch-code.txt`. Do not run either candidate. Combine its code with the previous carry token.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Vendor\dispatch.exe`, `Trusted\dispatch.exe`, and `dispatch-code.txt` beside each.

**Simple setup — on Coruscant unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Dispatch' -Force | Out-Null
foreach ($folder in 'Vendor','Trusted') {
    $dir = "C:\Republic\Hunt\$folder"
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Set-Content "$dir\dispatch.exe" 'INERT HUNT PLACEHOLDER - DO NOT EXECUTE' -Encoding ASCII
}
Set-Content 'C:\Republic\Hunt\Vendor\dispatch-code.txt' '5502' -Encoding ASCII
Set-Content 'C:\Republic\Hunt\Trusted\dispatch-code.txt' '1188' -Encoding ASCII
```

These two .exe files are deliberately non-executable evidence props, not checkpoints. Do not change the host PATH. The briefing specifies the search order to reconstruct.

**Organizer solution:** Apply the stated ordered search: Vendor is first. Optionally demonstrate in a disposable shell using a scoped PATH and `where.exe dispatch.exe`, from a directory with no candidate; restore the environment afterward. The expected result is based on the fixed fixture, not PowerShell alias/function precedence.

**Exact challenge answer — accepted only after entry authentication:** `brother-5502`.

**Success transmission — only after both checks succeed:**
> Venn: “The first dispatch candidate was the substitute. Its route points to a tactical droid destroyed on Felucia. The recovery team has a sensor image that refuses to open. Find out what it really is.”
>
> Carry token: SPORE.
> Next host: Felucia.
> Next terminal: `C:\Republic\Hunt\Wreck\camouflage.exe`.
> Next entry password: `63ac4790a278`.

**Hint:** An executable’s basename alone does not establish which file a search selects.

### 13 — Jungle Camouflage

**Host:** Felucia  
**Executable:** `C:\Republic\Hunt\Wreck\camouflage.exe`

**Entry password — required before showing any briefing:** `63ac4790a278`. Awarded by the successful `pathfinder.exe` on Coruscant.

**Player briefing — display only after entry password succeeds:**
> The wreck recovery folder contains `C:\Republic\Hunt\Wreck\sensor-image.jpg`. It will not open as a photograph. Inspect its first bytes and identify the actual container. Extract a copy with the appropriate tool and recover the salvage word.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Wreck\sensor-image.jpg`, actually a ZIP containing `salvage.txt`.

**Simple setup — on Felucia unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Wreck' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Wreck'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$build = Join-Path $env:TEMP ('HuntBuild-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $build | Out-Null
Set-Content "$build\salvage.txt" 'Salvage word: VIOLET' -Encoding ASCII
Compress-Archive -Path "$build\salvage.txt" -DestinationPath "$build\sensor.zip"
Copy-Item "$build\sensor.zip" "$dir\sensor-image.jpg" -Force
Remove-Item -LiteralPath $build -Recurse -Force
```

The temporary build directory is removed so its loose answer file does not remain on the player host. Players extract their own copy into scratch.

**Organizer solution:** `Format-Hex` reveals `PK`. Copy the file to a `.zip` filename in player scratch, then use `Expand-Archive` or Explorer. A misleading extension does not change the data format.

**Exact challenge answer — accepted only after entry authentication:** `violet`.

**Success transmission — only after both checks succeed:**
> Recovery trooper: “That was a collection bundle, not a photograph. We forwarded its connection and process snapshots to Naboo for correlation. Find the process behind the droid’s last transmission.”
>
> Carry token: WRECK.
> Next host: Naboo.
> Next terminal: `C:\Republic\Hunt\Telemetry\heartbeat.exe`.
> Next entry password: `acb34e839938`.

**Hint:** File signatures are stronger evidence of format than the suffix on the filename.

### 14 — The Droid’s Last Heartbeat

**Host:** Naboo  
**Executable:** `C:\Republic\Hunt\Telemetry\heartbeat.exe`

**Entry password — required before showing any briefing:** `acb34e839938`. Awarded by the successful `camouflage.exe` on Felucia.

**Player briefing — display only after entry password succeeds:**
> Naboo analysts received wreck snapshots named `connections.csv` and `processes.csv` in `C:\Republic\Hunt\Wreck`. These are records from the **same captured instant**, not the current host state. Find the connection to documentation address `192.0.2.77`, remote port `7443`. Match its owning PID to the process snapshot and recover `BeaconCode` from that process’s command line.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Wreck\connections.csv` and `Wreck\processes.csv`, authored snapshots copied to Naboo.

**Simple setup — on Naboo unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Telemetry' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Wreck'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
@'
RemoteAddress,RemotePort,OwningProcess
192.0.2.20,443,1200
192.0.2.77,7443,4242
192.0.2.77,443,8080
'@ | Set-Content "$dir\connections.csv" -Encoding ASCII
@'
ProcessId,Name,CommandLine
1200,medrelay.exe,"medrelay.exe --BeaconCode 1140"
4242,relay.exe,"relay.exe --BeaconCode 9771"
8080,inventory.exe,"inventory.exe --BeaconCode 3300"
'@ | Set-Content "$dir\processes.csv" -Encoding ASCII
```

Both snapshots represent the same instant. Do not create real processes, connections, or beacons. Naboo analysts received these from the Felucia wreck.

**Organizer solution:** `Import-Csv`, filter remote endpoint, then join `OwningProcess` to `ProcessId`. This models correlating Windows connection ownership with process metadata; it is not a live process-enumeration puzzle.

**Exact challenge answer — accepted only after entry authentication:** `9771`.

**Success transmission — only after both checks succeed:**
> Naboo analyst: “The matching process carried an encoded command. Its preserved command line is with the Alderaan analysis desk. Decode it; do not execute it.”
>
> Carry token: SIGNAL.
> Next host: Alderaan.
> Next terminal: `C:\Republic\Hunt\Analysis\coldmemory.exe`.
> Next entry password: `5f2629e19bb3`.

**Hint:** The connection table’s owning PID links to the process snapshot’s process ID.

### 15 — Cold Memory

**Host:** Alderaan  
**Executable:** `C:\Republic\Hunt\Analysis\coldmemory.exe`

**Entry password — required before showing any briefing:** `5f2629e19bb3`. Awarded by the successful `heartbeat.exe` on Naboo.

**Player briefing — display only after entry password succeeds:**
> Read `C:\Republic\Hunt\Wreck\last-command.txt`. It contains a `powershell.exe -EncodedCommand` record. Recover its plaintext without running it, and submit the recovered word. The droids did not use ordinary UTF-8 text here.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Wreck\last-command.txt`, holding encoded text for inspection only.

**Simple setup — on Alderaan unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Analysis' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Wreck'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
$plain = "Write-Output 'CLANKER'"
$encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($plain))
Set-Content "$dir\last-command.txt" "powershell.exe -EncodedCommand $encoded" -Encoding ASCII
```

This copy is on Alderaan for analysis. No command is executed by setup or by the intended solution.

**Organizer solution:** Copy only the Base64 argument into `$encoded`, then:
```powershell
[Text.Encoding]::Unicode.GetString([Convert]::FromBase64String($encoded))
```

**Exact challenge answer — accepted only after entry authentication:** `clanker`.

**Success transmission — only after both checks succeed:**
> Droid memory: “UNIT DESIGNATION: CLANKER. ORGANIC AUTHENTICATION FRAGMENT RETAINED. FALLBACK STORAGE: FELUCIA SALVAGE REGISTRY.” Analyst: “Back to the wreck. That fallback may hold the missing half.”
>
> Carry token: CLANKER.
> Next host: Felucia.
> Next terminal: `C:\Republic\Hunt\Salvage\memorybank.exe`.
> Next entry password: `b914579c0e6c`.

**Hint:** Base64 is an encoding; after decoding it, interpret the bytes using the correct character encoding.

### 16 — The Other Half

**Host:** Felucia  
**Executable:** `C:\Republic\Hunt\Salvage\memorybank.exe`

**Entry password — required before showing any briefing:** `b914579c0e6c`. Awarded by the successful `coldmemory.exe` on Alderaan.

**Player briefing — display only after entry password succeeds:**
> Inspect `HKLM\SOFTWARE\Republic\Salvage\DroidMemory`. `FragmentBytes` is binary data. Interpret its bytes as ASCII to recover four digits. Prefix them with the previous carry token and a hyphen to reassemble the damaged message.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create Registry key `HKLM\SOFTWARE\Republic\Salvage\DroidMemory`, with a binary value.

**Simple setup — on Felucia unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Salvage' -Force | Out-Null
$key = 'HKLM:\SOFTWARE\Republic\Salvage\DroidMemory'
New-Item -Path $key -Force | Out-Null
New-ItemProperty -Path $key -Name FragmentBytes -PropertyType Binary -Value ([byte[]](0x39,0x30,0x33,0x36)) -Force | Out-Null
```

Use 64-bit PowerShell on Felucia. These bytes decode to ASCII 9036, not their displayed decimal byte values.

**Organizer solution:** ```powershell
$bytes = (Get-ItemProperty 'HKLM:\SOFTWARE\Republic\Salvage\DroidMemory').FragmentBytes
[Text.Encoding]::ASCII.GetString($bytes)
```

**Exact challenge answer — accepted only after entry authentication:** `clanker-9036`.

**Success transmission — only after both checks succeed:**
> “Rook again. Authentication phrase, second half: BEACON. I am alive. I took wounded brothers off Felucia. Coruscant’s message was my warning; the evacuation order is the forgery. Join the two words, first half then second, with a hyphen. Ask the Republic directory on Coruscant.” Venn: “He was buying them time.”
>
> Carry token: ALDERAAN.
> Save transmission half B: BEACON.
> Next host: Coruscant.
> Next terminal: `C:\Republic\Hunt\Directory\twinvoice.exe`.
> Next entry password: `0c40567c1f56`.

**Hint:** Hexadecimal 39 is the byte for the character `9`.

### 17 — Two Voices, One Warning

**Host:** Coruscant  
**Executable:** `C:\Republic\Hunt\Directory\twinvoice.exe`

**Entry password — required before showing any briefing:** `0c40567c1f56`. Awarded by the successful `memorybank.exe` on Felucia.

**Player briefing — display only after entry password succeeds:**
> Retrieve the two saved transmission halves: Coruscant first, Felucia second. Join them with a hyphen and lowercase the result. Query the TXT record at `<joined-phrase>.hunt.clone.wars` from Coruscant using the supplied Republic DNS server address. Submit `<joined-phrase>-<TXT-word>`. An A-record lookup alone will not answer this question.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create One DNS TXT record on the authoritative DNS server; the checkpoint executable is on Coruscant.

**Simple setup — on Coruscant unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Directory' -Force | Out-Null
# Run this block ON THE DNS SERVER, in elevated PowerShell.
Import-Module DnsServer
$zone = 'clone.wars'  # Change if the actual lab domain differs.
$record = 'mercy-beacon.hunt'
$existing = Get-DnsServerResourceRecord -ZoneName $zone -Name $record -RRType TXT -ErrorAction SilentlyContinue
if ($existing) {
    $existing | Format-List HostName,RecordData
    throw 'TXT record already exists; confirm exactly one text value ANCHOR before continuing'
}
Add-DnsServerResourceRecord -ZoneName $zone -Name $record -Txt -DescriptiveText 'ANCHOR'
# Then run on Coruscant; enter the real DNS server IP when asked.
$dnsIP = Read-Host 'Actual lab DNS server IP'
Resolve-DnsName -Name "mercy-beacon.hunt.$zone" -Type TXT -Server $dnsIP
```

When using a second session on Coruscant, set $zone there too. Print the real DNS server IP and correct domain in the gated player briefing. The DNS zone must already exist. Do not use the literal placeholder <actual-DNS-IP>.

**Organizer solution:** `Resolve-DnsName -Name mercy-beacon.hunt.clone.wars -Type TXT -Server <actual-DNS-IP>`. The angle-bracket value is an organizer substitution, not literal player input.

**Exact challenge answer — accepted only after entry authentication:** `mercy-beacon-anchor`.

**Success transmission — only after both checks succeed:**
> Coruscant directory relay: “Two-part authentication accepted. Kamino retains several copies of the evacuation order and an independently trusted digest. Find the genuine correction before the convoy follows the wrong coordinates.”
>
> Carry token: COUNCIL.
> Next host: Kamino.
> Next terminal: `C:\Republic\Hunt\Orders\checksum.exe`.
> Next entry password: `6c8b44f52764`.

**Hint:** TXT records contain text data; DNS is not limited to hostname-to-IP answers.

### 18 — Orders That Survived the Forgery

**Host:** Kamino  
**Executable:** `C:\Republic\Hunt\Orders\checksum.exe`

**Entry password — required before showing any briefing:** `6c8b44f52764`. Awarded by the successful `twinvoice.exe` on Coruscant.

**Player briefing — display only after entry password succeeds:**
> The four orders in `C:\Republic\Hunt\Orders` disagree. Compare their SHA-256 hashes with the trusted digest printed below in this briefing. Read the matching file and submit its `RescueTarget`. Modification time, filename, and Republic letterhead are not enough to establish a match.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create Four candidate order text files; one trusted digest embedded inside the gated briefing.

**Simple setup — on Kamino unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Orders' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Orders'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
Set-Content "$dir\amber.txt" 'RescueTarget=TRANSPORT-2' -Encoding ASCII
Set-Content "$dir\silver.txt" 'RescueTarget=TRANSPORT-7' -Encoding ASCII
Set-Content "$dir\copper.txt" 'RescueTarget=TRANSPORT-9' -Encoding ASCII
Set-Content "$dir\ivory.txt" 'RescueTarget=TRANSPORT-4' -Encoding ASCII
(Get-FileHash "$dir\silver.txt" -Algorithm SHA256).Hash
```

Copy the displayed hash into the private build configuration as part of this checkpoint’s briefing. Do not save a public answer manifest. Recompute the digest if file bytes, encoding, or line endings change.

**Organizer solution:** `Get-FileHash 'C:\Republic\Hunt\Orders\*.txt' -Algorithm SHA256`, compare with the provided trusted digest, then read the matching file. Hash equality establishes identity with the trusted reference, not intrinsic authorship or safety by itself.

**Exact challenge answer — accepted only after entry authentication:** `transport-7`.

**Success transmission — only after both checks succeed:**
> Verified correction: “Medical convoy AUREK: disregard the evacuation route. Transport Seven carries CT-6116 and wounded personnel.” Kamino officer: “Alderaan filed its authorization under two names. Find the surviving link.”
>
> Carry token: RESCUE.
> Next host: Alderaan.
> Next terminal: `C:\Republic\Hunt\Archive\echo.exe`.
> Next entry password: `64b943fe7386`.

**Hint:** Hash the bytes of every candidate; a familiar filename is not proof.

### 19 — Two Names, One Signal

**Host:** Alderaan  
**Executable:** `C:\Republic\Hunt\Archive\echo.exe`

**Entry password — required before showing any briefing:** `64b943fe7386`. Awarded by the successful `checksum.exe` on Kamino.

**Player briefing — display only after entry password succeeds:**
> Inspect `C:\Republic\Hunt\Archive\routine.txt`. The archivist says this is a second name for an existing file, not a copied file and not a shortcut. Enumerate its NTFS hard links. The other filename’s stem is the authorization word. Submit it in lowercase.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Signals\DAWN.txt` and a genuine NTFS hard link `Archive\routine.txt` on Alderaan.

**Simple setup — on Alderaan unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Archive' -Force | Out-Null
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Signals','C:\Republic\Hunt\Archive' -Force | Out-Null
Set-Content 'C:\Republic\Hunt\Signals\DAWN.txt' 'Final authorization record retained under an alternate name.' -Encoding ASCII
if (Test-Path 'C:\Republic\Hunt\Archive\routine.txt') {
    throw 'routine.txt already exists; inspect it before recreating the hunt hard link'
}
New-Item -ItemType HardLink -Path 'C:\Republic\Hunt\Archive\routine.txt' -Target 'C:\Republic\Hunt\Signals\DAWN.txt' | Out-Null
fsutil.exe hardlink list 'C:\Republic\Hunt\Archive\routine.txt'
```

Both paths must be on the same NTFS volume. A normal copy or a .lnk shortcut is not equivalent.

**Organizer solution:** `fsutil hardlink list C:\Republic\Hunt\Archive\routine.txt` reveals the `Signals\DAWN.txt` name. Use the filename stem `DAWN`, not the volume-relative path. Test this command using the event’s participant privilege level.

**Exact challenge answer — accepted only after entry authentication:** `dawn`.

**Success transmission — only after both checks succeed:**
> Alderaan archivist: “The authorization is genuine. The final release still depends on relay circuit 66 on Naboo. Its display label is meaningless; determine the Windows identity recorded in the controller definition.”
>
> Carry token: DAWN.
> Next host: Naboo.
> Next terminal: `C:\Republic\Hunt\Circuit\system66.exe`.
> Next entry password: `feecf4e893ff`.

**Hint:** Hard links are multiple directory entries for the same underlying file; inspect names, not merely matching contents.

### 20 — system66 — Who Does the Machine Trust?

**Host:** Naboo  
**Executable:** `C:\Republic\Hunt\Circuit\system66.exe`

**Entry password — required before showing any briefing:** `feecf4e893ff`. Awarded by the successful `echo.exe` on Alderaan.

**Player briefing — display only after entry password succeeds:**
> Naboo relay circuit 66 has a controller definition at `C:\Republic\Hunt\Circuit\controller.xml`. Inspect the principal's `UserId`. Translate the SID to its Windows account identity, and submit the account portion in lowercase, without the `NT AUTHORITY\` prefix. Do not import or run the task definition. A relay number is not an account name.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create `Circuit\controller.xml`, a saved task definition whose principal is a well-known Windows SID.

**Simple setup — on Naboo unless the block explicitly says DNS server:**

```powershell
New-Item -ItemType Directory -Path 'C:\Republic\Hunt\Circuit' -Force | Out-Null
$dir = 'C:\Republic\Hunt\Circuit'
New-Item -ItemType Directory -Path $dir -Force | Out-Null
@'
<?xml version="1.0" encoding="UTF-8"?>
<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo><Description>Republic relay circuit 66: identity evidence</Description></RegistrationInfo>
  <Triggers />
  <Principals>
    <Principal id="RelayPrincipal">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings><Enabled>false</Enabled></Settings>
  <Actions Context="RelayPrincipal">
    <Exec><Command>cmd.exe</Command><Arguments>/c echo Relay identity fixture</Arguments></Exec>
  </Actions>
</Task>
'@ | Set-Content "$dir\controller.xml" -Encoding UTF8
```

This is a saved XML fixture only. Do not import, register, or execute it. The “66” labels a fictional relay circuit, not an Order 66 event or the challenge’s sequence number. The exercise is identifying LocalSystem from a SID, not obtaining a SYSTEM shell.

**Organizer solution:** Read the XML's principal `UserId`, then translate it:

```powershell
[xml]$definition = Get-Content 'C:\Republic\Hunt\Circuit\controller.xml' -Raw
$sidText = [string]$definition.Task.Principals.Principal.UserId
([System.Security.Principal.SecurityIdentifier]::new($sidText)).Translate([System.Security.Principal.NTAccount]).Value
```

Expected on an English-language host: `NT AUTHORITY\SYSTEM`, SID `S-1-5-18`. Submit `system`. It is distinct from a normal Administrator account, LocalService, and NetworkService. On non-English installations, localize the display explanation while retaining this normalized answer.

**Exact challenge answer — accepted only after entry authentication:** `system`.

**Success transmission — only after both checks succeed:**
> Naboo relay engineer: “LocalSystem. The droids mistook a circuit designation for an access identity. Your verification receipt is NOVA. Alderaan has the four release packets. Assemble them in recorded order and get Rook’s transport home.”
>
> Carry token: NOVA.
> Next host: Alderaan.
> Next terminal: `C:\Republic\Hunt\Control\lastlight.exe`.
> Next entry password: `90149c7d22e1`.

**Hint:** Windows has well-known SIDs. Read the principal identity, not the task description or command arguments.

### 21 — The Last Transmission

**Host:** Alderaan  
**Executable:** `C:\Republic\Hunt\Control\lastlight.exe`

**Entry password — required before showing any briefing:** `90149c7d22e1`. Awarded by the successful `system66.exe` on Naboo.

**Player briefing — display only after entry password succeeds:**
> In `C:\Republic\Hunt\FinalPackets`, order the four `packet-*.txt` files by `LastWriteTimeUtc`, oldest to newest. Each file contains exactly one digit. Join the digits in that order, retaining all four. Combine the result with the previous carry token, separated by a hyphen. This is an offline reconstruction—do not change a clock or transmit a real command.

**Setup files and objects needed:** Compile the checkpoint executable above using the appendix; also create Exactly four `FinalPackets\packet-*.txt` files with fixed UTC last-write times.

**Simple setup — on Alderaan unless the block explicitly says DNS server:**

```powershell
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
```

Set timestamps after final deployment/copying. Keep the checkpoint executable in Control, outside FinalPackets. These are authored puzzle timestamps, not tamper-proof forensic proof.

**Organizer solution:** `Get-ChildItem 'C:\Republic\Hunt\FinalPackets' -Filter 'packet-*.txt' -File | Sort-Object LastWriteTimeUtc`, then read the files in that order. Expected digits are `2714`, not alphabetical filename order.

**Exact challenge answer — accepted only after entry authentication:** `nova-2714`.

**Clone success transmission:**
> KSSSH—Alderaan Control to medical convoy AUREK. Previous evacuation order revoked. Maintain escort formation. Transport Seven, you are cleared to approach.
>
> For a moment, the channel is silent. Then a tired clone answers.
>
> “CT-6116. Rook. We have wounded aboard. Thought you had forgotten us.”
>
> Major Venn takes the comlink. “Not a chance, brother.”
>
> Beyond the viewport, the convoy turns away from the Separatist ambush. Republic fighters close around the damaged transport. For once, the battle is won before the first shot.
>
> OPERATION SHATTERED BEACON COMPLETE. NO BROTHER LEFT BEHIND.

**Droid success transmission:**
> SEPARATIST FORENSIC REPORT ACCEPTED. Republic authentication sequence reconstructed. Cause of operation failure: incomplete destruction of captured communications data; recoverable Windows metadata; clone technician CT-6116 remained operational.
>
> Tactical assessment: enemy unit cohesion exceeded model assumptions.
>
> B1 operator: “So… do we still get a commendation?”
>
> RESPONSE: REDUCED COMMENDATION AUTHORIZED. ROGER, ROGER.


**Completion:** Emit this checkpoint’s scoring flag. There is no next-stage password.

**Hint:** Sort using UTC last-write metadata, then concatenate the file contents. Reading files does not normally change last-write time, but copying/deploying them may, so the organizer must set fixture times after deployment. The preceding system66 checkpoint supplies the carry token NOVA; use nova-2714, not the older draft’s dawn-2714.

## Build appendix — one executable, two separate checks

Use one source file per checkpoint on your organizer build machine. Replace the six string fields below with the exact entry password, challenge answer, briefing, success transmission, carry token, and next destination/entry password from its section. C text containing Windows paths must escape each backslash as `\\`; multiline text uses adjacent quoted strings ending in `\n`. Generate a separate random scoring flag for each checkpoint and put it only in `SUCCESS_TEXT`. For the last checkpoint, omit the next-destination/password text and use the appropriate ending.

The values below implement patio.exe as a worked example. It shows the new control flow and rejects an answer entered at the entry-password prompt. It intentionally uses simple embedded strings like your original program; see the local-binary limitation above. The worked example includes routecache.exe’s actual entry password from the matrix.

```c
#include <stdio.h>
#include <string.h>

static const char ENTRY_PASSWORD[] = "vanguard-k7m4p9";
static const char CHALLENGE_ANSWER[] = "lantern";
static const char BRIEFING[] =
    "Major Venn: Inspect C:\\Republic\\Hunt\\Balcony.\n"
    "The maintenance droid says it is empty. Recover the hidden recognition word.\n"
    "Submit the word in lowercase.\n";
static const char SUCCESS_TEXT[] =
    "The routing configuration was mirrored to Kamino. Follow that record.\n";
static const char CARRY_TOKEN[] = "balcony";
static const char NEXT_DESTINATION[] =
    "Next host: Kamino\n"
    "Next terminal: C:\\Republic\\Hunt\\Comms\\routecache.exe\n"
    "Next entry password: a2c7e62469a9\n";

/* 1 = complete line, 0 = EOF, -1 = overlong line already drained. */
static int read_line(char *buffer, size_t size)
{
    int ch;
    if (!fgets(buffer, (int)size, stdin)) return 0;
    if (!strchr(buffer, '\n') && !feof(stdin)) {
        while ((ch = getchar()) != '\n' && ch != EOF) { }
        return -1;
    }
    buffer[strcspn(buffer, "\r\n")] = '\0';
    return 1;
}

static int prompt_until_match(const char *prompt, const char *expected)
{
    char entered[256];
    int result;
    for (;;) {
        fputs(prompt, stdout);
        fflush(stdout);
        result = read_line(entered, sizeof entered);
        if (result == 0) return 0;
        if (result == 1 && strcmp(entered, expected) == 0) return 1;
        puts("Access denied. Try again.");
    }
}

int main(void)
{
    puts("Republic terminal locked.");
    if (!prompt_until_match("Entry password: ", ENTRY_PASSWORD)) return 0;

    puts("\nIdentity phrase accepted. Mission briefing follows.");
    puts(BRIEFING);
    if (!prompt_until_match("Challenge answer: ", CHALLENGE_ANSWER)) return 0;

    puts("\nEvidence accepted.");
    puts(SUCCESS_TEXT);
    printf("Carry token: %s\n", CARRY_TOKEN);
    puts(NEXT_DESTINATION);
    puts("Press Enter to exit...");
    (void)getchar();
    return 0;
}
```

**How to build:** In a Visual Studio Developer Command Prompt on the build machine, save the customized source as `checkpoint.c`, then run:

```bat
cl /nologo /W4 /TC checkpoint.c /Fe:patio.exe
```

Use the desired non-sequential output name for each challenge, such as `/Fe:system66.exe`. Copy that executable to its section’s host/path. Do not copy `.c`, `.obj`, `.pdb`, an organizer config, or the setup transcript. The two inert `dispatch.exe` evidence props remain as documented in the path-search challenge.

## Scoring and hints

| Category | Count | Blue each | Red each | Blue total | Red total |
|---|---:|---:|---:|---:|---:|
| Ordinary checkpoints, including system66 | 16 | 20 | 10 | 320 | 160 |
| Milestones: receiver, launchwindow, pathfinder, memorybank, lastlight | 5 | 40 | 20 | 200 | 100 |
| **All 21** | **21** | — | — | **520** | **260** |

The prologue is unscored. Generate unpredictable flags per checkpoint; avoid stage-number labels in player-facing flags if you want to conceal the count/order. Record team identity and expected next checkpoint on the scoreboard. Accept credit only after that team’s previous stage and a brief explanation/screenshot of the correct Windows evidence. Do not distinguish factions using a local executable’s claim alone.

First conceptual hint is free after about three minutes. A command-level hint can cost 5 blue / 2 red points on that checkpoint. At seven minutes stuck, offer an organizer bypass for zero points on the stuck checkpoint: mark it skipped in that team’s progress and supply the next path, entry password, carry token, and any essential transmission half. This preserves the route without making later stages impossible. Broken fixtures cost no points.

Blue completion saves the convoy. Red completion reconstructs the failed Separatist operation for an intelligence reward. One team finishing must not lock out the other. No reward for deleting or corrupting hunt fixtures.

## Verification before running the event

- Confirm every host transition in the matrix and every success pointer agree; there are no consecutive checkpoints on the same host.
- For every binary, try its puzzle answer at the entry prompt: it must fail. Try the wrong entry password: no briefing appears. Try the correct entry password: the briefing appears. Try a wrong puzzle answer: no success text or next password appears. Then complete it correctly.
- Close/reopen a checkpoint and confirm the entry gate returns. Check two independent teams do not share an unlock marker.
- Verify each previous success screen gives exactly the next stage’s entry password, including your prologue → patio transition. Preserve MERCY and BEACON across host changes.
- Confirm all 21 executable names and paths; none has a sequence prefix. system66 is intentional. Check the compiler output filename rather than relying on a renamed source file.
- Verify each evidence fixture on its assigned host, especially hidden attributes, NTFS streams, hard links, owner translation, share path/permissions, disabled task/service metadata, and saved event message rendering.
- Add the real DNS server IP and actual trusted SHA-256 digest to their gated briefings. Check DNS from Coruscant. Set final packet timestamps after deployment.
- Stage 21’s answer is now `nova-2714`, because system66 awards NOVA. Do not retain the old `dawn-2714` answer from revision 1.
- Keep organizer scripts and this guide off player machines. Keep a private manifest/backups of the custom hunt objects for restoration/cleanup; remove only the dedicated objects you created.
- Test with the actual account type competitors use. Pilot the full route with five open sessions and measure time. The C gate example was compiled with GCC using strict warnings and exercised for wrong entry, answer-as-entry, overlong entry, wrong answer, and successful completion. The Windows fixture setup blocks and Windows build have not been executed against your hosts.

## Technical references

- Microsoft: [Get-Content and alternate streams](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-5.1).
- Microsoft: [Get-WinEvent](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-5.1).
- Microsoft: [wevtutil export-log](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/wevtutil).
- Microsoft: [Scheduled task principals](https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtaskprincipal).
- Microsoft: [Windows security identifiers](https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/manage/understand-security-identifiers).

The narrative, route, passwords, and scoring are authored for this hunt. system66 is a fictional relay designation; this mission remains in the Clone Wars setting and does not enact Order 66.
