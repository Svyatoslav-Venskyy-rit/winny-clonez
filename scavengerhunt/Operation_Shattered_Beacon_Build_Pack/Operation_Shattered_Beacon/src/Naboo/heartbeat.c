/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "acb34e839938";
static const char CHALLENGE_ANSWER[] = "9771";
static const char BRIEFING[] = "Naboo analysts received wreck snapshots named connections.csv and processes.csv in C:\\Republic\\Hunt\\Wreck. These are records from the same captured instant, not the current host state. Find the connection to documentation address 192.0.2.77, remote port 7443. Match its owning PID to the process snapshot and recover BeaconCode from that process's command line.";
static const char SUCCESS_TEXT[] = "Naboo analyst: \"The matching process carried an encoded command. Its preserved command line is with the Alderaan analysis desk. Decode it; do not execute it.\"\n\nCarry token: SIGNAL\nNext host: Alderaan\nNext terminal: C:\\Republic\\Hunt\\Analysis\\coldmemory.exe\nNext entry password: 5f2629e19bb3";
static const char FLAG[] = "SB{b791efacfbdbcb7ca989725f}";

int main(void)
{
    puts("Republic terminal locked.");
    if (!prompt_until_match("Entry password: ", ENTRY_PASSWORD)) return 0;
    puts("\nEntry phrase accepted. Mission briefing follows.");
    puts(BRIEFING);
    if (!prompt_until_match("Challenge answer: ", CHALLENGE_ANSWER)) return 0;
    puts("\nEvidence accepted.");
    puts(SUCCESS_TEXT);
    printf("Scoring flag: %s\n", FLAG);
    puts("Press Enter to exit...");
    (void)getchar();
    return 0;
}
