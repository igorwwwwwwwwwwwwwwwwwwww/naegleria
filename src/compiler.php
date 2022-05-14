<?php

namespace igorw\naegleria;

function tokenize($code) {
    $tokens = str_split($code);
    $tokens = array_values(array_filter($tokens, function ($token) {
        return in_array($token, ['>', '<', '+', '-', '.', ',', '[', ']'], true);
    }));
    return $tokens;
}

function compile($tokens) {
    $condId = 0;
    $loopId = 0;
    $loopStack = [];
    foreach ($tokens as $token) {
        switch ($token) {
            case '>';
                yield '        ;; >';
                yield '        (local.get 0)';
                yield '        i32.const 1';
                yield '        i32.add';
                yield '        (local.set 0)';
                break;
            case '<';
                yield '        ;; <';
                yield '        (local.get 0)';
                yield '        i32.const 1';
                yield '        i32.sub';
                yield '        (local.set 0)';
                break;
            case '+';
                yield '        ;; +';
                yield '        (local.get 0)';
                yield '        (local.get 0)';
                yield '        i32.load';
                yield '        i32.const 1';
                yield '        i32.add';
                yield '        i32.store';
                break;
            case '-';
                yield '        ;; -';
                yield '        (local.get 0)';
                yield '        (local.get 0)';
                yield '        i32.load';
                yield '        i32.const 1';
                yield '        i32.sub';
                yield '        i32.store';
                break;
            case '.';
                yield '        ;; .';
                yield '        (i32.store (i32.const 0) (local.get 0))  ;; iov.iov_base';
                yield '        (i32.store (i32.const 4) (i32.const 1))   ;; iov.iov_len';
                yield '        (call $fd_write';
                yield '            (i32.const 1) ;; file_descriptor - 1 for stdout';
                yield '            (i32.const 0) ;; *iovs';
                yield '            (i32.const 1) ;; iovs_len';
                yield '            (i32.const 20) ;; nwritten';
                yield '        )';
                yield '        drop';
                break;
            case ',';
                yield '        ;; ,';
                // TBD
                break;
            case '[';
                $loopId++;
                $loopStack[] = $loopId;
                yield '        ;; [';
                yield "        (block \$loope$loopId";
                yield "        (loop \$loops$loopId";
                // if val == 0, break
                yield '        (local.get 0)';
                yield '        i32.load';
                yield '        i32.eqz';
                yield '        (if (then';
                yield "          br \$loope$loopId";
                yield '        ))';
                break;
            case ']';
                $endLoopId = array_pop($loopStack);
                yield '        ;; ]';
                yield "        br \$loops$endLoopId";
                yield '        )';
                yield '        )';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
(module
    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
    (memory 1)
    (export "memory" (memory 0))
    (data (i32.const 8) "") ;; tape begins at offset 8
    (func $main (export "_start")
        (local i32)
        (local.set 0 (i32.const 8))
$asm
    )
)

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
