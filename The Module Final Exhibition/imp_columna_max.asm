.module imp_columna_max
                             
	.globl mostrar_columna_maxima                       
	.globl columnas
	.globl filas
	.globl imprime_decimal            

pantalla    .equ 0xFF00                             
m           .equ 0xE000                             
                     
max_col:         .byte 0                     
col_actual:      .byte 0                            
fil_actual:      .byte 0                       
tiene_maximo:    .byte 0      
max_val:         .word 0  
min_suma:        .word 0                           
sum_col:         .word 0                                                 
salto_fila:      .word 0                             

mostrar_columna_maxima:

    pshs  A,B,X                                  
    ldd   #0                                   
    std   max_val                                 
    clr   max_col                                 
    ldy   #m                                      
    clr   col_actual                              
    clr   fil_actual                             

busca_max:

	    ldd   ,Y                                      
	    cmpd  max_val                                 
	    bls   continuar                                
	    std   max_val                                 
	    lda   col_actual                              
	    sta   max_col                                 

	continuar:
	
	    leay  2,Y                                     
	    inc   col_actual                              
	    lda   col_actual                         
	    cmpa  columnas                                
	    blo   columna_valida                        
	    clr   col_actual                             
	    inc   fil_actual                             

	columna_valida:
	
	    lda   fil_actual                              
	    cmpa  filas                                  
	    blo   busca_max                               

	    lda   columnas                                 
	    lsla                                          
	    tfr   A,B                                     
	    clra                                          
	    std   salto_fila                              

	    ldd   #0xFFFF                                 
	    std   min_suma                                
	    clr   col_actual                              

	bucle_col:
	
	    ldd   #0                                       
	    std   sum_col                                 
	    clr   tiene_maximo                            
	    clr   fil_actual                               

	    ldb   col_actual                              
	    lslb                                         
	    ldx   #m                                      
	    abx                                           

	suma_filas:
	
	    ldd   ,X                                      
	    cmpd  max_val                                 
	    bne   no_max                                   
	    lda   #1                                       
	    sta   tiene_maximo                            

	no_max:
	
	    addd  sum_col                                  
	    std   sum_col                                  
	    ldd   salto_fila                              
	    leax  D,X                                      
	    inc   fil_actual                               
	    lda   fil_actual                              
	    cmpa  filas                                   
	    blo   suma_filas                              

	    lda   tiene_maximo                           
	    beq   sig_col                                

	    ldd   sum_col                                
	    cmpd  min_suma                                
	    bhs   sig_col                                
	    std   min_suma                               
	    lda   col_actual                            
	    sta   max_col                               

	sig_col:
	
	    inc   col_actual                               
	    lda   col_actual                              
	    cmpa  columnas                                
	    blo   bucle_col                                

	    lda   #'\n                                    
	    sta   pantalla                                

	    ldb   max_col                                  
	    lslb                                         
	    ldx   #m                                       
	    abx                                           

	    ldb   filas                                    
	    pshs  B                                       

	imprime_col:
	
	    ldd   ,X                                     
	    jsr   imprime_decimal                        
	    lda   #'\t                                    
	    sta   pantalla                                 
	    ldd   salto_fila                               
	    leax  D,X                                      
	    dec   ,S                                       
	    bne   imprime_col                              

	    puls  B                                       
	    puls  A,B,X,PC                                
