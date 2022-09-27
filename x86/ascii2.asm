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

	mov esi, eax
	mov eax, 0
	mov ecx, 0
	push edx
readit:
	xor ebx, ebx
	mov bl, [sinput + ecx]
	cmp bl, 44
	je comma
	cmp bl, 48
	jl zero
	cmp bl, 57
	jg zero
	sub bl, 48
	mov al, bl
	mov dl, 10
	mul dl
	xor ebx, ebx
	inc ecx
	mov bl, [sinput + ecx]
	cmp bl, 44
	je comma
	cmp bl, 48
	jl zero
	cmp bl, 57
	jg zero
	sub bl, 48
	add al, bl
	mov dl, 10
	mul dl
	xor ebx, ebx
	inc ecx
	mov bl, [sinput + ecx]
	cmp bl, 44
	je comma
	cmp bl, 48
	jl zero
	cmp bl, 57
	jg zero
	sub bl, 48
	add al, bl
	mov dl, 10
	mul dl
	inc ecx
comma:
	mov dl, 10
	div dl
	pop edx
	mov [soutput + edx], al
	inc edx
	push edx
	xor edx, edx
	cmp al, 0
	je zero
	inc ecx
	jmp readit

zero:
	mov eax, soutput
	call sprint
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
soutput: resb	255
