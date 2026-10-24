# Comments

Comments in LLVM IR are used to document code and explain instructions without affecting the program's execution.
They are removed during bitecode assembly.
LLVM IR supports both single-line comments and block comments.

## 1. Single-Line Comments

Contrary to other languages which use `//` or `#` for Single-line comments, LLVM IR comments begin with a semicolon (`;`). Everything after the semicolon until the end of the line is treated as a comment.

```llvm
; This is a single-line comment.

define i32 @main() {
entry:
    %x = add i32 5, 10  ; Calculate 5 + 10.

    ret i32 %x  ; Return 15.
}
```

Comments can appear on their own line or after an instruction.

## 2. Block Comments

LLVM IR also supports c-style block comments using `/*` and `*/`.

Unlike single-line comments, block comments can span multiple lines.

```llvm
/*
    This function calculates
    the sum of two integers
    and returns the result.
*/

define i32 @main() {
entry:
    %result = add i32 10, 20

    ret i32 %result
}
```

Block comments can also appear on a single line:

```llvm
%result = add i32 10, 20  /* Result: 30 */
```

---

**Next:** [Data Types](./types.md) | [functions](./functions.md)
