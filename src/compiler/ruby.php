<?php

namespace igorw\naegleria\ruby;

function compile($tokens) {
    foreach ($tokens as $t) {
        switch ($t['token']) {
            case '>':
                yield 'i += 1                    # >';
                break;
            case '<':
                yield 'i -= 1                    # >';
                break;
            case '+':
                yield 'tape[i] += 1              # +';
                break;
            case '-':
                yield 'tape[i] -= 1              # -';
                break;
            case '.':
                yield 'print tape[i].chr         # .';
                break;
            case ',':
                yield 'char = IO.getch           # ,';
                yield 'tape[i] = (char == "\x04") ? 0 : char.ord;';
                break;
            case '[':
                yield 'while tape[i] != 0        # [';
                break;
            case ']':
                yield 'end # ]';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
require 'io/console'

tape = Array.new(4000, 0)
i = 0

$asm

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
