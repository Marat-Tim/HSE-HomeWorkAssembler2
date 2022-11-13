#include <stdio.h>

int main() {
    char str[10000];
    int size, i;
    read(str, &size, stdin);
    int numbers_count[10];
    countNumbers(str, size, numbers_count);
    for (i = 0; i < 10; ++i) {
        printf("Count of \"%d\": %d\n", i, numbers_count[i]);
    }
}
