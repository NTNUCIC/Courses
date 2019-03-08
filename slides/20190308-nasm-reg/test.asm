%include "asm_io.inc"

segment .data	
	str1	db	"Hello Assembly World!",0

segment .bss

segment .text
	global asm_main
asm_main:
	enter		0,0
	pusha

	mov		eax, str1	;str1 is an address
	call	print_string;print the string at that address
	call	print_nl	;print a new line

	pusha
	popa
	mov		eax, 0
	leave
	ret

