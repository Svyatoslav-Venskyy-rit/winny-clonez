/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "a2c7e62469a9";
static const char CHALLENGE_ANSWER[] = "7341";
static const char BRIEFING[] = "The seal reads REPUBLIC / COMMS / BALCONY. The sender did not leave the route in a document. Search the machine-wide Republic communications settings. Recover the four-digit RouteCode, preserving any leading zeros.";
static const char SUCCESS_TEXT[] = "Kamino records officer: \"Route 7341 belongs to medical logistics. A relay station on Felucia cached the balcony inspection before the sender disappeared. Its final line mentions a second voice.\"\n\nCarry token: WITNESS\nNext host: Felucia\nNext terminal: C:\\Republic\\Hunt\\Relay\\undertone.exe\nNext entry password: 16e79f560e5e";
static const char FLAG[] = "SB{9e398114a77369eda137a806}";

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
