; ModuleID = '<stdin>'
source_filename = "<stdin>"

@error_msg = private unnamed_addr constant [23 x i8] c"Error: No arg provided\00"
@even_msg = private unnamed_addr constant [5 x i8] c"Even\00"
@odd_msg = private unnamed_addr constant [4 x i8] c"Odd\00"

declare i32 @puts(ptr)

declare i32 @atoi(ptr)

define private i1 @is_odd(i32 %number) {
entry:
  %is_odd = trunc i32 %number to i1
  ret i1 %is_odd
}

define i32 @main(i32 %argc, ptr %argv) {
entry:
  %has_arg = icmp sgt i32 %argc, 1
  br i1 %has_arg, label %check, label %arg_error

check:                                            ; preds = %entry
  %arg_ptr = getelementptr inbounds ptr, ptr %argv, i64 1
  %arg_str = load ptr, ptr %arg_ptr, align 8
  %number = call i32 @atoi(ptr %arg_str)
  %is_odd = call i1 @is_odd(i32 %number)
  br i1 %is_odd, label %odd, label %even

arg_error:                                        ; preds = %entry
  %0 = call i32 @puts(ptr @error_msg)
  br label %error

odd:                                              ; preds = %check
  %1 = call i32 @puts(ptr @odd_msg)
  br label %success

even:                                             ; preds = %check
  %2 = call i32 @puts(ptr @even_msg)
  br label %success

success:                                          ; preds = %even, %odd
  ret i32 0

error:                                            ; preds = %arg_error
  ret i32 1
}
