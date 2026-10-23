@greeting_fmt = private unnamed_addr constant [10 x i8] c"Hello %s\0A\00"
@error_msg = private unnamed_addr constant [24 x i8] c"Error: No args provided\00"

declare i32 @printf(ptr, ...)
declare i32 @puts(ptr)

define i32 @main(i32 %argc, ptr %argv) {
entry:
    %has_arg = icmp sgt i32 %argc, 1
    br i1 %has_arg, label %greet, label %error

greet:
    %argptr = getelementptr inbounds ptr, ptr %argv, i64 1
    %name = load ptr, ptr %argptr

    call i32 (ptr, ...) @printf(ptr @greeting_fmt, ptr %name)
    ret i32 0

error:
    call i32 @puts(ptr @error_msg)
    ret i32 1
}

