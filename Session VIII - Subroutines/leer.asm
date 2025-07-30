.module leer

fin         .equ    0xFF01
pantalla    .equ    0xFF00
teclado     .equ    0xFF02

.globl leeByte
.globl leeDecimal

temp:       .word   0   ; Variable temporal para almacenar resultados

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; leeByte                                                          ;
;     Lee un número decimal tecleado por el usuario (máximo 255)   ;
;     El número se devuelve en el registro B                        ;
;                                                                  ;
;   Entrada: Ninguna                                               ;
;   Salida:  B = número leído (0-255)                               ;
;   Registros afectados: A, B, X, CC                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

leeByte:

    pshs    a,x              ; Guarda A y X en la pila
    ldx     #0
    stx     temp            

    lda     teclado         
    suba    #'0'             ; Convierte de ASCII a número (0–9)
    ldb     #100
    MUL                     ; D = A * 100
    std     temp             ; Guarda resultado parcial en temp

    lda     teclado
    suba    #'0'
    ldb     #10
    MUL                     ; D = A * 10
    addd    temp             ; Suma a temp
    std     temp

    lda     teclado
    cmpa    #'\n'    
    beq     fin_leeByte

    suba    #'0'   
    tfr     a,b
    clra
    addd    temp             ; Suma a temp el último dígito
    std     temp

    cmpd    #255        
    bls     fin_leeByte
    ldd     #255        
    std     temp

fin_leeByte:

    ldd     temp             ; Carga el número leído
    ldb     temp+1           ; Extrae sólo el byte bajo (0–255)
    puls    a,x,pc           ; Restaura registros y vuelve

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; leeDecimal                                                       ;
;     Lee un número decimal tecleado por el usuario (máximo 999)   ;
;     El número se devuelve en el registro D                        ;
;                                                                  ;
;   Entrada: Ninguna                                               ;
;   Salida:  D = número leído (0-999)                               ;
;   Registros afectados: A, D, X, CC                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

leeDecimal:

    pshs    x
    ldx     #0
    stx     temp     

    lda     teclado
    suba    #'0'
    ldb     #100
    MUL               
    std     temp

    lda     teclado
    suba    #'0'
    ldb     #10
    MUL         
    addd    temp        ; D = D + temp
    std     temp

    lda     teclado
    suba    #'0'
    tfr     a,b
    clra
    addd    temp
    std     temp

    cmpd    #999
    bls     fin_leeDecimal
    ldd     #999
    
fin_leeDecimal:

    puls    x,pc
