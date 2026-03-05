<?php

namespace igorw\naegleria\riscv;

function compile($tokens) {
    $condId = 0;
    $loopId = 0;
    $loopStack = [];
    foreach ($tokens as $t) {
        switch ($t['token']) {
            case '>':
                yield ' # >';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' addi    t1, t1, 1';
                yield ' sw      t1, 0(t0)';
                break;
            case '<':
                yield ' # <';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' addi    t1, t1, -1';
                yield ' sw      t1, 0(t0)';
                break;
            case '+':
                yield ' # +';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' la      t2, tape';
                yield ' add     t2, t2, t1';
                yield ' lbu     t3, 0(t2)';
                yield ' addi    t3, t3, 1';
                yield ' sb      t3, 0(t2)';
                break;
            case '-':
                yield ' # -';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' la      t2, tape';
                yield ' add     t2, t2, t1';
                yield ' lbu     t3, 0(t2)';
                yield ' addi    t3, t3, -1';
                yield ' sb      t3, 0(t2)';
                break;
            case '.':
                yield ' # .';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' la      t2, tape';
                yield ' add     t2, t2, t1';
                yield ' lbu     a0, 0(t2)';
                yield ' call    bf_putchar';
                break;
            case ',':
                $condId++;
                yield ' # ,';
                yield ' call    bf_getchar';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' la      t2, tape';
                yield ' add     t2, t2, t1';
                yield ' sb      a0, 0(t2)';
                yield ' li      t4, 4';
                yield ' bne     a0, t4, .cond'.$condId;
                yield ' sb      zero, 0(t2)';
                yield '.cond'.$condId.':';
                break;
            case '[':
                $loopId++;
                $loopStack[] = $loopId;
                yield ' # [';
                yield '.loops'.$loopId.':';
                yield ' la      t0, i';
                yield ' lw      t1, 0(t0)';
                yield ' la      t2, tape';
                yield ' add     t2, t2, t1';
                yield ' lbu     t3, 0(t2)';
                yield ' beqz    t3, .loope'.$loopId;
                break;
            case ']':
                $endLoopId = array_pop($loopStack);
                yield ' # ]';
                yield ' j       .loops'.$endLoopId;
                yield '.loope'.$endLoopId.':';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
    .section .text
    .align  2
    .global bf_main
    .type   bf_main, @function
bf_main:
    addi    sp, sp, -16
    sw      ra, 12(sp)
$asm
    li      a0, 0
    lw      ra, 12(sp)
    addi    sp, sp, 16
    ret
    .size   bf_main, .-bf_main

    .section .bss
    .align  4
    .global i
    .type   i, @object
    .size   i, 4
i:
    .zero   4

    .align  4
    .global tape
    .type   tape, @object
    .size   tape, 4000
tape:
    .zero   4000

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
