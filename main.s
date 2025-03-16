section .bss
    BUFFER_SIZE equ 128
    buffer resb BUFFER_SIZE
    index resb 1

section .data
    input db "assembly %% %c %b %x %s llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll", 0xA, 0
    char dq 'f'
    decimal dq 20
    hexadecimal dq 0x5B2A
    line db " Hello world! ", 0

section .text

global _start

_start:
    lea rsi, [line]
    push rsi
    push qword [hexadecimal]
    push qword [decimal]
    push qword [char]
    lea rsi, [input]
    push rsi
    call my_printf
    add rsp, 16

    mov rax, 60
    syscall

my_printf:
    mov rax, [rsp + 8]
    lea rbx, [rsp + 16]
    mov byte [index], 0

    xor rcx, rcx
    .loop:
        cmp [rax], byte 0
        je .close
        cmp [rax], byte '%'
        je .specifier
        jmp .print_default_char

        .specifier:
            inc rax
            cmp [rax], byte 'c'
            je .print_char
            cmp [rax], byte 'd'
            je .print_decimal
            cmp [rax], byte 'x'
            je .print_hexadecimal
            cmp [rax], byte 'o'
            je .print_octal
            cmp [rax], byte 'b'
            je .print_binary
            cmp [rax], byte 's'
            je .print_string
            cmp [rax], byte '%'
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
            mov rax, [rax]
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
        ret

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
    ja .output_line ; строка длиннее буфера

    push rax
    call strlen
    movzx rcx, byte [index]
    add rcx, rax
    pop rax
    cmp rcx, BUFFER_SIZE
    jbe .copy_string_to_buffer ; есть свободное место в строке

    ; нет свободного места в строке
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
