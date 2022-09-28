%include 'functions.asm'

section  .text
global   _start

_start:

    mov  eax, 5           ; 5 = sys_open
    mov  ebx, filename
    mov  ecx, 0	          ; Read Only Mode
    int  0x80

    mov [fd], eax         ; file descriptor

    mov edx, 0 ; seek beginning
    mov ecx, 229 ; move cursor 229 bytes (starts at byte 1)
    mov ebx, [fd]
    mov eax, 19 ; sys_lseek
    int 80h

    mov [fd], ebx

    mov edx, 6 ; read 6 bytes
    mov ecx, file_read
    mov ebx, [fd]
    mov eax, 3 ; sys read
    int 80h

    mov eax, file_read
    call sprint
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
file_read resb 7
