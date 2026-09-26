/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "6217fb0a2f5e";
static const char CHALLENGE_ANSWER[] = "senate-0427";
static const char BRIEFING[] = "Open C:\\Republic\\Hunt\\Evidence\\balcony.evtx. For provider RepublicComms, find the newest Event ID 4101 whose message says Result=RECEIVED. Extract PacketCode. Enter the previous checkpoint's carry token, a hyphen, then this code. Failed receptions are not valid packets.";
static const char SUCCESS_TEXT[] = "\"This is CT-6116. Medical convoy AUREK is being redirected. The Senate order has been substituted. Authentication phrase, first half: MERCY. Preserve it. My courier reached Naboo. If command brands me a deserter, ask why a deserter would transmit his own number.\" Venn: \"Find that courier.\"\n\nCarry token: RIVER\nSave transmission half A: MERCY\nNext host: Naboo\nNext terminal: C:\\Republic\\Hunt\\Courier\\departure.exe\nNext entry password: d1aa9f07a324";
static const char FLAG[] = "SB{ad8f9b2faf145f97f8cdfa35}";

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
