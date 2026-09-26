/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "b914579c0e6c";
static const char CHALLENGE_ANSWER[] = "clanker-9036";
static const char BRIEFING[] = "Inspect HKLM\\SOFTWARE\\Republic\\Salvage\\DroidMemory. FragmentBytes is binary data. Interpret its bytes as ASCII to recover four digits. Prefix them with the previous carry token and a hyphen to reassemble the damaged message.";
static const char SUCCESS_TEXT[] = "\"Rook again. Authentication phrase, second half: BEACON. I am alive. I took wounded brothers off Felucia. Coruscant's message was my warning; the evacuation order is the forgery. Join the two words, first half then second, with a hyphen. Ask the Republic directory on Coruscant.\" Venn: \"He was buying them time.\"\n\nCarry token: ALDERAAN\nSave transmission half B: BEACON\nNext host: Coruscant\nNext terminal: C:\\Republic\\Hunt\\Directory\\twinvoice.exe\nNext entry password: 0c40567c1f56";
static const char FLAG[] = "SB{b98f9a98535a07a3a9c08c63}";

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
