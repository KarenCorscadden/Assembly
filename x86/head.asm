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

	mov	eax, 1
	int	0x80

section	.data

msg1	db	"HEAD / HTTP/1.1",0xD,0xA
len1	equ	$ - msg1
msg2	db	"Host: ad.samsclass.info",0xD,0xA,0xD,0xA
len2	equ	$ - msg2

