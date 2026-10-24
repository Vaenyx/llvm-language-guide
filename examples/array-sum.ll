; ModuleID = '<stdin>'
source_filename = "<stdin>"

define i32 @sum(ptr %array, i32 %length) {
entry:
  br label %loop

loop:                                             ; preds = %body, %entry
  %i = phi i32 [ 0, %entry ], [ %next_i, %body ]
  %sum = phi i32 [ 0, %entry ], [ %new_sum, %body ]
  %is_end = icmp sge i32 %i, %length
  br i1 %is_end, label %exit, label %body

body:                                             ; preds = %loop
  %element_ptr = getelementptr i32, ptr %array, i32 %i
  %element = load i32, ptr %element_ptr, align 4
  %new_sum = add i32 %sum, %element
  %next_i = add i32 %i, 1
  br label %loop

exit:                                             ; preds = %loop
  ret i32 %sum
}
