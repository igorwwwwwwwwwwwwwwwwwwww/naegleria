    .arch armv8-a
    .file	"main.c"
    .text
    .global	tape
    .bss
    .align	3
    .type	tape, %object
    .size	tape, 20000
tape:
    .zero	20000
    .global	i
    .align	2
    .type	i, %object
    .size	i, 4
i:
    .zero	4
    .section	.rodata
    .align	3
.LC0:
    .string	"stty -icanon"
    .text
    .align	2
    .global	main
    .type	main, %function
main:
.LFB6:
    .cfi_startproc
    stp	x29, x30, [sp, -16]!
    .cfi_def_cfa_offset 16
    .cfi_offset 29, -16
    .cfi_offset 30, -8
    mov	x29, sp
    adrp	x0, .LC0
    add	x0, x0, :lo12:.LC0
    bl	system
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # [
.loops1:
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 cmp	w0, 0
 beq	.loope1
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # [
.loops2:
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 cmp	w0, 0
 beq	.loope2
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # ]
 b .loops2
.loope2:
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # [
.loops3:
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 cmp	w0, 0
 beq	.loope3
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # ]
 b .loops3
.loope3:
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # ]
 b .loops1
.loope1:
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # <
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 sub	w1, w0, #1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # -
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 sub     w2, w0, #1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar
 # >
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w0, [x0]
 add	w1, w0, 1
 adrp	x0, i
 add	x0, x0, :lo12:i
 str	w1, [x0]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # +
 adrp    x0, i
 add     x0, x0, :lo12:i
 ldr     w3, [x0]
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 ldr     w0, [x0, x1, lsl 2]
 add     w2, w0, 1
 adrp    x0, tape
 add     x0, x0, :lo12:tape
 sxtw    x1, w3
 str     w2, [x0, x1, lsl 2]
 # .
 adrp	x0, i
 add	x0, x0, :lo12:i
 ldr	w1, [x0]
 adrp	x0, tape
 add	x0, x0, :lo12:tape
 sxtw	x1, w1
 ldr	w0, [x0, x1, lsl 2]
 bl	putchar

    mov	w0, 0
    ldp	x29, x30, [sp], 16
    .cfi_restore 30
    .cfi_restore 29
    .cfi_def_cfa_offset 0
    ret
    .cfi_endproc
.LFE6:
    .size	main, .-main
    .ident	"GCC: (GNU) 10.3.0"
    .section	.note.GNU-stack,"",@progbits