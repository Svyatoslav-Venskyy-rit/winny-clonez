/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "6c8b44f52764";
static const char CHALLENGE_ANSWER[] = "transport-7";
static const char BRIEFING[] = "The four orders in C:\\Republic\\Hunt\\Orders disagree. Compare their SHA-256 hashes with the trusted digest printed below in this briefing. Read the matching file and submit its RescueTarget. Modification time, filename, and Republic letterhead are not enough to establish a match.\nTrusted SHA-256 digest: 26857272E7964FADE24DCC4851B6024EFC50B72E9BC60187CCA5E9530C2842BA\n";
static const char SUCCESS_TEXT[] = "Verified correction: \"Medical convoy AUREK: disregard the evacuation route. Transport Seven carries CT-6116 and wounded personnel.\" Kamino officer: \"Alderaan filed its authorization under two names. Find the surviving link.\"\n\nCarry token: RESCUE\nNext host: Alderaan\nNext terminal: C:\\Republic\\Hunt\\Archive\\echo.exe\nNext entry password: 64b943fe7386";
static const char FLAG[] = "SB{a8bb3b58dfc7c5c9920fa2cb}";

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
