# MyPrintf

`MyPrintf` is an educational project that implements a simplified version of the `printf` function in **x86-64 Assembly (NASM)** with a small **C++ test program**. The project demonstrates low-level formatted output, variadic arguments handling, number-to-string conversion, and interaction between Assembly and C++.

---

## Overview

The goal of this project is to practice writing programs in assembly language, as well as to better understand how formatted output works internally by building a custom `printf`-like function from scratch.

The core function is written in Assembly, while C++ is used to call and test it. The repository contains:
- `my_printf.asm` - an assembly implementation of the printing function
- `my_printf.hpp` - a header for integration
- `main.cpp` - an example program

---

## Supported format specifiers

The custom function supports:
- `%s` — string
- `%c` — character
- `%d` — decimal integer
- `%x` — hexadecimal integer
- `%o` — octal integer
- `%b` — binary integer
- `%%` — escaped percent sign

---

## Project structure

```text
MyPrintf/
├── include/
│   └── my_printf.hpp
├── src/
│   ├── main.cpp
│   └── my_printf.asm
├── .gitignore
├── CMakeLists.txt
└── README.md
```

---

## Function interface
The function is declared in `include/my_printf.hpp`:
```cpp
extern "C" int my_printf_t(const char* format, ...);
```

---

## Example

Example usage from `main.cpp`:

```cpp
my_printf_t(
    "string >> %s\n"
    "char   >> %c\n"
    "dec    >> %d\n"
    "hex    >> %x\n"
    "oct    >> %o\n"
    "bin    >> %b\n"
    "\n",
    "hello world!", '$', 2025, 2025, 2025, 2025
);
```

The test program also includes additional examples to demonstrate multiple specifiers in one call.

---

## Build and run

### Get code

```bash
git clone https://github.com/lavrt/MyPrintf
cd MyPrintf
```

### Configure and build

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j
```

### Run

```bash
./build/run
```

---

## Limitations

This project is intended for learning purposes and does not aim to fully reproduce the standard C printf. It currently supports only a small subset of format specifiers and does not implement advanced formatting features such as width, precision, flags, or floating-point output.
