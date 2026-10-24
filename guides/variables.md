# Variables & Values

Variables in LLVM IR are handled differently than in many other programming languages.
Instead of mutable variables which can be reassigned LLVM primarily uses immutable variables.
This concept is called **Static Single Assignment (SSA)**

This guide explains how values and variables work in LLVM IR, how to create and modify variables using memory, and how to define global variables as well as constants.

## 1. Understanding SSA Values

In languages such as C, variables can be reassigned by default:

```c
int x = 10;
x = 20;
```

In LLVM IR, local SSA values can only be assigned **exactly once**.

```llvm
define i32 @main() {
entry:
    %x = add i32 0, 10
    %y = add i32 %x, 10

    ret i32 %y
}
```

**Explanation:**

- `%x` is an SSA value containing `10`.
- `%y` is a new SSA value containing `%x + 10`.
- `add i32` performs integer addition on two 32-bit values.
- `ret i32 %y` returns the result of the program, which is `20`.

Notice that `%x` is never modified. Instead, a new value `%y` is created.

The following code is **invalid**:

```llvm
%x = add i32 0, 10
%x = add i32 %x, 10  ; Error: %x is defined twice
```

Each SSA value must have a unique definition.

## 2. Local Values

Local values are commonly referred to as variables and are identified by an `%` prefix.

For example:

```llvm
define i32 @main() {
entry:
    %a = add i32 5, 10
    %b = mul i32 %a, 2
    %c = sub i32 %b, 5

    ret i32 %c
}
```

This example performs the following variables:

| Value | Operation | Result |
|---|---|---|
| `%a` | 5 + 10 | 15 |
| `%b` | 15 × 2 | 30 |
| `%c` | 30 - 5 | 25 |

Local SSA values are not necessarily stored in memory. They represent values produced by instructions, which LLVM can optimize and eventually assign to cpu registers or eliminate entirely.

## 3. Mutable Variables

Although SSA values cannot be reassigned, LLVM IR supports mutable variables through pointers.

> ![Explanation]
> Pointers are values that refer to memory locations. They can point to stack memory, heap memory, global variables, or other addressable locations. In modern LLVM IR, pointers use the ptr type.

To implement mutable variables the important instructions are:

| Instruction | Description |
|---|---|
| `alloca` | Allocates memory on the stack |
| `store` | Writes a value to memory |
| `load` | Reads a value from memory |

### Allocating Memory

The `alloca` instruction reserves memory for a value.

```llvm
%number = alloca i32
```

This allocates enough stack memory to hold a 32-bit integer.

`%number` contains a **pointer** to that memory, not the integer itself.

The allocated memory is initially uninitialized.
> ![Warning]
> Uninitialized does not mean filled with zeros. Instead, the memory has no defined initial value, so reading it may produce an arbitrary value.

### Storing a Value

Use `store` to write a value into memory.

```llvm
store i32 10, ptr %number
```

This writes the integer `10` to the memory location referenced by `%number`.

### Loading a Value

Use `load` to read a value from memory.

```llvm
%value = load i32, ptr %number
```

The loaded integer is assigned to the new SSA value `%value`.

### Complete Example

```llvm
define i32 @main() {
entry:
    %number = alloca i32  ; Allocate memory for an integer.

    store i32 10, ptr %number  ; Initialize `%number` to 10.

    %value = load i32, ptr %number  ; Load 10 into `%value`.

    %result = add i32 %value, 5  ; Calculate 10 + 5 = 15.

    store i32 %result, ptr %number  ; Update `%number` to 15.

    ret i32 %result  ; Return 15.
}
```

Unlike SSA values, the contents of an allocated memory location can change multiple times.

However, the SSA pointer `%number` itself is still only defined once.

## 4. Global Variables

Global variables are declared outside functions and use the `@` prefix.

```llvm
@counter = global i32 10

define i32 @main() {
entry:
    %value = load i32, ptr @counter

    %updated = add i32 %value, 5

    store i32 %updated, ptr @counter

    ret i32 %updated
}
```

**Explanation:**

- `@counter` defines a global integer initialized to `10`.
- `load` reads its current value.
- `add` calculates a new value.
- `store` updates the global variable.

Global variables are accessible from functions that can reference them.

