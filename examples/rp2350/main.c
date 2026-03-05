#include <stdio.h>

#include "pico/stdlib.h"
#include "pico/stdio_usb.h"

int bf_main(void);

int bf_putchar(int c) {
    return putchar(c);
}

int bf_getchar(void) {
    int c;
    do {
        c = getchar_timeout_us(1000);
    } while (c < 0);
    return c;
}

int main(void) {
    stdio_init_all();
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stdin, NULL, _IONBF, 0);

    // Give USB CDC time to enumerate so interactive stdin works reliably.
    for (int i = 0; i < 30000; i++) {
        if (stdio_usb_connected()) {
            break;
        }
        sleep_ms(1);
    }

    return bf_main();
}
