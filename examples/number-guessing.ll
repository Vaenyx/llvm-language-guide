; ModuleID = '<stdin>'
source_filename = "<stdin>"

@input_fmt = private unnamed_addr constant [3 x i8] c"%d\00"
@guess_number_str = private unnamed_addr constant [35 x i8] c"Guess a number between 1 and 100: \00"
@correct_number_fmt = private unnamed_addr constant [27 x i8] c"The correct number was %d\0A\00"
@guesses_left_fmt = private unnamed_addr constant [26 x i8] c"You have %d guesses left\0A\00"
@wrong_number_str = private unnamed_addr constant [15 x i8] c"Wrong number!\0A\00"
@invalid_input_str = private unnamed_addr constant [16 x i8] c"invalid_input!\0A\00"
@wrong_number_direction = private unnamed_addr constant [8 x i8] c"Too %s\0A\00"
@large_str = private unnamed_addr constant [6 x i8] c"large\00"
@small_str = private unnamed_addr constant [6 x i8] c"small\00"

declare i32 @scanf(ptr, ...)

declare i32 @rand()

declare void @srand(i32)

declare i64 @time(ptr)

declare i32 @printf(ptr, ...)

define private i32 @randint(i32 %max) {
entry:
  br label %seeding

seeding:                                          ; preds = %entry
  %time = call i64 @time(ptr null)
  %seed = trunc i64 %time to i32
  call void @srand(i32 %seed)
  br label %generation

generation:                                       ; preds = %seeding
  %random = call i32 @rand()
  %mod = urem i32 %random, %max
  %result = add i32 %mod, 1
  br label %end

end:                                              ; preds = %generation
  ret i32 %result
}

define i32 @main() {
entry:
  %0 = call i32 (ptr, ...) @printf(ptr @guess_number_str)
  %random = call i32 @randint(i32 100)
  %guess = alloca i32, align 4
  br label %loop

loop:                                             ; preds = %wrong_guess, %entry
  %attempts = phi i32 [ 10, %entry ], [ %next_attempts, %wrong_guess ]
  %attempts_left = icmp ugt i32 %attempts, 0
  br i1 %attempts_left, label %body, label %end

body:                                             ; preds = %loop
  %1 = call i32 (ptr, ...) @printf(ptr @guesses_left_fmt, i32 %attempts)
  %scan_return_code = call i32 (ptr, ...) @scanf(ptr @input_fmt, ptr %guess)
  %valid = icmp eq i32 %scan_return_code, 1
  br i1 %valid, label %check_guess, label %invalid_input

check_guess:                                      ; preds = %body
  %number = load i32, ptr %guess, align 4
  %equality = icmp eq i32 %number, %random
  br i1 %equality, label %correct_guess, label %wrong_guess

invalid_input:                                    ; preds = %body
  %2 = call i32 (ptr, ...) @printf(ptr @invalid_input_str)
  %unchanged_attempts = sub i32 %attempts, 0
  br label %end

correct_guess:                                    ; preds = %check_guess
  br label %end

wrong_guess:                                      ; preds = %check_guess
  %3 = call i32 (ptr, ...) @printf(ptr @wrong_number_str)
  %was_bigger = icmp ugt i32 %number, %random
  %direction = select i1 %was_bigger, ptr @large_str, ptr @small_str
  %4 = call i32 (ptr, ...) @printf(ptr @wrong_number_direction, ptr %direction)
  %next_attempts = sub i32 %attempts, 1
  br label %loop

end:                                              ; preds = %correct_guess, %invalid_input, %loop
  %code = phi i32 [ 1, %invalid_input ], [ 0, %loop ], [ 0, %correct_guess ]
  %5 = call i32 (ptr, ...) @printf(ptr @correct_number_fmt, i32 %random)
  ret i32 %code
}
