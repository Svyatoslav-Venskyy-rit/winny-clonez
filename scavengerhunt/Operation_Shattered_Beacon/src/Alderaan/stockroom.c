/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "62389486780f";
static const char CHALLENGE_ANSWER[] = "transport";
static const char BRIEFING[] = "The logistics share is named RepublicSupply$. Inspect its configuration on Alderaan and find its actual local backing directory. Read dispatch.txt there and recover the shipment category. Do not assume the share name is the folder name.";
static const char SUCCESS_TEXT[] = "Alderaan quartermaster: \"This transport record refers to a Naboo escort that never reported for duty. Its registration survives. Find out what the courier left in that record.\"\n\nCarry token: HANGAR\nNext host: Naboo\nNext terminal: C:\\Republic\\Hunt\\Escort\\watchman.exe\nNext entry password: f1a869b2a61e";
static const char FLAG[] = "SB{201dcfc07bd2734e16a99b20}";

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
