; ModuleID = '<stdin>'
source_filename = "<stdin>"

%MinMax = type { i32, i32 }

define %MinMax @signed_min_max(ptr %array, i32 %length) {
entry:
  %first = load i32, ptr %array, align 4
  br label %loop

loop:                                             ; preds = %body, %entry
  %i = phi i32 [ 1, %entry ], [ %next_i, %body ]
  %min = phi i32 [ %first, %entry ], [ %next_min, %body ]
  %max = phi i32 [ %first, %entry ], [ %next_max, %body ]
  %is_end = icmp eq i32 %i, %length
  br i1 %is_end, label %exit, label %body

body:                                             ; preds = %loop
  %element_ptr = getelementptr i32, ptr %array, i32 %i
  %element = load i32, ptr %element_ptr, align 4
  %lt_min = icmp slt i32 %element, %min
  %gt_max = icmp sgt i32 %element, %max
  %next_min = select i1 %lt_min, i32 %element, i32 %min
  %next_max = select i1 %gt_max, i32 %element, i32 %max
  %next_i = add i32 %i, 1
  br label %loop

exit:                                             ; preds = %loop
  %p1 = insertvalue %MinMax poison, i32 %min, 0
  %p2 = insertvalue %MinMax %p1, i32 %max, 1
  ret %MinMax %p2
}
