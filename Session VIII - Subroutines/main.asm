.module main

fin         .equ    0xFF01
pantalla    .equ    0xFF00
teclado     .equ    0xFF02

.globl programa
.globl imprime_cadena
.globl imprime_byte
.globl imprime_decimal
.globl leeByte
.globl leeDecimal

titulo:     .asciz  "Programa ejemplo del funcionamiento de mis subrutinas\n"
com:        .asciz  "Introduce un numero (max 255): "
com2:       .asciz  "El numero es "
com3:       .asciz  "\nIntroduce un numero (max 999): "
com4:       .asciz  "El numero es "
salto:      .asciz  "\n"

programa:
    lds     #0xF000
    
    ldx     #titulo
    jsr     imprime_cadena
    
    ldx     #com
    jsr     imprime_cadena
    jsr     leeByte    
        
    ldx     #com2
    jsr     imprime_cadena
    jsr     imprime_byte
    
    ldx     #salto
    jsr     imprime_cadena
    
    ldx     #com3
    jsr     imprime_cadena
    jsr     leeDecimal
    
    ldx     #com4
    jsr     imprime_cadena
    jsr     imprime_decimal
    
    ldx     #salto
    jsr     imprime_cadena
    
    clra
    sta     fin

.area FIJA (ABS)
.org 0xFFFE
.word programa

