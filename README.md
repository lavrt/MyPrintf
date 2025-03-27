# Printf function

This is a learning project that has created an analog of the printf function in the C language.

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
nasm -f elf64 -l my_printf.lst my_printf.s
```
```
g++ -no-pie -o build -Wall -Wextra main.cpp my_printf.o
```
```
./build
```
