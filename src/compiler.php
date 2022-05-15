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
        case 'aarch64':
            return aarch64\compile($tokens);
        case 'amd64':
            return amd64\compile($tokens);
        case 'llvm':
            return llvm\compile($tokens);
        case 'wasm':
            return wasm\compile($tokens);
        default:
            throw new \RuntimeException("unsupported architecture: $arch");
    }
}

function template($arch, $asm) {
    switch ($arch) {
        case 'aarch64':
            return aarch64\template($asm);
        case 'amd64':
            return amd64\template($asm);
        case 'llvm':
            return llvm\template($asm);
        case 'wasm':
            return wasm\template($asm);
        default:
            throw new \RuntimeException("unsupported architecture: $arch");
    }
}
