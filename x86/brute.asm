%macro write 2
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, %1
	mov	edx, %2
	int	80h
%endmacro

section .text
global	_start

_start:
	mov ecx, 10
	mov eax, '0'
	mov [num], eax

l1:
	push ecx
	write	msg1, len1
	write	num, 1
	write	msg4, len4
	write	msg2, len2
	write	msg3, len3

	inc byte [num]

	pop ecx
	loop l1

	mov	eax, 1
	int	0x80

section	.data

msg1	db	"GET /php/asm2.php?u=admin&p=password"
len1	equ	$ - msg1
msg4	db	" HTTP/1.1",0xD,0xA
len4	equ	$ - msg4
msg2	db	"Host: target1.bowneconsulting.com",0xD,0xA
len2	equ	$ - msg2
msg3	db	"User-Agent: ASMCODE",0xD,0xA,0xD,0xA
len3	equ	$ - msg3

section .bss
num resb 1
