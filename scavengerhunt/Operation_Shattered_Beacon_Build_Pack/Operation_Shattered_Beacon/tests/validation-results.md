# Validation results

Validated on 2026-09-26 in the available Linux execution environment.

- All 21 checkpoint C sources compiled with GCC using `-std=c11 -Wall -Wextra -Werror`.
- 190 runtime scenarios passed: wrong entry, puzzle answer entered as entry, overlong entry, empty input/EOF, correct entry without completion, wrong puzzle answer, successful completion, a new locked process after restart, CRLF input, and the alternate final droid ending.
- Every success output matched the next stage's exact path and entry password, without sentence punctuation attached to either field.
- All 20 transitions change hosts; distribution is four checkpoints on Coruscant, Kamino, Felucia, and Naboo, and five on Alderaan.
- All 21 scoring flags are unique. Blue totals 520; red totals 260.
- The trusted digest in checksum.c is SHA-256 of the exact ASCII bytes `RescueTarget=TRANSPORT-7\r\n`. The checksum setup writes these bytes explicitly and verifies that digest before completing.

The portable tests supply documentation-only DNS address 192.0.2.53 via a compiler define. It is not an event default. Build.ps1 requires your actual DNS server address and embeds it in the Windows build.

Not executed here: MSVC/Windows compilation, PowerShell provisioning scripts, event-log export/message rendering, service/task registration, SMB access, account-owner assignment, actual DNS resolution, or Windows/NTFS fixture behavior. Run a Windows lab pilot with the real participant account before the event. This pack does not include precompiled Windows binaries or a scoreboard service.

To repeat the portable C tests on a machine with Python 3 and GCC:

```bash
python3 tests/test_gates.py
```
