.area PROG (ABS)
        ; definimos una constante
fin     .equ 0xFF01
pantalla .equ 0xFF00
numero  .equ 0x0010     ; Dirección de memoria para almacenar el número
        
        .org 0x100
        .globl programa
programa:
        ; Cargamos un número de prueba (567) directamente en memoria
        lda #2          ; Parte alta (2*256 = 512)
        ldb #55         ; Parte baja (55)
        std numero      ; Guardamos en memoria: 512 + 55 = 567
        
        ; PRIMERA CIFRA (centenas)
        ; Inicializamos el contador de centenas
        lda #0
        sta numero+2    ; Almacenamos contador en memoria
        
        ; Bucle para contar centenas
bucle_cent:
        ldd numero      ; Cargamos el número actual
        cmpd #100       
        blo fin_cent    ; Si es menor que 100, salimos
        subd #100       ; Restamos 100
        std numero      ; Guardamos el resultado
        inc numero+2    ; Incrementamos contador de centenas
        bra bucle_cent
        
fin_cent:
        lda numero+2    ; Cargamos el contador de centenas
        adda #'0        ; Convertimos a ASCII
        sta pantalla    ; Mostramos el dígito
        
        ; SEGUNDA CIFRA (decenas)
        ; Inicializamos el contador de decenas
        lda #0
        sta numero+2    ; Almacenamos contador en memoria
        
        ; Bucle para contar decenas
bucle_dec:
        ldd numero      ; Cargamos el número actual
        cmpd #10
        blo fin_dec     ; Si es menor que 10, salimos
        subd #10        ; Restamos 10
        std numero      ; Guardamos el resultado
        inc numero+2    ; Incrementamos contador de decenas
        bra bucle_dec
        
fin_dec:
        lda numero+2    ; Cargamos el contador de decenas
        adda #'0        ; Convertimos a ASCII
        sta pantalla    ; Mostramos el dígito
        
        ; TERCERA CIFRA (unidades)
        lda numero+1    ; Cargamos las unidades (byte bajo de numero)
        adda #'0        ; Convertimos a ASCII
        sta pantalla    ; Mostramos el dígito
        
        ; Salto de línea
        lda #'\n
        sta pantalla
        
        ; Fin del programa
        clra
        sta fin
        
        .org 0xFFFE     ; vector de RESET
        .word programa
