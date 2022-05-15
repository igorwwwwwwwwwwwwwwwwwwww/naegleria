<?php

namespace igorw\naegleria\php;

function compile($tokens) {
    foreach ($tokens as $t) {
        switch ($t['token']) {
            case '>';
                yield '$i++; // >';
                break;
            case '<';
                yield '$i--; // >';
                break;
            case '+';
                yield '$tape[$i] += 1; // +';
                break;
            case '-';
                yield '$tape[$i] -= 1; // -';
                break;
            case '.';
                yield 'echo chr($tape[$i]); // .';
                break;
            case ',';
                yield '$char = fread(STDIN, 1); // ,';
                yield '$tape[$i] = ($char === "\x04") ? 0 : ord($char);';
                break;
            case '[';
                yield 'while ($tape[$i]) { // [';
                break;
            case ']';
                yield '} // ]';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
<?php

system('stty -icanon');

$tape = \SplFixedArray::fromArray(array_fill(0, 4000, 0));
$i = 0;

$asm

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
