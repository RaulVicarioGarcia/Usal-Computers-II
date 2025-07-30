.module leer

fin         .equ    0xFF01
teclado     .equ    0xFF02

	.globl leeByte
	.globl leeDecimal

temporal:   .word   0

num1: .byte 0
num2: .byte 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; leeByte                                                            ;
;     Lee un número decimal tecleado por el usuario (máximo 255)     ;
;     El número se devuelve en el registro B                         ;
;                                                                    ;
;   Entrada: Ninguna                                                 ;
;   Salida:  B = número leído (0-255)                                ;
;   Registros afectados: A, B, X, CC                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

leeByte:

	    	lda teclado
		suba #48
		sta num1
		lda teclado
		suba #48
		sta num2

		ldb #10
		lda num1
		mul
		addb num2
		
		rts
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; leeDecimal                                                         ;
;     Lee un número decimal tecleado por el usuario (máximo 999)     ;
;     El número se devuelve en el registro D                         ;
;                                                                    ;
;   Entrada: Ninguna                                                 ;
;   Salida:  D = número leído (0-999)                                ;
;   Registros afectados: A, D, X, CC                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

leeDecimal:

	    pshs    X
	    ldx     #0
	    stx     temporal

	    lda     teclado
	    suba    #'0
	    ldb     #100
	    MUL
	    std     temporal

	    lda     teclado
	    suba    #'0
	    ldb     #10
	    MUL
	    addd    temporal
	    std     temporal

	    lda     teclado
	    suba    #'0
	    tfr     A, B
	    clra
	    addd    temporal
	    std     temporal

	    cmpd    #999
	    bls     fin_leeDecimal
	    ldd     #999

	fin_leeDecimal:
	
	    puls    X, PC
