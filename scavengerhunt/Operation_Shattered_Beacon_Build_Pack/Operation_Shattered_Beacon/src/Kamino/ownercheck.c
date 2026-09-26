/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "b5ec655ae633";
static const char CHALLENGE_ANSWER[] = "ct-6116";
static const char BRIEFING[] = "Inspect the owner of C:\\Republic\\Hunt\\Records\\rook-report.txt. Resolve the owner's security identifier to its account name. Submit only the account portion, without the computer or domain prefix.";
static const char SUCCESS_TEXT[] = "Kamino records officer: \"That is Rook's account. The report predates the forged order. He sent a clearance memo to Alderaan, where a classification label convinced everyone to stop reading.\"\n\nCarry token: ROOK\nNext host: Alderaan\nNext terminal: C:\\Republic\\Hunt\\Records\\clearance.exe\nNext entry password: f28188ee9138";
static const char FLAG[] = "SB{4cbefebcd9f2a140d6476b51}";

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
