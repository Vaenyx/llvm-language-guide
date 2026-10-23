# LLVM IR Language Guide

A collection of guides and examples for learning **LLVM Intermediate Representation (LLVM IR)**, focusing mainly on the basics.

## What is LLVM?

The **LLVM Project** is a collection of modular compiler and toolchain technologies designed to support the development of programming languages.

LLVM is commonly used as a compilation backend by languages such as **C/C++ (Clang)**, **Rust (rustc)**, and many others. It provides tools for code optimization and machine code generation across different architectures.

At its core is **LLVM Intermediate Representation (LLVM IR)**, a low-level, strongly typed, assembly-like language used to represent programs during compilation.

LLVM IR provides several important features, including:

- **Strong typing** – Explicit types for values and operations.
- **Static Single Assignment (SSA)** – A representation in which each SSA value is assigned exactly once.
- **Low-level operations** – Direct control over memory, arithmetic, and program flow.
- **Platform independence** – An intermediate representation that can be compiled for multiple target architectures.
- **Optimization** – Support for LLVM's extensive collection of optimization passes.

This repository focuses on the human-readable, textual form of LLVM IR, explaining its syntax and concepts through practical examples.

For a complete technical specification, refer to the official [LLVM Language Reference Manual](https://llvm.org/docs/LangRef.html).

## Guides

The following guides cover individual aspects of LLVM IR. Each topic links to a dedicated Markdown file containing explanations and examples.

| Topic | Description | Guide |
|---|---|---|
| **Getting Started** | Compilation, linking and execution | [View Guide](./guides/getting-started.md) |
| **Variables & Values** | SSA values, constants, and variable storage. | [View Guide](./guides/variables.md) |
| **Comments** | Single line comments. | [View Guide](./guides/comments.md) |
| **Data Types** | Integers, floating-point types, pointers, arrays, and structures. | [View Guide](./guides/types.md) |
| **Functions** | Function declarations, definitions, parameters, and return values. | [View Guide](./guides/functions.md) |
| **Command-Line-Arguments** | Access and process command line arguments. | [View Guide](./guides/command-line-arguments.md) |
| **Arithmetic Operations** | Integer and floating-point arithmetic instructions. | [View Guide](./guides/arithmetic.md) |
| **Memory Operations** | Allocating, loading, and storing data in memory. | [View Guide](./guides/memory.md) |
| **Control Flow** | Branches, basic blocks, conditions, and loops. | [View Guide](./guides/control-flow.md) |
| **Comparisons** | Integer and floating-point comparisons. | [View Guide](./guides/comparisons.md) |
| **PHI Nodes** | Combining SSA values from different control-flow paths. | [View Guide](./guides/phi-nodes.md) |
| **Structures & Arrays** | Working with aggregate data types. | [View Guide](./guides/aggregates.md) |
| **External Functions** | Declaring and calling functions from external libraries. | [View Guide](./guides/external-functions.md) |

## Example Projects

The following projects demonstrate LLVM IR through practical examples, starting with simple programs and gradually introducing more advanced concepts.

| Project | Description | Guide |
|---|---|---|
| **Hello World** | Print a simple message to the console using `printf` or `puts`. | [View Project](./examples/hello-world.ll) |
| **Hello User** | Read a name from standard input and print a personalized greeting. | [View Project](./examples/hello-user.ll) |
| **Simple Calculator** | Perform basic arithmetic operations such as addition, subtraction, multiplication, and division. | [View Project](./examples/calculator.ll) |
| **Even or Odd** | Determine whether an integer is even or odd using arithmetic and conditional branches. | [View Project](./examples/even-odd.ll) |
| **Number Guessing Game** | Build a simple game that asks the user to guess a number. | [View Project](./examples/number-guessing.ll) |
| **Factorial Calculator** | Calculate the factorial of a number using loops or recursion. | [View Project](./examples/factorial.ll) |
| **Fibonacci Sequence** | Generate Fibonacci numbers using loops and PHI nodes. | [View Project](./examples/fibonacci.ll) |
| **Prime Number Checker** | Determine whether a given integer is prime. | [View Project](./examples/prime-checker.ll) |
| **Array Sum** | Iterate through an array and calculate the sum of its elements. | [View Project](./examples/array-sum.ll) |
| **Find Min & Max** | Find the smallest and largest values in an array. | [View Project](./examples/min-max.ll) |
| **String Length** | Implement a basic string length function without using `strlen`. | [View Project](./examples/string-length.ll) |
| **String Comparison** | Compare two strings character by character. | [View Project](./examples/string-comparison.ll) |
| **Bubble Sort** | Implement a simple sorting algorithm using arrays and nested loops. | [View Project](./examples/bubble-sort.ll) |
| **Dynamic Memory** | Allocate and free memory using external functions such as `malloc` and `free`. | [View Project](./examples/dynamic-memory.ll) |
| **File Reader** | Open and read a text file using standard C library functions. | [View Project](./examples/file-reader.ll) |

## Additional Resources

- [LLVM Official Website](https://llvm.org/)
- [LLVM Language Reference](https://llvm.org/docs/LangRef.html)
- [LLVM Command Guide](https://llvm.org/docs/CommandGuide/)
- [LLVM Programmer's Manual](https://llvm.org/docs/ProgrammersManual.html)
- [LLVM GitHub Repository](https://github.com/llvm/llvm-project)

---

*This guide is intended as a practical introduction to LLVM IR. For authoritative details, consult the official LLVM documentation.*