Unlike local stack allocations, global storage normally exists for the entire lifetime of the program.

## 5. Constants

LLVM IR supports both literal constants and global constant objects.

### Literal Constants

Literal constants can be used directly as instruction operands.

```llvm
define i32 @main() {
entry:
    %result = mul i32 10, 5

    ret i32 %result
}
```

Here, `10` and `5` are integer constants.

There is no need to allocate memory for them.

### Global Constants

Global constants are declared using `constant`

```llvm
@limit = constant i32 100

define i32 @main() {
entry:
    %value = load i32, ptr @limit

    ret i32 %value
}
```

The `@limit` object contains the integer `100`.

Because it is declared as a constant, its contents must not be modified.

Attempting to write to it results in undefined behavior.

> ![Explanation]
> Undefined behaviour means that the program does not guarantee a certain behaviour for something.
> Therefore the behaviour is subject to change between compiler versions, implementations or even in a single program execution

## 6. Module Control (Linkage & Visibility)

LLVM IR provides options for how to control the module capabilities of symbols.

**Visibility** determines how symbols are exposed (eg. in shared libraries)

### Linking

Linkage specifies how a function or global variable participates in symbol resolution between modules.

Imagine you have two files, `math-globals.ll` is supposed to expose a variable called pi to be used in `math.ll`.

By default, LLVM uses `external` linking, allowing a symbol to be used in another file or module.

```llvm
@pi = global float 3.1415927
```

You can then use it in another file by declaring it.

```llvm
@pi = external global float
```

If you want to prevent other modules from referencing your variable by name, you can use the `internal` keyword.

```llvm
@pi = internal global float 3.1415927
```

You can even go one step further and also remove the symbol from the object file's symbol table by using the `private` keyword.

```llvm
@pi = private global float 3.1415927
```

Summarized you can view it like this:
| Linkage | Accessible externally | Object file symbol |
|---|---|---|
| `external` (default) | Yes | Global |
| `internal` | No | Local |
| `private` | No | None |

### Visibility

Visibility specifies how symbols are exposed to other executables and shared libraries.

By default, LLVM uses `default` visibility, allowing a symbol to be exported and potentially overridden by another shared library.

```llvm
@pi = global float 3.1415927
```

If you want to prevent other shared libraries from accessing your symbol directly, you can use the `hidden` keyword.

```llvm
@pi = hidden global float 3.1415927
```

You can also use `protected` to keep the symbol accessible externally while preventing other modules from overriding references to it within the defining shared library.

```llvm
@pi = protected global float 3.1415927
```

Summarized you can view it like this (on ELF-based systems):

| Visibility | Externally accessible | Overridable |
|---|---|---|
| `default` (default) | Yes | Yes |
| `hidden` | No (dynamic linking) | No |
| `protected` | Yes | No |

**Important:** Unlike linkage, visibility primarily controls dynamic linking. Symbols with `internal` or `private` linkage must use `default` visibility.

## 7. Naming Rules

LLVM IR uses different prefixes to distinguish local and global identifiers.

| Syntax | Meaning | Example |
|---|---|---|
| `%name` | Local SSA value | `%result` |
| `%0` | Numbered local value | `%0` |
| `@name` | Global symbol | `@counter` |
| `@function` | Function symbol | `@main` |

Local names only need to be unique within their function.

Global symbol names must be unique within their LLVM module.

## 8. Important Differences

| Feature | SSA Value | Memory Variable | Constant |
|---|---|---|---|
| Defined using | `add`, `mul`, `load`, etc. | `alloca` or `global` | Literal or `constant` |
| Can be reassigned | No | Contents can change | No |
| Requires memory storage | Not necessarily | Yes | Only global constants |
| Accessed using | Direct value reference | `load` and `store` | Directly or `load` for global constants
| Example | `%x = add i32 5, 10` | `%x = alloca i32` | `i32 42` or `@x = constant i32 42` |

**Important:** An SSA value can itself be a pointer to mutable memory. SSA restricts reassignment of the value, not modification of the memory it points to.

---

## Additional Resources

- [LLVM Opaque Pointers](https://llvm.org/docs/OpaquePointers.html)

**Next:** [Comments](./comments.md) | [Data Types](./types.md)
