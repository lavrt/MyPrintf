extern "C" void my_printf_t(const char*, const char*, char, int, int, int, int);

int main() {
    my_printf_t(
        "This is my printf function and it can output:\n"
        "string >> %s\n"
        "char   >> %c\n"
        "dec    >> %d\n"
        "hex    >> %x\n"
        "oct    >> %o\n"
        "bin    >> %b\n",

        "hello world!", '$', 2025, 2025, 2025, 2025);

    return 0;
}
