<?php

namespace igorw\naegleria\wasm;

const DEBUG = false;

function compile($tokens) {
    $condId = 0;
    $loopId = 0;
    $loopStack = [];
    foreach ($tokens as $t) {
        if (DEBUG && $t['token'] !== '[') {
            yield '        (call $debug (local.get $i) (i32.const '.ord($t['token']).') (i32.const '.$t['line'].') (i32.const '.$t['column'].'))';
        }

        switch ($t['token']) {
            case '>';
                yield '        (local.set $i (i32.add (local.get $i) (i32.const 4)))                         ;; >';
                break;
            case '<';
                yield '        (local.set $i (i32.sub (local.get $i) (i32.const 4)))                         ;; <';
                break;
            case '+';
                yield '        (i32.store (local.get $i) (i32.add (i32.load (local.get $i)) (i32.const 1)))  ;; +';
                break;
            case '-';
                yield '        (i32.store (local.get $i) (i32.sub (i32.load (local.get $i)) (i32.const 1)))  ;; -';
                break;
            case '.';
                yield '        (call $putchar (local.get $i))                                                ;; .';
                break;
            case ',';
                yield '        (call $getchar (local.get $i))                                                ;; ,';
                break;
            case '[';
                $loopId++;
                $loopStack[] = $loopId;
                yield "        (block \$loope$loopId                                                                ;; [";
                yield "          (loop \$loops$loopId";
                if (DEBUG) {
                    yield '            (call $debug (local.get $i) (i32.const '.ord($t['token']).') (i32.const '.$t['line'].') (i32.const '.$t['column'].'))';
                }
                yield "            (br_if \$loope$loopId (i32.eqz (i32.load (local.get \$i))))";
                break;
            case ']';
                $endLoopId = array_pop($loopStack);
                yield "            br \$loops$endLoopId                                                                ;; ]";
                yield '        ))';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
(module
    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
    (import "wasi_unstable" "fd_read" (func $fd_read (param i32 i32 i32 i32) (result i32)))
    ;; memory layout
    ;; 00 iov.iov_base iov.iov_len
    ;; 08 nwritten token
    ;; 16 tape
    (memory 1)
    (export "memory" (memory 0))
    ;; debug format
    ;; 00 op i tape[i] 0 line col 00
    ;; 32 tape[00..07]
    ;; 64 tape[08..15]
    ;; 96 tape[16..24]
    (func $debug (param $i i32) (param $op i32) (param $line i32) (param $col i32)
        (local $j i32)
        (i32.store (i32.const 12) (local.get $op))           (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (local.get $i))            (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.load (local.get $i))) (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.const 0))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (local.get $line))         (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (local.get $col))          (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.const 0))             (call $putchar_stderr (i32.const 12))
        (i32.store (i32.const 12) (i32.const 0))             (call $putchar_stderr (i32.const 12))
        (loop $dump_core
            (i32.store (i32.const 12) (i32.load (i32.add (i32.mul (local.get $j) (i32.const 4)) (i32.const 16))))
            (call $putchar_stderr (i32.const 12))
            (local.set $j (i32.add (local.get $j) (i32.const 1)))
            (br_if $dump_core (i32.lt_s (local.get $j) (i32.const 24)))
            ))
    (func $putchar_stderr (param $addr i32)
        (i32.store (i32.const 0) (local.get $addr))  ;; iov.iov_base
        (i32.store (i32.const 4) (i32.const 1))      ;; iov.iov_len
        (call $fd_write
            (i32.const 2) ;; file_descriptor - 2 for stderr
            (i32.const 0) ;; *iovs
            (i32.const 1) ;; iovs_len
            (i32.const 8) ;; nwritten
        )
        drop)
    (func $putchar (param $addr i32)
        (i32.store (i32.const 0) (local.get $addr))  ;; iov.iov_base
        (i32.store (i32.const 4) (i32.const 1))      ;; iov.iov_len
        (call $fd_write
            (i32.const 1) ;; file_descriptor - 1 for stdout
            (i32.const 0) ;; *iovs
            (i32.const 1) ;; iovs_len
            (i32.const 8) ;; nwritten
        )
        drop)
    (func $getchar (param $addr i32)
        (i32.store (i32.const 0) (local.get $addr))  ;; iov.iov_base
        (i32.store (i32.const 4) (i32.const 1))      ;; iov.iov_len
        (call $fd_read
            (i32.const 0) ;; 0 for stdin
            (i32.const 0) ;; *iovs
            (i32.const 1) ;; iovs_len
            (i32.const 8) ;; nread
        )
        drop)
    (func $main (export "_start")
        (local $i i32)
        (local.set $i (i32.const 16))
$asm
    )
)

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
