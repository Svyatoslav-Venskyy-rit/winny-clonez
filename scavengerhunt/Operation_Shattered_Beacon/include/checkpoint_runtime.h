#ifndef CHECKPOINT_RUNTIME_H
#define CHECKPOINT_RUNTIME_H
#include <stdio.h>
#include <string.h>
static int read_line(char *buffer, size_t size)
{
    int ch;
    if (!fgets(buffer, (int)size, stdin)) return 0;
    if (!strchr(buffer, '\n') && !feof(stdin)) {
        while ((ch = getchar()) != '\n' && ch != EOF) { }
        return -1;
    }
    buffer[strcspn(buffer, "\r\n")] = '\0';
    return 1;
}
static int prompt_until_match(const char *prompt, const char *expected)
{
    char entered[256];
    int result;
    for (;;) {
        fputs(prompt, stdout);
        fflush(stdout);
        result = read_line(entered, sizeof entered);
        if (result == 0) return 0;
        if (result == 1 && strcmp(entered, expected) == 0) return 1;
        puts("Access denied. Try again.");
    }
}
#endif
