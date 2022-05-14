<?php

namespace igorw\naegleria;

function tokenize($code) {
    $tokens = [];

    $lines = explode("\n", $code);
    foreach ($lines as $i => $line) {
        $chars = str_split($code);
        foreach ($chars as $j => $char) {
            if (in_array($char, ['>', '<', '+', '-', '.', ',', '[', ']', '!'], true)) {
                $tokens[] = [
                    'token'     => $char,
                    'line'      => $i+1,
                    'column'    => $j+1,
                ];
            }
        }
    }

    return $tokens;
}

function compile($tokens) {
    $condId = 0;
    $loopId = 0;
    $loopStack = [];
    foreach ($tokens as $t) {
        yield '        (call $debug (local.get 0) (i32.const '.ord($t['token']).') (i32.const '.$t['line'].') (i32.const '.$t['column'].'))';

        switch ($t['token']) {
            case '>';
                yield '        (local.set 0 (i32.add (local.get 0) (i32.const 1)))                         ;; >';
                break;
            case '<';
                yield '        (local.set 0 (i32.sub (local.get 0) (i32.const 1)))                         ;; <';
                break;
            case '+';
                yield '        (i32.store (local.get 0) (i32.add (i32.load (local.get 0)) (i32.const 1)))  ;; +';
                break;
            case '-';
                yield '        (i32.store (local.get 0) (i32.sub (i32.load (local.get 0)) (i32.const 1)))  ;; -';
                break;
            case '.';
                yield '        (call $putchar (local.get 0))                                               ;; .';
                break;
            case ',';
                yield '        (call $getchar (local.get 0))                                               ;; ,';
                break;
            case '[';
                $loopId++;
                $loopStack[] = $loopId;
                yield "        (block \$loope$loopId                                                              ;; [";
                yield "          (loop \$loops$loopId";
                yield '            (i32.eqz (i32.load (local.get 0)))';
                yield "            (if (then br \$loope$loopId))";
                break;
            case ']';
                $endLoopId = array_pop($loopStack);
                yield "            br \$loops$endLoopId                                                              ;; ]";
                yield '        ))';
                break;
            case '!';
                yield '        (call $proc_exit (i32.const 2))                                             ;; !';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
(module
    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
    (import "wasi_unstable" "fd_read" (func $fd_read (param i32 i32 i32 i32) (result i32)))
    (import "wasi_unstable" "proc_exit" (func $proc_exit (param i32)))
    ;; memory layout
    ;; 00 iov.iov_base iov.iov_len
    ;; 08 nwritten token
    ;; 16 tape
    (memory 1)
    (export "memory" (memory 0))
    ;; debug format
    ;; 00 op i tape[i] 0
    ;; 16 0000
    ;; 32 tape[0..3]
    ;; 48 tape[4..7]
    (func $debug (param i32 i32 i32 i32)
        (i32.store (i32.const 12) (local.get 1))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (local.get 0))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (local.get 0)))  (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.const 0))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (local.get 2))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (local.get 3))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.const 0))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.const 0))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 16))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 17))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 18))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 19))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 20))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 21))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 22))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (i32.const 23))) (call $putchar_stderr (i32.const 12)))
    (func $putchar_stderr (param i32)
        (i32.store (i32.const 0) (local.get 0))  ;; iov.iov_base
        (i32.store (i32.const 4) (i32.const 1))  ;; iov.iov_len
        (call $fd_write
            (i32.const 2) ;; file_descriptor - 2 for stderr
            (i32.const 0) ;; *iovs
            (i32.const 1) ;; iovs_len
            (i32.const 8) ;; nwritten
        )
        drop)
    (func $putchar (param i32)
        (i32.store (i32.const 0) (local.get 0))  ;; iov.iov_base
        (i32.store (i32.const 4) (i32.const 1))  ;; iov.iov_len
        (call $fd_write
            (i32.const 1) ;; file_descriptor - 1 for stdout
            (i32.const 0) ;; *iovs
            (i32.const 1) ;; iovs_len
            (i32.const 8) ;; nwritten
        )
        drop)
    (func $getchar (param i32)
        (i32.store (i32.const 0) (local.get 0))  ;; iov.iov_base
        (i32.store (i32.const 4) (i32.const 1))  ;; iov.iov_len
        (call $fd_read
            (i32.const 0) ;; 0 for stdin
            (i32.const 0) ;; *iovs
            (i32.const 1) ;; iovs_len
            (i32.const 8) ;; nread
        )
        drop)
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
