/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "vanguard-k7m4p9";
static const char CHALLENGE_ANSWER[] = "lantern";
static const char BRIEFING[] = "KSSSH - Major Venn here. Welcome to Coruscant, trooper. We found the transmitter under the Senate balcony. The maintenance droid insists this directory is empty. Convenient. Inspect C:\\Republic\\Hunt\\Balcony and recover the technician's recognition word. Remember: what a console chooses to show is not everything the disk holds. Submit the word in lowercase.";
static const char SUCCESS_TEXT[] = "Venn: \"Good eyes. The maintenance note says the transmitter's routing configuration was mirrored to Kamino. Follow that record. Whoever left this wanted a clone who would check the evidence.\"\n\nCarry token: BALCONY\nNext host: Kamino\nNext terminal: C:\\Republic\\Hunt\\Comms\\routecache.exe\nNext entry password: a2c7e62469a9";
static const char FLAG[] = "SB{690751ded03cd673b14da08d}";

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
