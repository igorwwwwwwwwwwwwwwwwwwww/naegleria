@.str = private unnamed_addr constant [13 x i8] c"stty -icanon\00", align 1
@tape = common global [5000 x i32] zeroinitializer, align 4
@i = common global i32* null, align 8

define i32 @main() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call i32 @"\01_system"(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0))
  store i32* getelementptr inbounds ([5000 x i32], [5000 x i32]* @tape, i32 0, i32 0), i32** @i, align 8
  %3 = load i32*, i32** @i, align 8
  %4 = getelementptr inbounds i32, i32* %3, i32 1
  store i32* %4, i32** @i, align 8
  %5 = load i32*, i32** @i, align 8
  %6 = load i32, i32* %5, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, i32* %5, align 4
  ret i32 0
}

declare i32 @"\01_system"(i8*) #1
