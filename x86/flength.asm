%include 'functions.asm'

section  .text
global   _start

_start:

    mov  eax, 5           ; 5 = sys_open
    mov  ebx, filename
    mov  ecx, 0	          ; Read Only Mode
    int  0x80

    mov [fd], eax         ; file descriptor
    mov ebx, [fd]
    mov eax, $6c
    mov ecx, file_stat
    int $80
    mov edx, [file_stat+$14]

    mov eax, edx
    call hprint
    call printLF

    mov  eax, 6           ; 6 = sys_close
    mov  ebx, [fd]
    int  0x80

    call quit

section  .data
filename db   "ASM120", 0
msg      db   "Hello World!"
len      equ  $ - msg
fd       db   0, 0, 0, 0

section .bss
file_stat resd $10
