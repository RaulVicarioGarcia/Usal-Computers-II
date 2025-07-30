.module imprimir

fin         .equ 0xFF01
pantalla    .equ 0xFF00
teclado     .equ 0xFF02

    .globl imprime_cadena
    .globl imprime_byte
    .globl imprime_decimal
    
; Imprime_decimal se corresponde con la subrutina decimal dada en clase, ya que el algoritmo de comparaciones por menores lo uso en la practica final aqui hago algo distinto.

; Variables para almacenamiento temporal ( distinto )

temp_imprimir:       .word 0      
cent:       .byte 0      
dec:        .byte 0      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_decimal                                                  ;
;     Muestra por pantalla, en decimal, el número contenido en     ;
;     el registro D (0-999)                                          ;
;                                                                  ;
;   Entrada: D - número a imprimir (0-999)                           ;
;   Salida:  Ninguna                                                 ;
;   Registros afectados: A, B, X, CC                                  ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_decimal:

    pshs    a,b,x
    std     temp_imprimir
    clr     cent

centenas:

    cmpd    #100        
    blo     fin_centenas
    subd    #100      
    inc     cent
    bra     centenas
    
fin_centenas:

    pshs    d

    lda     cent
    adda    #'0'
    sta     pantalla
    puls    d
    clr     dec
    
decenas:

    cmpd    #10
    blo     fin_decenas
    subd    #10       
    inc     dec
    bra     decenas
    
fin_decenas:

    lda     dec
    adda    #'0'
    sta     pantalla

    addb    #'0'
    stb     pantalla

    ldd     temp_imprimir
    puls    a,b,x,pc
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_cadena                                                   ;
;     Muestra por pantalla la cadena terminada en '\0' apuntada por X ;
;                                                                  ;
;   Entrada: X = dirección de la cadena                            ;
;   Salida:  Ninguna                                                 ;
;   Registros afectados: A, X, CC                                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_cadena:
    pshs    a,x
    
sgte:   

    lda     ,x+
    beq     ret_imprime_cadena
    sta     pantalla
    bra     sgte
    
ret_imprime_cadena:

    puls    a,x,pc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_byte                                                      ;
;     Muestra por pantalla, en decimal, el número contenido en B   ;
;                                                                  ;
;   Entrada: B = número (0-255)                                    ;
;   Salida:  Imprime número en pantalla en ASCII                   ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_byte:

    pshs a,b

    ldu #0        
    tfr b,a     
    ldb #0
    
cent_bucle:

    cmpa #100
    blo fin_cent
    suba #100
    incb
    bra cent_bucle
    
fin_cent:

    tstb
    beq pasar_cent
    addb #'0'
    stb pantalla
    
pasar_cent:

    ldb #0
    
dec_bucle:

    cmpa #10
    blo fin_dec
    suba #10
    incb
    bra dec_bucle
    
fin_dec:

    tstb
    beq pasar_dec
    addb #'0'
    stb pantalla
    
pasar_dec:
    
    adda #'0'
    sta pantalla

    puls a,b,pc

