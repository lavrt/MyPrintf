cmake_minimum_required(VERSION 3.11)
project(my_printf LANGUAGES CXX ASM_NASM)

add_executable(run
    src/main.cpp
    src/my_printf.asm
)

target_include_directories(run
    PRIVATE
        ${CMAKE_SOURCE_DIR}/include
)

target_link_options(run
    PRIVATE
        -no-pie
)
