<?php

namespace igorw\naegleria\llvm;

function compile($tokens) {
    $loopId = 0;
    $varId = 2;
    $loopStack = [];
    foreach ($tokens as $t) {
        switch ($t['token']) {
            case '>';
                yield '  ; >';
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                $varId++;
                yield sprintf('  %%%d = getelementptr inbounds i32, i32* %%%d, i32 1', $varId, $varId-1);
                yield sprintf('  store i32* %%%d, i32** @i, align 8', $varId);
                break;
            case '<';
                yield '  ; <';
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                $varId++;
                yield sprintf('  %%%d = getelementptr inbounds i32, i32* %%%d, i32 -1', $varId, $varId-1);
                yield sprintf('  store i32* %%%d, i32** @i, align 8', $varId);
                break;
            case '+';
                yield '  ; +';
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                $varId++;
                yield sprintf('  %%%d = load i32, i32* %%%d, align 4', $varId, $varId-1);
                $varId++;
                yield sprintf('  %%%d = add nsw i32 %%%d, 1', $varId, $varId-1);
                yield sprintf('  store i32 %%%d, i32* %%%d, align 4', $varId, $varId-2);
                break;
            case '-';
                yield ' ; -';
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                $varId++;
                yield sprintf('  %%%d = load i32, i32* %%%d, align 4', $varId, $varId-1);
                $varId++;
                yield sprintf('  %%%d = add nsw i32 %%%d, -1', $varId, $varId-1);
                yield sprintf('  store i32 %%%d, i32* %%%d, align 4', $varId, $varId-2);
                break;
            case '.';
                yield '  ; .';
                break;
            case ',';
                yield '  ; ,';
                break;
            case '[';
                $loopId++;
                $loopStack[] = $loopId;
                yield '  ; [';
                break;
            case ']';
                $endLoopId = array_pop($loopStack);
                yield '  ; ]';
                break;
        }
    }
}

const TEMPLATE = <<<'EOF'
@.str = private unnamed_addr constant [13 x i8] c"stty -icanon\00", align 1
@tape = common global [5000 x i32] zeroinitializer, align 4
@i = common global i32* null, align 8

define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call i32 @"\01_system"(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0))
  store i32* getelementptr inbounds ([5000 x i32], [5000 x i32]* @tape, i32 0, i32 0), i32** @i, align 8
$asm
  ret i32 0
}

declare i32 @"\01_system"(i8*) #1

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
