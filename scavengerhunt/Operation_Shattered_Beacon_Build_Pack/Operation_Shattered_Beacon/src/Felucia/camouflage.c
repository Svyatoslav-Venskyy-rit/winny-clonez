/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "63ac4790a278";
static const char CHALLENGE_ANSWER[] = "violet";
static const char BRIEFING[] = "The wreck recovery folder contains C:\\Republic\\Hunt\\Wreck\\sensor-image.jpg. It will not open as a photograph. Inspect its first bytes and identify the actual container. Extract a copy with the appropriate tool and recover the salvage word.";
static const char SUCCESS_TEXT[] = "Recovery trooper: \"That was a collection bundle, not a photograph. We forwarded its connection and process snapshots to Naboo for correlation. Find the process behind the droid's last transmission.\"\n\nCarry token: WRECK\nNext host: Naboo\nNext terminal: C:\\Republic\\Hunt\\Telemetry\\heartbeat.exe\nNext entry password: acb34e839938";
static const char FLAG[] = "SB{e0c56910d6a28ff19a653841}";

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
