/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "f1a869b2a61e";
static const char CHALLENGE_ANSWER[] = "holdfast";
static const char BRIEFING[] = "Inspect the Windows service named RepublicEscort. Recover the extraction word in its description. The escort may be stopped. Do not start it: the service record is the evidence.";
static const char SUCCESS_TEXT[] = "Reed: \"CT-6116 is a technician from Kamino. His brothers call him Rook. I sent his launch schedule back to the cloning facility. The request was disabled, but its instructions should still be there.\"\n\nCarry token: MARSH\nNext host: Kamino\nNext terminal: C:\\Republic\\Hunt\\Flight\\launchwindow.exe\nNext entry password: cbc06ca86f8a";
static const char FLAG[] = "SB{bf9df0574c7362205a8131ec}";

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
