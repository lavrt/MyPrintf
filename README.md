# MyPrintf

`MyPrintf` is an educational project that implements a simplified version of the C `printf` function in **x86-64 Assembly (NASM)** with a small **C test program**. The project demonstrates low-level formatted output, variadic arguments handling, number-to-string conversion, and interaction between Assembly and C.

## Overview

The goal of this project is to practice writing programs in assembly language, as well as to better understand how formatted output works internally by building a custom `printf`-like function from scratch.

The core function is written in Assembly, while C is used to call and test it. The repository contains:
- ```my_printf.s``` - an Assembly implementation of the printing function
- ```my_printf.h```a C header for integration
- ```main.c``` a C example program,
- and a simple build script.







## Features
- **text output**
- **support for specifiers such as %s, %c, %d, %b, %o, %x, as well as the special sequence %%**

## Functions

### `my_printf_t`
```c
int my_printf(const char *format, ...);
```

**Description:**

An analog of the standard `printf', created for educational purposes.

**Parameters:**  
- `format` — format string.
- `...` — variable arguments inserted into `format`.

**Return value:**  
- `>0` — the number of output specifiers.
- `-1` is an error.

## Project launch
```
git clone https://github.com/lavrt/MyPrintf
cd MyPrintf
./build.sh
./run
```
