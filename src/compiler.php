<?php

namespace igorw\naegleria;

function tokenize($code) {
    $tokens = str_split($code);
    $tokens = array_values(array_filter($tokens, function ($token) {
        return in_array($token, ['>', '<', '+', '-', '.', ',', '[', ']', '!'], true);
    }));
    return $tokens;
}

function compile($tokens) {
    $condId = 0;
    $loopId = 0;
    $loopStack = [];
    foreach ($tokens as $token) {
        // yield '        ;; debug log';
        // yield '        (i32.store (i32.const 12) (i32.const '.ord($token).'))';
        // yield '        (i32.store (i32.const 0) (i32.const 12))  ;; iov.iov_base';
        // yield '        (i32.store (i32.const 4) (i32.const 1))   ;; iov.iov_len';
        // yield '        (call $fd_write';
        // yield '            (i32.const 2) ;; file_descriptor - 2 for stderr';
        // yield '            (i32.const 0) ;; *iovs';
        // yield '            (i32.const 1) ;; iovs_len';
        // yield '            (i32.const 8) ;; nwritten';
        // yield '        )';
        // yield '        drop';

        switch ($token) {
            case '>';
                yield '        ;; >';
                yield '        (local.set 0 (i32.add (local.get 0) (i32.const 1)))';
                break;
            case '<';
                yield '        ;; <';
                yield '        (local.set 0 (i32.sub (local.get 0) (i32.const 1)))';
                break;
            case '+';
                yield '        ;; +';
                yield '        (i32.store (local.get 0) (i32.add (i32.load (local.get 0)) (i32.const 1)))';
                break;
            case '-';
                yield '        ;; -';
                yield '        (i32.store (local.get 0) (i32.sub (i32.load (local.get 0)) (i32.const 1)))';
                break;
            case '.';
                yield '        ;; .';
                yield '        (i32.store (i32.const 0) (local.get 0))  ;; iov.iov_base';
                yield '        (i32.store (i32.const 4) (i32.const 1))  ;; iov.iov_len';
                yield '        (call $fd_write';
                yield '            (i32.const 1) ;; file_descriptor - 1 for stdout';
                yield '            (i32.const 0) ;; *iovs';
                yield '            (i32.const 1) ;; iovs_len';
                yield '            (i32.const 8) ;; nwritten';
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
                yield '        (i32.eqz (i32.load (local.get 0)))';
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
            case '!';
                yield '        ;; !';
                yield '        (call $proc_exit (i32.const 2))';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
(module
    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
    (import "wasi_unstable" "proc_exit" (func $proc_exit (param i32)))
    (memory 1)
    (export "memory" (memory 0))
    ;; memory layout
    ;; 00 iov.iov_base iov.iov_len
    ;; 08 nwritten token
    ;; 16 tape
    (func $main (export "_start")
        (local i32) ;; i
        (local.set 0 (i32.const 16))
$asm
    )
)

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
