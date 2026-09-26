/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "feecf4e893ff";
static const char CHALLENGE_ANSWER[] = "system";
static const char BRIEFING[] = "Naboo relay circuit 66 has a controller definition at C:\\Republic\\Hunt\\Circuit\\controller.xml. Inspect the principal's UserId. Translate the SID to its Windows account identity, and submit the account portion in lowercase, without the NT AUTHORITY\\ prefix. Do not import or run the task definition. A relay number is not an account name.";
static const char SUCCESS_TEXT[] = "Naboo relay engineer: \"LocalSystem. The droids mistook a circuit designation for an access identity. Your verification receipt is NOVA. Alderaan has the four release packets. Assemble them in recorded order and get Rook's transport home.\"\n\nCarry token: NOVA\nNext host: Alderaan\nNext terminal: C:\\Republic\\Hunt\\Control\\lastlight.exe\nNext entry password: 90149c7d22e1";
static const char FLAG[] = "SB{3774abf70fe6bb7a24ec81db}";

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
