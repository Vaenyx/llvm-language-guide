; ModuleID = '<stdin>'
source_filename = "<stdin>"

define i64 @str_len(ptr %str_pointer) {
entry:
  br label %loop

loop:                                             ; preds = %body, %entry
  %i = phi i64 [ 0, %entry ], [ %next_i, %body ]
  %char_pointer = getelementptr inbounds i8, ptr %str_pointer, i64 %i
  %char = load i8, ptr %char_pointer, align 1
  %is_null_terminator = icmp eq i8 %char, 0
  br i1 %is_null_terminator, label %exit, label %body

body:                                             ; preds = %loop
  %next_i = add i64 %i, 1
  br label %loop

exit:                                             ; preds = %loop
  ret i64 %i
}
