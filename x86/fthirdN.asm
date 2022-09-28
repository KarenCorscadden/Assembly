%include 'functions.asm'

section  .text
global   _start

_start:

    mov  eax, 5           ; 5 = sys_open
    mov  ebx, filename
    mov  ecx, 0	          ; Read Only Mode
    push ecx
    int  0x80

    mov [fd], eax         ; file descriptor

Nloop:
   ; mov edx, 1 ; seek current location
   ; mov ecx, 1 ; move cursor forward 1 byte
  ;  mov ebx, [fd]
 ;   mov eax, 19 ; sys_lseek
;    int 80h

    mov edx, 1
    mov ecx, fread
    mov ebx, [fd]
    mov eax, 3 ; sys_read 1 byte
    int 80h

    mov [fd], ebx ; save new file descriptor
    mov eax, [fread]
    cmp eax, 78
    jne Nloop

    pop eax ; previous number of Ns
    inc eax ; add 1
    push eax
    cmp eax, 3
    jne Nloop

    mov edx, 6 ; read 6 bytes
    mov ecx, flag
    mov ebx, [fd]
    mov eax, 3 ; sys read
    int 80h

    mov eax, flag
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
flag resb 7
fread resb 1
