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
	write	msg1, len1
	write	msg2, len2
	write	msg3, len3

	mov	eax, 1
	int	0x80

section	.data

msg1	db	"GET /php/asm1.php?u=admin&p=password HTTP/1.1",0xD,0xA
len1	equ	$ - msg1
msg2	db	"Host: target1.bowneconsulting.com",0xD,0xA
len2	equ	$ - msg2
msg3	db	"User-Agent: ASMCODE",0xD,0xA,0xD,0xA
len3	equ	$ - msg3

