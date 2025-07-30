.area PROG (ABS)

fin     .equ 0xFF01
pantalla .equ 0xFF00
teclado .equ 0xFF02
menor	.equ 0xF100

        .org 0x100

        .globl programa
        
programa:
        
        ldx #0xE000
        
leer:   

	lda teclado
	sta ,x+
        cmpa #'\n            
        beq buscarmenor     
        bra leer
        
buscarmenor:

	ldx #0xE000
	lda #255
	sta menor

buclemenor:

	lda, x+
	cmpa #'\n
	beq mostrarmenor
	bita #0x80
	bne buclemenor
	cmpa menor
	bhs buclemenor
	sta menor
	bra buclemenor
	
mostrarmenor:

	lda menor
	cmpa #255
	beq acabar
	sta pantalla
	
	ldx #0xE000
	
marcarmenor:

	lda, x+
	cmpa #'\n
	beq buscarmenor
	cmpa menor
	bne marcarmenor
	ora #0x80
	sta -1,x
	bra marcarmenor

acabar:

        lda ,x+          
        cmpa #'\n      

        clra
        sta fin             ; Finalizar programa

        .org 0xFFFE         ; Vector de RESET
        .word programa
