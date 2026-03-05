#include <stdio.h>

#include "pico/stdlib.h"

int bf_main(void);

int bf_putchar(int c) {
    return putchar(c);
}

int bf_getchar(void) {
    return getchar();
}

int main(void) {
    stdio_init_all();
    sleep_ms(1200);
    return bf_main();
}
