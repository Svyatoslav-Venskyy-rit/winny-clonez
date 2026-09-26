/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "d1aa9f07a324";
static const char CHALLENGE_ANSWER[] = "reed";
static const char BRIEFING[] = "Naboo's landing officer hands you a shortcut labeled \"Courier Departure.\" He swears the courier vanished through it. Inspect C:\\Republic\\Hunt\\Courier\\Departure.lnk without launching it. The real destination is less interesting than the courier's callsign in its arguments.";
static const char SUCCESS_TEXT[] = "Reed's note: \"Droids were waiting at my departure gate. Someone had the flight plan before I filed it. I sent the dispatch ahead to the supply depot on Alderaan. Follow the share, not the label.\"\n\nCarry token: PILOT\nNext host: Alderaan\nNext terminal: C:\\Republic\\Hunt\\Depot\\stockroom.exe\nNext entry password: 62389486780f";
static const char FLAG[] = "SB{87d158b784ea43a80e728be3}";

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
