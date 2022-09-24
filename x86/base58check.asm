%include 'functions.asm'

section .text
global _start

_start:
	mov edx, 255
	mov ecx, sinput
	mov ebx, 0
	mov eax, 3
	int 80h

	mov edx, 0
	mov eax, sinput
	call atoi

	call b58cprint
	call printLF
	call quit

section .data

	buf_in	db "	", 10, 13
	len_buf_in equ $ - buf_in
	buf_out db "	", 10, 13
	len_buf_out equ $ - buf_out

	print_cs db " D:	", 10, 13
	len_print_cs equ $ - print_cs

section .bss
sinput:	resb	255
