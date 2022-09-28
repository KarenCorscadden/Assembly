%include 'functions.asm'

section  .text
global   _start

_start:
    mov eax, 0
    push eax
    push eax

Oloop:
    pop eax
    pop ebx
    inc ebx
    mov eax, 0 ; initialize counter on stack
    push ebx
    push eax

    mov  eax, 5           ; 5 = sys_open
    mov  ebx, filename
    mov  ecx, 0	          ; Read Only Mode
    int  0x80

    mov [fd], eax         ; file descriptor

Nloop:
    mov edx, 1
    mov ecx, fread
    mov ebx, [fd]
    mov eax, 3 ; sys_read 1 byte
    int 80h

    cmp eax, 0
    je Oloop

    mov [fd], ebx ; save new file descriptor
    mov eax, [fread]

    pop eax ; previous iterations
    inc eax ; add 1
    pop ebx
    cmp eax, ebx ; char count to loop on
    push ebx
    push eax
    jne Nloop

    mov edx, 1
    mov ecx, fread
    mov ebx, 1
    mov eax, 4
    int 80h

    pop eax
    mov eax, 0
    push eax
    mov eax, [fread]
    cmp eax, 1
    jne Nloop

Exit:
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
flag resb 7
fread resb 1
