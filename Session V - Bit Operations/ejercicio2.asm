.area PROG (ABS)

        ; definimos una constante
        
fin     .equ 0xFF01
pantalla .equ 0xFF00
teclado .equ 0xFF02
temp:	.word 0  

        .org 0x100
        .globl programa
        
programa:

	lda teclado
	suba #'0
	
	ldb #50
	mul
	lda #200
	mul
	std temp
	
	lda teclado
	suba #'0
	
	ldb #20
	mul
	lda #50
	mul
	addd temp
	std temp
	
	lda teclado
	suba #'0
	ldb #100
	mul
	addd temp
	std temp
	
	lda teclado
	suba #'0
	ldb #10
	mul
	addd temp
	std temp
	
	ldb teclado
	subb #'0
	clra
	addd temp
	std temp
	
	clra
	clrb
	
bucle:

	tfr d,x
	mul
	cmpd temp
	beq si
	bhi no
	tfr x,d
	inca
	incb
	bra bucle
	
no:

   	lda #'N         ; Carga la letra 'N'
    	sta pantalla     ; Muestra 'N'
    	lda #'O         ; Carga la letra 'O'
    	sta pantalla     ; Muestra 'O'
    	lda #'\n        ; Salto de línea
    	sta pantalla     ; Imprime el salto de línea
    	bra acabar          ; Salta al fin del programa
	
si:

    	lda #'S         
    	sta pantalla     
    	lda #'I         
    	sta pantalla     
    	lda #'\n        ; Salto de línea
    	sta pantalla     ; Imprime el salto de línea
	bra acabar
	
acabar:     
        
        clra
        sta fin
        
        .org 0xFFFE     ; vector de RESET
        .word programa
