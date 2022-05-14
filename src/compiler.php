<?php

namespace igorw\naegleria;

function tokenize($code) {
    $tokens = [];

    $lines = explode("\n", $code);
    foreach ($lines as $i => $line) {
        $chars = str_split($line);
        foreach ($chars as $j => $char) {
            if (in_array($char, ['>', '<', '+', '-', '.', ',', '[', ']'], true)) {
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

function compile($arch, $tokens) {
    switch ($arch) {
        case 'arm':
            return arm\compile($tokens);
        case 'intel':
            return intel\compile($tokens);
        case 'wasm':
            return wasm\compile($tokens);
        default:
            throw new \RuntimeException("unsupported architecture: $arch");
    }
}

function template($arch, $asm) {
    switch ($arch) {
        case 'arm':
            return arm\template($asm);
        case 'intel':
            return intel\template($asm);
        case 'wasm':
            return wasm\template($asm);
        default:
            throw new \RuntimeException("unsupported architecture: $arch");
    }
}
