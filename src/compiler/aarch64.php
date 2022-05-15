<?php

namespace igorw\naegleria\aarch64;

function compile($tokens) {
    $condId = 0;
    $loopId = 0;
    $loopStack = [];
    foreach ($tokens as $t) {
        switch ($t['token']) {
            case '>';
                yield ' # >';
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' ldr	w0, [x0]';
                yield ' add	w1, w0, 1';
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' str	w1, [x0]';
                break;
            case '<';
                yield ' # <';
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' ldr	w0, [x0]';
                yield ' sub	w1, w0, #1'; // this line changed
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' str	w1, [x0]';
                break;
            case '+';
                yield ' # +';
                yield ' adrp    x0, i';
                yield ' add     x0, x0, :lo12:i';
                yield ' ldr     w3, [x0]';
                yield ' adrp    x0, tape';
                yield ' add     x0, x0, :lo12:tape';
                yield ' sxtw    x1, w3';
                yield ' ldr     w0, [x0, x1, lsl 2]';
                yield ' add     w2, w0, 1';
                yield ' adrp    x0, tape';
                yield ' add     x0, x0, :lo12:tape';
                yield ' sxtw    x1, w3';
                yield ' str     w2, [x0, x1, lsl 2]';
                break;
            case '-';
                yield ' # -';
                yield ' adrp    x0, i';
                yield ' add     x0, x0, :lo12:i';
                yield ' ldr     w3, [x0]';
                yield ' adrp    x0, tape';
                yield ' add     x0, x0, :lo12:tape';
                yield ' sxtw    x1, w3';
                yield ' ldr     w0, [x0, x1, lsl 2]';
                yield ' sub     w2, w0, #1'; // this line changed
                yield ' adrp    x0, tape';
                yield ' add     x0, x0, :lo12:tape';
                yield ' sxtw    x1, w3';
                yield ' str     w2, [x0, x1, lsl 2]';
                break;
            case '.';
                yield ' # .';
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' ldr	w1, [x0]';
                yield ' adrp	x0, tape';
                yield ' add	x0, x0, :lo12:tape';
                yield ' sxtw	x1, w1';
                yield ' ldr	w0, [x0, x1, lsl 2]';
                yield ' bl	putchar';
                break;
            case ',';
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' ldr	w19, [x0]';
                yield ' bl	getchar';
                yield ' mov	w2, w0';
                yield ' adrp	x0, tape';
                yield ' add	x0, x0, :lo12:tape';
                yield ' sxtw	x1, w19';
                yield ' str	w2, [x0, x1, lsl 2]';
                yield ' mov	w0, 0';
                break;
            case '[';
                $loopId++;
                $loopStack[] = $loopId;
                yield ' # [';
                yield ".loops$loopId:";
                yield ' adrp	x0, i';
                yield ' add	x0, x0, :lo12:i';
                yield ' ldr	w1, [x0]';
                yield ' adrp	x0, tape';
                yield ' add	x0, x0, :lo12:tape';
                yield ' sxtw	x1, w1';
                yield ' ldr	w0, [x0, x1, lsl 2]';
                yield ' cmp	w0, 0';
                yield " beq	.loope$loopId";
                break;
            case ']';
                $endLoopId = array_pop($loopStack);
                yield ' # ]';
                yield " b .loops$endLoopId";
                yield ".loope$endLoopId:";
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
    .arch armv8-a
    .text
    .section	.rodata.str1.8,"aMS",@progbits,1
    .align	3
.LC0:
    .string	"stty -icanon"
    .text
    .align	2
    .global	main
    .type	main, %function
main:
    stp	x29, x30, [sp, -16]!
    mov	x29, sp
    adrp	x0, .LC0
    add	x0, x0, :lo12:.LC0
    bl	system
$asm
    mov	w0, 0
    ldp	x29, x30, [sp], 16
    ret
    .size	main, .-main
    .global	i
    .global	tape
    .bss
    .align	3
    .type	i, %object
    .size	i, 8
i:
    .zero	8
    .type	tape, %object
    .size	tape, 20000
tape:
    .zero	20000

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
