.module main

	.globl imprime_cadena
	.globl leeByte
	.globl carga_mat
	.globl leeDecimal
	.globl imprime_decimal
	.globl imp_mat
	.globl mostrar_columna_maxima
	.globl mostrar_diagonal_menor
	.globl diagonal_dominante

fin              .equ    0xFF01
pantalla         .equ    0xFF00
teclado          .equ    0xFF02
pila             .equ    0xF000
m                .equ    0xE000

.globl     columnas
columnas:   .byte   0
.globl     filas
filas:      .byte   0

elementos:  .word   0

; MENSAJES POR EL MAIN MOSTRADOS MEDIANTE LA SUBRUTINA

titulo: .asciz "\n**Programa que maneja una matriz y la interpreta**\n"

mensaje1: .asciz "\nIntroduce el numero de filas y columnas (max 99): "
mensaje2: .asciz "\n\n**Introduce los elementos de la matriz**\n"
mensaje3: .asciz "\n\n**MATRIZ... CARGADA CORRECTAMENTE!**\n\n"
mensaje4: .asciz "\nLa columna con elemento **MAXIMO**\n" 
mensaje5: .asciz "\n\n**Elementos de la diagonal de menor suma**\n" 
mensaje6: .asciz "\n\nComprobando diagonal dominante..."   
mensajeF: .asciz "\nPresiona **Enter** para salir..."       

programa:

		    lds     #pila           

		    ldx #titulo
		    jsr imprime_cadena

; APARTADO 1

		    ldx     #mensaje1
		    jsr     imprime_cadena
		    jsr     leeByte
		    stb     filas
		    stb     columnas

		    lda     filas
		    ldb     columnas
		    mul
		    std     elementos

		    ldx     #mensaje2
		    jsr     imprime_cadena
		    jsr     carga_mat

; APARTADO 2

		    ldx     #mensaje3
		    jsr     imprime_cadena

		    lda     filas
		    ldb     columnas
		    jsr     imp_mat
	    
; APARTADO 3	    
	    
		    ldx     #mensaje4
		    jsr     imprime_cadena
		    jsr     mostrar_columna_maxima
		    
; APARTADO 4
		    
		    ldx     #mensaje5
		    jsr     imprime_cadena
		    jsr     mostrar_diagonal_menor
		
; APARTADO 5
		
		    ldx     #mensaje6
		    jsr     imprime_cadena
		    jsr     diagonal_dominante
		    
		    ldx     #mensajeF
		    jsr     imprime_cadena
		    jsr     leeByte    
		    lda     #'\n
		    sta     pantalla
		    clra
		    sta     fin

.area FIJA (ABS)
.org 0xFFFE
.word programa
