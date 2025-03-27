#include "my_printf.h"

int main() {
    my_printf_t(
        "This is my printf function and it can output:\n"
        "string >> %s\n"
        "char   >> %c\n"
        "dec    >> %d\n"
        "hex    >> %x\n"
        "oct    >> %o\n"
        "bin    >> %b\n"
        "\n",

        "hello world!", '$', 2025, 2025, 2025, 2025);
    
    my_printf_t(
        "Test output:\n"
        "%o\n%d %s %x %d%%%c%b\n%d %s %x %d%%%c%b\n",
        -1, -1, "love", 3802, 100, 33, 127, -1, "love", 3802, 100, 33, 127);

    return 0;
}
