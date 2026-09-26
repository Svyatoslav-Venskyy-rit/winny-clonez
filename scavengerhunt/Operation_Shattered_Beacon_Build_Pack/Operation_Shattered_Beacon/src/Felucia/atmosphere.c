/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "767b3c73489d";
static const char CHALLENGE_ANSWER[] = "rain";
static const char BRIEFING[] = "Felucia's weather terminal reads: \"A process inherits its atmosphere when it begins.\" Recover the machine-scoped environment variable REPUBLIC_WEATHER. A value from only your current shell is not sufficient evidence.";
static const char SUCCESS_TEXT[] = "Felucia relay operator: \"Rook passed this station before the fighting. We retained his weather word, but Kamino still holds his original report. Check the owner identity - anyone can type a clone number inside a document.\"\n\nCarry token: CADET\nNext host: Kamino\nNext terminal: C:\\Republic\\Hunt\\Records\\ownercheck.exe\nNext entry password: b5ec655ae633";
static const char FLAG[] = "SB{8c49ce201809ef89748bc876}";

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
