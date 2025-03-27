#!/bin/bash

nasm -f elf64 -l my_printf.lst my_printf.s

g++ -no-pie -o run -Wall -Wextra main.cpp my_printf.o