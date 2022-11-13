#include <stdio.h>

void read(char str[], int *size, FILE *stream) {
    *size = 0;
    int ch;
    do {
        ch = fgetc(stream);
        str[(*size)++] = ch;
    } while(ch != -1);
    str[--(*size)] = '\0';
}

void countNumbers(char str[], int size, int numbers_count[]) {
    int i;
    for (i = 0; i < size; ++i) {
        if (str[i] >= '0' && str[i] <= '9') {
            ++numbers_count[str[i] - '0'];
        }
    }
}

int main() {
    char str[10000];
    int size, i;
    read(str, &size, stdin);
    int numbers_count[10];
    countNumbers(str, size, numbers_count);
    for (i = 0; i < 10; ++i) {
        printf("Количество символов %d в тексте равно %d\n", i, numbers_count[i]);
    }
}
