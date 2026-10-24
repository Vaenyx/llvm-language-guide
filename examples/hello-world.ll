@greeting_msg = private unnamed_addr constant [14 x i8] c"Hello, World!\00"

declare i32 @puts(ptr)

define i32 @main() {
entry:
  call i32 @puts(ptr @greeting_msg)
  ret i32 0
}
