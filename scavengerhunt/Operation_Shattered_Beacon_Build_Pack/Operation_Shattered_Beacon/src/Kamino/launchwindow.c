/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "cbc06ca86f8a";
static const char CHALLENGE_ANSWER[] = "marsh-2187";
static const char BRIEFING[] = "Inspect the disabled task MidnightLaunch in Task Scheduler's \\Republic\\ folder. Read the action arguments and recover LaunchCode. Do not run the task. Submit the previous carry token followed by a hyphen and the launch code.";
static const char SUCCESS_TEXT[] = "Kamino flight controller: \"The launch would have supplied Felucia's weather relay. Rook hid a rendezvous word in that station's machine environment. Visit the relay, then bring its receipt back here.\"\n\nCarry token: RAINFALL\nNext host: Felucia\nNext terminal: C:\\Republic\\Hunt\\Weather\\atmosphere.exe\nNext entry password: 767b3c73489d";
static const char FLAG[] = "SB{9d94c713b7dfd1073423d1e6}";

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
