/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "b18b3a8611aa";
static const char CHALLENGE_ANSWER[] = "brother-5502";
static const char BRIEFING[] = "This fixture recreates the droids' dispatch search. The command is exactly dispatch.exe. It exists nowhere in the launch directory. The search path is exactly C:\\Republic\\Hunt\\Vendor;C:\\Republic\\Hunt\\Trusted. Determine which candidate is found first and read that candidate's adjacent dispatch-code.txt. Do not run either candidate. Combine its code with the previous carry token.";
static const char SUCCESS_TEXT[] = "Venn: \"The first dispatch candidate was the substitute. Its route points to a tactical droid destroyed on Felucia. The recovery team has a sensor image that refuses to open. Find out what it really is.\"\n\nCarry token: SPORE\nNext host: Felucia\nNext terminal: C:\\Republic\\Hunt\\Wreck\\camouflage.exe\nNext entry password: 63ac4790a278";
static const char FLAG[] = "SB{de2450a4d1c3335ad9f5bb39}";

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
