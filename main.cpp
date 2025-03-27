extern "C" int my_printf_t(const char* format, ...);  // to header
                                                // shall script
                                                // в readme сигнатуру функции добавить

int main() {
    // my_printf_t(
    //     "This is my printf function and it can output:\n"
    //     "string >> %s\n"
    //     "char   >> %c\n"
    //     "dec    >> %d\n"
    //     "hex    >> %x\n"
    //     "oct    >> %o\n"
    //     "bin    >> %b\n"
    //     "%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \n\n",

    //     "hello world!", '$', 2025, 2026, 2027, 2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044);
    
    my_printf_t("%o\n%d %s %x %d%%%c%b\n%d %s %x %d%%%c%b\n", -1, -1, "love", 3802, 100, 33, 127, -1, "love", 3802, 100, 33, 127);


    return 0;
}
