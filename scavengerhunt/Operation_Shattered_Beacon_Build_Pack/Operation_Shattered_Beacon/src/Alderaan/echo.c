/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "64b943fe7386";
static const char CHALLENGE_ANSWER[] = "dawn";
static const char BRIEFING[] = "Inspect C:\\Republic\\Hunt\\Archive\\routine.txt. The archivist says this is a second name for an existing file, not a copied file and not a shortcut. Enumerate its NTFS hard links. The other filename's stem is the authorization word. Submit it in lowercase.";
static const char SUCCESS_TEXT[] = "Alderaan archivist: \"The authorization is genuine. The final release still depends on relay circuit 66 on Naboo. Its display label is meaningless; determine the Windows identity recorded in the controller definition.\"\n\nCarry token: DAWN\nNext host: Naboo\nNext terminal: C:\\Republic\\Hunt\\Circuit\\system66.exe\nNext entry password: feecf4e893ff";
static const char FLAG[] = "SB{6c84089a3d74486dbb8b65d5}";

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
