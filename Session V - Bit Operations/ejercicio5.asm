.area PROG (ABS)



fin        .equ 0xFF01

pantalla   .equ 0xFF00

teclado    .equ 0xFF02



num:       .word 0       ; Variable para almacenar el número (inicializado a 0)

temp: .word 0     ; Variable para almacenar el número impar actual

msg_si:    .ascii "SI"   ; Mensaje de éxito

           .byte 0x0A, 0x00

msg_no:    .ascii "NO"   ; Mensaje de fallo

           .byte 0x0A, 0x00



.org 0x100

.globl programa



programa:



; leer1

    lda  teclado       ; Leer carácter del teclado

    suba #'0'          ; Convertir de ASCII a dígito

    ldb  #50

    MUL                ; D = A*B  => (dígito * 50)

    lda  #200

    MUL                ; D = D*A  => anterior * 200

    std  num      ; Guardar en "numero"



; leer2

    lda  teclado

    suba #'0'

    ldb  #20

    MUL                ; (dígito * 20)

    lda  #50

    MUL                ; anterior * 50

    addd num        ; sumar a lo que había

    std  num



; leer3

    lda  teclado

    suba #'0'

    ldb  #100

    MUL                ; (dígito * 100)

    addd num       ; sumar a "numero"

    std  num



; leer4

    lda  teclado

    suba #'0'

    ldb  #10

    MUL                ; (dígito * 10)

    addd num

    std  num



; leer5

    ldb  teclado

    subb #'0'

    clra               ; A = 0 => D=(A:B)=(0:B)

    addd num

    std  num



    ldd num          ; Cargar el número en D

    beq encontrado  

    ldx #1           ; Inicializar current_odd a 1

    stx temp



check_loop:

    subd temp ;

    beq encontrado   ; Si D == 0, es cuadrado

    blt no_encontrado ; Si D < 0, no es cuadrado

    ldx temp

    leax 2,x         ; Siguiente número impar (sumar 2)

    stx temp

    bra check_loop   ; Repetir



no_encontrado:

    lda #0x0A        ; Cargar el carácter de nueva línea (LF)

    sta pantalla     ; Imprimir nueva línea

    ldx #msg_no      ; X apunta a "NO"

    bra imprimir



encontrado:

    lda #0x0A        ; Cargar el carácter de nueva línea (LF)

    sta pantalla     ; Imprimir nueva línea

    ldx #msg_si      ; X apunta a "SI" (cuando n=217)

    bra imprimir





imprimir:

    lda ,x+         

    beq final      

    sta pantalla     ; Imprimir carácter en pantalla

    bra imprimir 



final:

    clra

    sta fin          ; Terminar programa 



.org 0xFFFE

.word programa