.area PROG (ABS)
.org 0x100

pantalla  .equ 0xFF00  ; Dirección de salida a pantalla
teclado   .equ 0xFF02  ; Dirección de entrada desde teclado
fin       .equ 0xFF01  ; Dirección para finalizar el programa
.globl programa

num:      .byte 0      ; Numero a decrementar
temp:     .byte 0      ; Variable temporal

programa:
    lda #9            ; Cargar el valor inicial 9 en el acumulador A
    sta num           ; Almacenar el valor inicial en la variable num
    
bucle:
    lda num           ; Cargar el valor actual de num en A
    adda #48          ; Convertir a ASCII (48 es el código ASCII de '0')
    sta pantalla      ; Mostrar el carácter en pantalla

    ; Decrementar el contador
    lda num           ; Cargar el valor actual de num en A
    deca              ; Decrementar el valor de A
    sta num           ; Almacenar el nuevo valor en num
    
    cmpa #255         ; Comparar si hemos llegado a -1
    bne bucle         ; Si no es -1, continuar el bucle
    
    ; Finalizar programa
acabar:
    clra              ; Limpiar acumulador A
    sta fin           ; Finalizar el programa
    
.org 0xFFFE           ; Vector de RESET
.word programa
