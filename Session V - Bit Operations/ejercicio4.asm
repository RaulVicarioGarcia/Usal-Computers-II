.area PROG (ABS)

fin     .equ 0xFF01
pantalla .equ 0xFF00
teclado .equ 0xFF02
temp:    .word 0  
        .org 0x100
        .globl programa

programa:
    lda teclado
    suba #48
    ldb #50
    mul
    lda #200
    mul
    std temp

    lda teclado
    suba #48
    ldb #20
    mul
    lda #50
    mul
    addd temp
    std temp

    lda teclado
    suba #48
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
    subb #48
    clra
    addd temp
    std temp

    ; Comprobar si la penúltima cifra en binario es 0
    lda temp+1       ; Obtener el byte alto de la palabra
    anda #0x02
    beq verificar       ; Mascarar para verificar el segundo bit desde la izquierda
    beq verificar    ; Si es 0, continuar con la verificación
    bra no           ; Si no es 0, no puede ser cuadrado perfecto

verificar:
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
    lda #78  ; 'N'
    sta pantalla
    lda #79  ; 'O'
    sta pantalla
    lda #10  ; Salto de línea (ASCII)
    sta pantalla
    bra acabar

si:
    lda #83  ; 'S'
    sta pantalla
    lda #73  ; 'I'
    sta pantalla
    lda #10  ; Salto de línea (ASCII)
    sta pantalla
    bra acabar

acabar:
    clra
    sta fin

    .org 0xFFFE
    .word programa
