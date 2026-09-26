/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "5f2629e19bb3";
static const char CHALLENGE_ANSWER[] = "clanker";
static const char BRIEFING[] = "Read C:\\Republic\\Hunt\\Wreck\\last-command.txt. It contains a powershell.exe -EncodedCommand record. Recover its plaintext without running it, and submit the recovered word. The droids did not use ordinary UTF-8 text here.";
static const char SUCCESS_TEXT[] = "Droid memory: \"UNIT DESIGNATION: CLANKER. ORGANIC AUTHENTICATION FRAGMENT RETAINED. FALLBACK STORAGE: FELUCIA SALVAGE REGISTRY.\" Analyst: \"Back to the wreck. That fallback may hold the missing half.\"\n\nCarry token: CLANKER\nNext host: Felucia\nNext terminal: C:\\Republic\\Hunt\\Salvage\\memorybank.exe\nNext entry password: b914579c0e6c";
static const char FLAG[] = "SB{a245bb2291c6d57a4bca1bf6}";

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
