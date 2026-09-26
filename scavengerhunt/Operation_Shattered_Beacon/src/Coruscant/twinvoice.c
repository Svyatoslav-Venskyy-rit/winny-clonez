/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
#include "hunt_config.h"
static const char ENTRY_PASSWORD[] = "0c40567c1f56";
static const char CHALLENGE_ANSWER[] = "mercy-beacon-anchor";
static const char BRIEFING[] = "Retrieve the two saved transmission halves: Coruscant first, Felucia second. Join them with a hyphen and lowercase the result. Query the TXT record at <joined-phrase>.hunt." HUNT_DOMAIN " from Coruscant using the supplied Republic DNS server address. Submit <joined-phrase>-<TXT-word>. An A-record lookup alone will not answer this question.\nRepublic DNS server: " HUNT_DNS_SERVER "\n";
static const char SUCCESS_TEXT[] = "Coruscant directory relay: \"Two-part authentication accepted. Kamino retains several copies of the evacuation order and an independently trusted digest. Find the genuine correction before the convoy follows the wrong coordinates.\"\n\nCarry token: COUNCIL\nNext host: Kamino\nNext terminal: C:\\Republic\\Hunt\\Orders\\checksum.exe\nNext entry password: 6c8b44f52764";
static const char FLAG[] = "SB{4b594ed054dd9395e9b8b060}";

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
