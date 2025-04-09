#!/bin/bash

nasm -f elf64 -l ./src/my_printf.lst ./src/my_printf.s

g++ -no-pie -o run -Wall -Wextra -Iinclude ./src/main.cpp ./src/my_printf.o