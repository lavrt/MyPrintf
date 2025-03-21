;===================================
; nasm -f elf64 -l main.lst main.s
; ld -s -o main main.o
; ./main
;===================================

section .bss
    BUFFER_SIZE equ 128
    buffer resb BUFFER_SIZE
    index resb 1

section .text

global my_printf_t
my_printf_t:
    push r9
    push r8
    push rcx
    push rdx
    push rsi
    push rdi

    jmp my_printf
    return:

    add rsp, 8 * 6
    ret

my_printf:
    mov rax, [rsp]
    lea rbx, [rsp + 8]
    mov byte [index], 0

    xor rcx, rcx
    .loop:
        mov rdx, rsp
        add rdx, 8 * 6
        cmp rbx, rdx
        jne .skip
        add rbx, 8
        .skip:

        movzx rdx, byte [rax]
        cmp rdx, byte 0
        je .close
        cmp rdx, byte '%'
        je .specifier
        jmp .print_default_char

        .specifier:
            inc rax
            movzx rdx, byte [rax]
            cmp rdx, byte 'c'
            je .print_char
            cmp rdx, byte 'd'
            je .print_decimal
            cmp rdx, byte 'x'
            je .print_hexadecimal
            cmp rdx, byte 'o'
            je .print_octal
            cmp rdx, byte 'b'
            je .print_binary
            cmp rdx, byte 's'
            je .print_string
            cmp rdx, byte '%'
            je .print_default_char
            jmp .invalid_specifier
        .print_char:
            push rax
            mov rax, [rbx]
            call print_char
            pop rax
            add rbx, 8
            inc rax
            inc rcx
            jmp .loop
        .print_default_char:
            push rax
            mov rax, rdx
            call print_char
            pop rax
            inc rax
            inc rcx
            jmp .loop
        .print_decimal:
            push rax
            mov rax, [rbx]
            call print_decimal
            pop rax
            add rbx, 8
            inc rax
            inc rcx
            jmp .loop
        .print_hexadecimal:
            push rax
            mov rax, [rbx]
            call print_hexadecimal
            pop rax
            add rbx, 8
            inc rax
            inc rcx
            jmp .loop
        .print_octal:
            push rax
            mov rax, [rbx]
            call print_octal
            pop rax
            add rbx, 8
            inc rax
            inc rcx
            jmp .loop
        .print_binary:
            push rax
            mov rax, [rbx]
            call print_binary
            pop rax
            add rbx, 8
            inc rax
            inc rcx
            jmp .loop
        .print_string:
            push rax
            mov rax, [rbx]
            call print_string
            pop rax
            add rbx, 8
            inc rax
            jmp .loop
        .invalid_specifier:
            mov rcx, -1

    .close:
        call buffer_reset
        mov rax, rcx
        jmp return

print_char:
    push rax
    push rbx
    push rcx
    push rdi

    cmp byte [index], BUFFER_SIZE - 1
    jb .skip
    call buffer_reset
    .skip:

    movzx rbx, byte [index]
    mov [buffer + rbx], al
    inc byte [index]

    pop rdi
    pop rcx
    pop rbx
    pop rax
    ret

print_decimal:
    push rax
    push rbx
    push rcx
    push rdx

    xor rcx, rcx
    cmp rax, 0
    jl .minus
    jmp .get_digits
    .minus:
        neg rax
        push rax
        mov rax, '-'
        call print_char
        pop rax
    .get_digits:
        xor rdx, rdx
        mov rbx, 10
        div rbx
        push rdx
        inc rcx
        cmp rax, 0
        je .print_digits
        jmp .get_digits
    .print_digits:
        cmp rcx, 0
        je .close
        pop rax
        add rax, '0'
        call print_char
        dec rcx
        jmp .print_digits
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

print_hexadecimal:
    push rax
    push rbx
    push rcx
    push rdx

    xor rcx, rcx
    .get_digits:
        mov rdx, rax
        and rdx, 0xF
        add rdx, '0'
        cmp rdx, '9'
        jbe .skip
        add rdx, 7
        .skip:
        push rdx
        inc rcx
        shr rax, 4
        cmp rax, 0
        je .print_digits
        jmp .get_digits
    .print_digits:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_digits
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

print_octal:
    push rax
    push rbx
    push rcx
    push rdx

    xor rcx, rcx
    .get_digits:
        mov rdx, rax
        and rdx, 0x7
        add rdx, '0'
        push rdx
        inc rcx
        shr rax, 3
        cmp rax, 0
        je .print_digits
        jmp .get_digits
    .print_digits:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_digits
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

print_binary:
    push rax
    push rbx
    push rcx
    push rdx

    xor rcx, rcx
    .get_digits:
        mov rdx, rax
        and rdx, 0x1
        add rdx, '0'
        push rdx
        inc rcx
        shr rax, 1
        cmp rax, 0
        je .print_digits
        jmp .get_digits
    .print_digits:
        cmp rcx, 0
        je .close
        pop rax
        call print_char
        dec rcx
        jmp .print_digits
    .close:
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

print_string:
    push rax
    push rcx
    push rdx
    push rsi
    push rdi

    push rax
    call strlen
    mov rdx, rax
    pop rax
    cmp rdx, BUFFER_SIZE
    ja .output_line

    push rax
    call strlen
    movzx rcx, byte [index]
    add rcx, rax
    pop rax
    cmp rcx, BUFFER_SIZE
    jbe .copy_string_to_buffer

    call buffer_reset
    .copy_string_to_buffer:
    mov rsi, rax
    lea rdi, [buffer]
    call strcpy
    jmp .close

    .output_line:
    mov rax, 1
    mov rdi, 1
    mov rsi, rax
    syscall

    .close:
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rax
    ret


strlen:
    push rcx
    push rdx

    xor rcx, rcx
    .find_length:
        mov dl, [rax + rcx]
        cmp dl, 0
        je .done
        inc rcx
        jmp .find_length
    .done:
        mov rax, rcx
        pop rdx
        pop rcx
        ret

strcpy:
    push rax
    push rcx
    push rdx

    movzx rcx, byte [index]
    xor rdx, rdx
    .copy_loop:
        mov al, [rsi + rdx]
        mov [rdi + rcx], al
        inc rcx
        inc rdx
        cmp al, 0
        jne .copy_loop

    mov [index], cl
    pop rdx
    pop rcx
    pop rax
    ret

buffer_reset:
    push rax
    push rcx
    push rdx
    push rdi
    push rsi

    mov rax, 1
    mov rdi, 1
    lea rsi, [buffer]
    mov rdx, BUFFER_SIZE
    syscall

    mov rcx, BUFFER_SIZE
    lea rdi, [buffer]
    xor al, al
    rep stosb
    mov byte [index], 0

    pop rsi
    pop rdi
    pop rdx
    pop rcx
    pop rax
    ret
