# Getting started

LLVM IR is usually stored withing `.ll` files, these can be compiled/executed in several ways.

Suppose your source code file is called `foo.ll` and you want to execute it.

You have the following options

## 1 Ahead of time compilation using Clang

The easiest way of compiling LLVM IR is using the C-Language-Family compiler `clang`.

Suppose your source code file is called `foo.ll`

#### Compile it

```bash
clang foo.ll -o foo
```

#### Run it

```
./foo
```

## 2 Just in time compilation using lli

If you prefer just in time compilation you can use `lli`

#### Run it

```bash
lli foo.ll
```

## 3 Compilation using LLVM tools

If you want more control over the compilation flow you can execute the steps yourself.
For this you need `llc`

#### Compile into object file

```bash
llc -filetype=obj foo.ll -o foo.o
```

#### Link into executable

```bash
clang foo.o -o foo
```

#### Run it

```bash
./foo
```

## 4 Compilation into assembly

If you prefer looking at the final architecture specific assembly this is also possible.
For this you need `llc` and `clang`

#### Generate assembly

```bash
llc foo.ll -o foo.s
```

#### Compile and link

```
clang foo.s -o foo
```

#### Run it

```bash
./foo
```


## 5 Optimize LLVM

If you want to manually optimize your source code you can also do that.
For this you need `opt` and `clang`

#### Optimize it

```bash
opt -S -passes='default<O2>' foo.ll -o optimized-foo.ll
```
> ![TIP]
> To see all possible passes execute `opt --print-passes`

#### Compile it

```bash
clang optimized-foo.ll -o optimized-foo
```

#### Run it

```
./optimized-foo
```

---

**Next:** [Variables](./variables.md) | [Data Types](./types.md)

