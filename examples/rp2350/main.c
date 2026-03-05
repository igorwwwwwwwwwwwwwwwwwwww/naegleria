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
#ifdef BF_STDIO_UNBUFFERED
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
#else
    setvbuf(stdout, NULL, _IOLBF, 0);
    setvbuf(stderr, NULL, _IOLBF, 0);
#endif
    setvbuf(stdin, NULL, _IONBF, 0);

    // Give USB CDC time to enumerate so interactive stdin works reliably.
    for (int i = 0; i < 30000; i++) {
        if (stdio_usb_connected()) {
            break;
        }
        sleep_ms(1);
    }

    #ifdef BF_ENABLE_TIMING
    absolute_time_t start = get_absolute_time();
    int rc = bf_main();
    int64_t elapsed_us = absolute_time_diff_us(start, get_absolute_time());
    printf("\n[naegleria] bf_main=%d elapsed=%lld us (%.3f ms)\n",
           rc, (long long) elapsed_us, (double) elapsed_us / 1000.0);
    return rc;
    #else
    return bf_main();
    #endif
}
