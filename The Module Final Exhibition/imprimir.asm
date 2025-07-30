.module imprimir

finProg     .equ 0xFF01
pantalla    .equ 0xFF00

	.globl imprime_cadena
	.globl imprime_byte
	.globl imprime_decimal

tempSalida:       .word 0      
centenas:         .byte 0      
decenas:          .byte 0      

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_cadena                                                      ;
;     Muestra por pantalla la cadena terminada en '\0' apuntada por X ;
;                                                                     ;
;   Entrada: X = dirección de la cadena                               ;
;   Salida:  Ninguna                                                  ;
;   Registros afectados: A, X, CC                                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_cadena:

	    pshs    A,X
	    
	sgte:

	    lda     ,X+
	    beq     ret_imprime_cadena
	    sta     pantalla
	    bra     sgte
	    
	ret_imprime_cadena:

	    puls    A,X,PC
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_byte                                                       ;
;     Muestra por pantalla, en decimal, el número contenido en B     ;
;                                                                    ;
;   Entrada: B = número (0-255)                                      ;
;   Salida:  Imprime número en pantalla en ASCII                     ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_byte:

	    pshs    A,B
	    ldu     #0
	    tfr     B,A
	    ldb     #0
	    
	centenas_1:

	    cmpa    #100
	    blo     fin_cent
	    suba    #100
	    incb
	    bra     centenas_1
	    
	fin_cent:

	    tstb
	    beq     pasar_cent
	    addb    #'0
	    stb     pantalla
	    
	pasar_cent:

	    ldb     #0

	decenas_1:

	    cmpa    #10
	    blo     fin_dec
	    suba    #10
	    incb
	    bra     decenas_1

	fin_dec:

	    tstb
	    beq     pasar_dec
	    addb    #'0
	    stb     pantalla

	pasar_dec:

	    adda    #'0
	    sta     pantalla
	    puls    A,B,PC
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; imprime_decimal                                                    ;
;     Muestra por pantalla, en decimal, el número contenido en       ;
;     el registro D (0-999)                                          ;
;                                                                    ;
;   Entrada: D - número a imprimir (0-999)                           ;
;   Salida:  Ninguna                                                 ;
;   Registros afectados: A, B, X, CC                                 ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

imprime_decimal:

	    pshs    A,B,X
	    std     tempSalida
	    clr     centenas
	    cmpd    #800
	    blo     Menor800
	    inc     centenas
	    subd    #800
	    
	Menor800:

	    lsl     centenas
	    cmpd    #400
	    blo     Menor400
	    inc     centenas
	    subd    #400

	Menor400:

	    lsl     centenas
	    cmpd    #200
	    blo     Menor200
	    inc     centenas
	    subd    #200

	Menor200:

	    lsl     centenas
	    cmpd    #100
	    blo     Menor100
	    inc     centenas
	    subd    #100

	Menor100:

	    tfr     b,a
	    ldb     centenas
	    addb    #'0
	    stb     pantalla

	    clrb
	    cmpa    #80
	    blo     Menor80
	    incb
	    suba    #80
	    
	Menor80:

	    lslb
	    cmpa    #40
	    blo     Menor40
	    incb
	    suba    #40
	    
	Menor40:

	    lslb
	    cmpa    #20
	    blo     Menor20_dec
	    incb
	    suba    #20
	    
	Menor20_dec:

	    lslb
	    cmpa    #10
	    blo     Menor10_dec
	    incb
	    suba    #10
	    
	Menor10_dec:

	    addb    #'0
	    stb     pantalla

	    adda    #'0
	    sta     pantalla
	    puls    A,B,X,PC
