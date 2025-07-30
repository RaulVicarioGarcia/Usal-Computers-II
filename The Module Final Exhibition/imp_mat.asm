.module imp_mat

m 		.equ 0xE000
pantalla        .equ 0xFF00  

	.globl imprime_decimal
	.globl imp_mat

contfilas: .word 0
contcol: .word 0
columnas: .byte 0
filas: .byte 0

imp_mat:

		ldy #m
		sta filas
		stb columnas
		clra
		clrb
		
	buclefilimp:

		ldb contfilas
		cmpb filas
		bge fin_filas
		ldb #0
		stb contcol
		
		buclecolimp:
		
			ldb contcol
			cmpb columnas
			bge fin_col
			clrb
			ldb #'\t
			stb pantalla
			ldd #0
			ldd ,y++
			jsr imprime_decimal
			ldd #0
			ldb contcol
			incb 
			stb contcol
			bra buclecolimp
			
		fin_col:
		
		clrb
		ldb #'\n
		stb pantalla
		
		ldb contfilas
		incb
		stb contfilas
		bra buclefilimp
		fin_filas:
		ldb #0
		stb contfilas
		ldb #0
		stb contcol

		rts
