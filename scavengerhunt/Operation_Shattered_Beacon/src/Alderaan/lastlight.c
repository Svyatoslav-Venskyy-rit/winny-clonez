/* Organizer source: do not distribute source to players. */
#include "checkpoint_runtime.h"
static const char ENTRY_PASSWORD[] = "90149c7d22e1";
static const char CHALLENGE_ANSWER[] = "nova-2714";
static const char BRIEFING[] = "In C:\\Republic\\Hunt\\FinalPackets, order the four packet-*.txt files by LastWriteTimeUtc, oldest to newest. Each file contains exactly one digit. Join the digits in that order, retaining all four. Combine the result with the previous carry token, separated by a hyphen. This is an offline reconstruction - do not change a clock or transmit a real command.";
static const char SUCCESS_TEXT[] = "KSSSH - Alderaan Control to medical convoy AUREK. Previous evacuation order revoked. Maintain escort formation. Transport Seven, you are cleared to approach.\n\nFor a moment, the channel is silent. Then a tired clone answers.\n\n\"CT-6116. Rook. We have wounded aboard. Thought you had forgotten us.\"\n\nMajor Venn takes the comlink. \"Not a chance, brother.\"\n\nBeyond the viewport, the convoy turns away from the Separatist ambush. Republic fighters close around the damaged transport. For once, the battle is won before the first shot.\n\nOPERATION SHATTERED BEACON COMPLETE. NO BROTHER LEFT BEHIND.";
static const char DROID_ENDING[] = "SEPARATIST FORENSIC REPORT ACCEPTED. Republic authentication sequence reconstructed. Cause of operation failure: incomplete destruction of captured communications data; recoverable Windows metadata; clone technician CT-6116 remained operational.\n\nTactical assessment: enemy unit cohesion exceeded model assumptions.\n\nB1 operator: \"So... do we still get a commendation?\"\n\nRESPONSE: REDUCED COMMENDATION AUTHORIZED. ROGER, ROGER.";
static const char FLAG[] = "SB{73688da624064098bf450496}";

int main(int argc, char **argv)
{
    puts("Republic terminal locked.");
    if (!prompt_until_match("Entry password: ", ENTRY_PASSWORD)) return 0;
    puts("\nEntry phrase accepted. Mission briefing follows.");
    puts(BRIEFING);
    if (!prompt_until_match("Challenge answer: ", CHALLENGE_ANSWER)) return 0;
    puts("\nEvidence accepted.");
    if (argc > 1 && strcmp(argv[1], "--droid") == 0) puts(DROID_ENDING);
    else puts(SUCCESS_TEXT);
    printf("Scoring flag: %s\n", FLAG);
    puts("Press Enter to exit...");
    (void)getchar();
    return 0;
}
