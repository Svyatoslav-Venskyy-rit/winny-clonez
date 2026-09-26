/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "f28188ee9138";
static const char CHALLENGE_ANSWER[] = "brother";
static const char BRIEFING[] = "C:\\Republic\\Hunt\\Records\\clearance.txt begins with \"TOP SECRET - ACCESS DENIED.\" Is that statement true? Inspect its ACL and read the file using your current authorized account. Submit its brotherhood word. Your report must explain why the file is readable.";
static const char SUCCESS_TEXT[] = "Rook: \"They stamped the substitute order with every clearance word they knew. A label is not authority. Coruscant's dispatch archive has two utilities with the same name. Find which one the launch path would select.\"\n\nCarry token: BROTHER\nNext host: Coruscant\nNext terminal: C:\\Republic\\Hunt\\Dispatch\\pathfinder.exe\nNext entry password: b18b3a8611aa";
static const char FLAG[] = "SB{adb70688bdabca600a64af10}";

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
