<?php

namespace igorw\naegleria\llvm;

function compile($tokens) {
    $varId = 2;
    $loopId = 0;
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
                yield '  ; -';
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
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                $varId++;
                yield sprintf('  %%%d = load i32, i32* %%%d, align 4', $varId, $varId-1);
                $varId++;
                yield sprintf('  %%%d = call i32 @putchar(i32 %%%d)', $varId, $varId-1);
                break;
            case ',';
                yield '  ; ,';
                $varId++;
                yield sprintf('  %%%d = call i32 @getchar()', $varId);
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                yield sprintf('  store i32 %%%d, i32* %%%d, align 4', $varId-1, $varId);
                break;
            case '[';
                $loopId++;
                $loopStack[] = $loopId;
                yield '  ; [';
                yield sprintf('  br label %%loops%d', $loopId);

                yield sprintf('loops%d:', $loopId);
                $varId++;
                yield sprintf('  %%%d = load i32*, i32** @i, align 8', $varId);
                $varId++;
                yield sprintf('  %%%d = load i32, i32* %%%d, align 4', $varId, $varId-1);
                $varId++;
                yield sprintf('  %%%d = icmp ne i32 %%%d, 0', $varId, $varId-1);
                yield sprintf('  br i1 %%%d, label %%loopb%d, label %%loope%d', $varId, $loopId, $loopId);

                yield sprintf('loopb%d:', $loopId);
                break;
            case ']';
                $endLoopId = array_pop($loopStack);
                yield '  ; ]';
                yield sprintf('  br label %%loops%d, !llvm.loop !{!"llvm.loop.mustprogress"}', $endLoopId);
                yield sprintf('loope%d:', $endLoopId);
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
  %2 = call i32 @system(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0))
  store i32* getelementptr inbounds ([5000 x i32], [5000 x i32]* @tape, i32 0, i32 0), i32** @i, align 8
$asm
  ret i32 0
}

declare i32 @system(i8*) #1
declare i32 @putchar(i32) #1
declare i32 @getchar() #1

EOF;

function template($asm) {
    return str_replace('$asm', $asm, TEMPLATE);
}
