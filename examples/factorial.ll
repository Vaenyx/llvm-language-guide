; ModuleID = '<stdin>'
source_filename = "<stdin>"

define i64 @factorial(i64 %number) {
entry:
  br label %loop

loop:                                             ; preds = %body, %entry
  %num = phi i64 [ %number, %entry ], [ %next_num, %body ]
  %prod = phi i64 [ 1, %entry ], [ %next_prod, %body ]
  %is_zero = icmp eq i64 %num, 0
  br i1 %is_zero, label %exit, label %body

body:                                             ; preds = %loop
  %next_prod = mul i64 %num, %prod
  %next_num = sub i64 %num, 1
  br label %loop

exit:                                             ; preds = %loop
  ret i64 %prod
}
