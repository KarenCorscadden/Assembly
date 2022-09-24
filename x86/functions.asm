;-------------------
; void b58cprint(Integer number)
; Base58Check printing function (itoa_base58check)
b58cprint:
        push eax
        push ecx
        push edx
        push esi
        mov ecx, 0

b58cdivLoop:
        inc ecx
        mov edx, 0
        mov esi, 58
        idiv esi
        add edx, 49
        cmp edx, 58
        jl b58cgood
        add edx, 7
        cmp edx, 73
        jl b58cgood
        add edx, 1
        cmp edx, 79
        jl b58cgood
        add edx, 1
        cmp edx, 91
        jl b58cgood
        add edx, 6
	cmp edx, 108
	jl b58cgood
	add edx, 1
b58cgood:
        push edx
        cmp eax, 0
        jnz b58cdivLoop

b58cprintLoop:
        dec ecx
        mov eax, esp
        call sprint
        pop eax
        cmp ecx, 0
        jnz b58cprintLoop

        pop esi
        pop edx
        pop ecx
        pop eax
        ret

;-------------------
; void b64print(Integer number)
; Base64 printing function (itoa_base64)
b64print:
        push eax
        push ecx
        push edx
        push esi
        mov ecx, 0

b64divLoop:
        inc ecx
        mov edx, 0
        mov esi, 64
        idiv esi
        add edx, 65
        cmp edx, 91
        jl b64good
        add edx, 6
	cmp edx, 123
	jl b64good
	sub edx, 75
	cmp edx, 58
	jl b64good
	sub edx, 15
	cmp edx, 44
	jl b64good
	add edx, 3
b64good:
        push edx
        cmp eax, 0
        jnz b64divLoop

b64printLoop:
        dec ecx
        mov eax, esp
        call sprint
        pop eax
        cmp ecx, 0
        jnz b64printLoop

        pop esi
        pop edx
        pop ecx
        pop eax
        ret

;-------------------
; void bprint(Integer number)
; binary printing function (itoab)
bprint:
        push eax
        push ecx
        push edx
        push esi
        mov ecx, 0

bdivLoop:
        inc ecx
        mov edx, 0
        mov esi, 2
        idiv esi
        add edx, 48
        push edx
        cmp eax, 0
        jnz bdivLoop

bprintLoop:
        dec ecx
        mov eax, esp
        call sprint
        pop eax
        cmp ecx, 0
        jnz bprintLoop

        pop esi
        pop edx
        pop ecx
        pop eax
        ret

;-------------------
; void hprint(Integer number)
; hex printing function (itoah)
hprint:
	push eax
	push ecx
	push edx
	push esi
	mov ecx, 0

hdivLoop:
	inc ecx
	mov edx, 0
	mov esi, 16
	idiv esi
	add edx, 48
	cmp edx, 58
	jl hdec
	add edx, 7
hdec:
	push edx
	cmp eax, 0
	jnz hdivLoop

hprintLoop:
	dec ecx
	mov eax, esp
	call sprint
	pop eax
	cmp ecx, 0
	jnz hprintLoop

	pop esi
	pop edx
	pop ecx
	pop eax
	ret

;-------------------
; int atoi(Integer number)
; Ascii to integer function (atoi)
atoi:
	push ebx
	push ecx
	push edx
	push esi
	mov esi, eax
	mov eax, 0
	mov ecx, 0

multiplyLoop:
	xor ebx, ebx
	mov bl, [esi+ecx]
	cmp bl, 48
	jl afinished
	cmp bl, 57
	jg afinished

	sub bl, 48
	add eax, ebx
	mov ebx, 10
	mul ebx
	inc ecx
	jmp multiplyLoop

afinished:
	cmp ecx, 0
	je restore
	mov ebx, 10
	div ebx

restore:
	pop esi
	pop edx
	pop ecx
	pop ebx
	ret

;-------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
	push eax
	push ecx
	push edx
	push esi
	mov ecx, 0

divideLoop:
	inc ecx
	mov edx, 0
	mov esi, 10
	idiv esi
	add edx, 48
	push edx
	cmp eax, 0
	jnz divideLoop

printLoop:
	dec ecx
	mov eax, esp
	call sprint
	pop eax
	cmp ecx, 0
	jnz printLoop

	pop esi
	pop edx
	pop ecx
	pop eax
	ret

;--------------------
; void printLF()
; prints a line feed only

printLF:
	push eax
	mov eax, 0xD
	push eax
	mov eax, esp
	call sprint
	pop eax
	mov eax, 0xA
	push eax
	mov eax, esp
	call sprint
	pop eax
	pop eax
	ret

;------------------------
; int slen(string message)
; string length calc function
slen:
	push ebx
	mov ebx, eax

nextchar:
	cmp byte [eax], 0
	jz finished
	inc eax
	jmp nextchar

finished:
	sub eax, ebx
	pop ebx
	ret

;------------------------
; void sprint(string message)
; string printing function
sprint:
	push edx
	push ecx
	push ebx
	push eax
	call slen

	mov edx, eax
	pop eax

	mov ecx, eax
	mov ebx, 1
	mov eax, 4
	int 80h

	pop ebx
	pop ecx
	pop edx
	ret

;--------------------------------
; void exit()
; exit program and restore resources
quit:
	mov ebx, 0
	mov eax, 1
	int 80h
	ret
