.module carga_mat

m 		.equ 0xE000

	.globl carga_mat
	.globl leeDecimal
	.globl imprime_cadena

tam: .word 0
contador: .word 0

dato: .asciz"\n| Elemento |: "

carga_mat:

		ldy #m
		std tam
		ldd #0
		std contador
		
	buclecarga:

		ldx #dato
		jsr imprime_cadena
		jsr leeDecimal
		std ,y++
		
		ldd contador
		addd #1
		std contador						
		cmpd tam
		bne buclecarga
							
		rts

