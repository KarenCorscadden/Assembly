section .text
global _start

_start:

	mov edx, len_buf_in
	mov ecx, buf_in
	mov ebx, 1
	mov eax, 3
	int 0x80

	mov al, [buf_in]
	call print_c
	shl al, 1
	call print_c
	add al, al
	call print_c
	mov [buf_out], al

	mov edx, len_buf_out
	mov ecx, buf_out
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov eax, 1
	int 0x80

print_c:
	push eax
	mov [print_cs+5], al
	mov edx, len_print_cs
	mov ecx, print_cs
	mov ebx, 1
	mov eax, 4
	int 0x80
	pop eax
	ret

section .data

	buf_in	db "	", 10, 13
	len_buf_in equ $ - buf_in
	buf_out db "	", 10, 13
	len_buf_out equ $ - buf_out

	print_cs db " D:	", 10, 13
	len_print_cs equ $ - print_cs
