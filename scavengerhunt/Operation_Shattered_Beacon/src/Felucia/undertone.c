/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "16e79f560e5e";
static const char CHALLENGE_ANSWER[] = "sentinel";
static const char BRIEFING[] = "The Felucia relay copy C:\\Republic\\Hunt\\Balcony\\inspection.txt looks like an ordinary maintenance report. Its last line reads: \"The visible report is for the Senate. The second stream is for my brothers.\" Find the second voice and submit its authentication word.";
static const char SUCCESS_TEXT[] = "Unknown clone: \"The evacuation order is wrong. I split my warning because the droids were reading our dispatches.\" Venn: \"This relay copy points back to the original receive log on Coruscant. Find the last successful packet.\"\n\nCarry token: SENATE\nNext host: Coruscant\nNext terminal: C:\\Republic\\Hunt\\Evidence\\receiver.exe\nNext entry password: 6217fb0a2f5e";
static const char FLAG[] = "SB{1ef30da7bb05bb863281b899}";

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
