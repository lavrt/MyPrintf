#include "my_printf.h"

#include <stdio.h>

int main() {
    printf(
        "-------------------------------------\n"
        "This is default C printf function:\n"
        "-------------------------------------\n\n"
    );

    printf(
        "string >> %s\n"
        "char   >> %c\n"
        "dec    >> %d\n"
        "hex    >> %x\n"
        "oct    >> %o\n"
        "bin    >> %b\n"
        "\n",
        "hello world!", '$', 2025, 2025, 2025, 2025
    );

    printf(
        "Test output:\n"
        "%o\n%d %s %x %d%%%c%b\n%d %s %x %d%%%c%b\n",
        -1, -1, "love", 3802, 100, 33, 127, -1, "love", 3802, 100, 33, 127
    );

    my_printf_t(
        "\n-------------------------------------\n"
        "This is my printf function:\n"
        "-------------------------------------\n\n"
    );

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
    
    my_printf_t(
        "Test output:\n"
        "%o\n%d %s %x %d%%%c%b\n%d %s %x %d%%%c%b\n",
        -1, -1, "love", 3802, 100, 33, 127, -1, "love", 3802, 100, 33, 127
    );

    return 0;
}
