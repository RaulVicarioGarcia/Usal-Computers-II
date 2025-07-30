.module diagonal_dominante

	    .globl diagonal_dominante
	    .globl filas
	    .globl columnas
	    .globl imprime_cadena
	    .globl m
	    .globl pantalla
    
pantalla    .equ 0xFF00
m           .equ 0xE000

fila_actual:    .byte 0
columna_actual: .byte 0
suma_fila:      .word 0
elemento_diag:  .word 0
es_dominante:   .byte 1

mensajeNegativo:    .asciz "\nLa matriz NO es **diagonal dominante**"
mensajePositivo:    .asciz "\nLa matriz SI es **diagonal dominante**"

diagonal_dominante:

	    pshs X,Y,D,U       

	    lda #1
	    sta es_dominante      

	    clr fila_actual
	    
	bucle_filas:
	    
	    lda fila_actual
	    cmpa filas
	    bhs fin_bucle_filas
	    
	    clrw suma_fila
	    
	    ldx #m              
	    lda fila_actual
	    ldb columnas
	    mul                
	    lslb                  
	    rola
	    leax D,X              
	    
	    tfr X,U              
	    
	    clr columna_actual
	    
	bucle_columnas:
	    
	    lda columna_actual
	    cmpa columnas
	    bhs fin_bucle_columnas 
	    
	    lda columna_actual
	    cmpa fila_actual
	    beq es_diagonal
	    
	    ldd ,X
	    addd suma_fila
	    std suma_fila
	    
	avanzar_columna:
	
	    leax 2,X               
	    inc columna_actual
	    bra bucle_columnas
	    
	es_diagonal:
	
	    ldd ,X
	    std elemento_diag
	    bra avanzar_columna
	    
	fin_bucle_columnas:
	
	    ldd elemento_diag
	    cmpd suma_fila
	    bge fila_ok
	    
	    clr es_dominante
	    bra fin_bucle_filas
	    
	fila_ok:

	    inc fila_actual
	    bra bucle_filas
	    
	fin_bucle_filas:

	    tst es_dominante
	    beq no_es_dominante
	    
	    ldx #mensajePositivo
	    bra imprimir
	    
	no_es_dominante:

	    ldx #mensajeNegativo
	    
	imprimir:
	
	    jsr imprime_cadena
	    lda #'\n
	    sta pantalla
	    
	    puls X,Y,D,U,PC     
