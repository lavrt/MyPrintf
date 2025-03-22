# Printf function

This is a learning project that has created an analog of the printf function in the C language.

## Features
- **text output**
- **support for specifiers such as %s, %c, %d, %b, %o, %x, as well as the special sequence %%**

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
