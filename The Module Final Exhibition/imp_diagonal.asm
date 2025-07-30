.module imp_diagonal   

	.globl mostrar_diagonal_menor                    
	.globl filas
	.globl columnas 
	.globl imprime_decimal          

pantalla    .equ 0xFF00                         
m           .equ 0xE000                         

.area BSS                                       
suma_principal:    .word 0                      
suma_secundaria:   .word 0                      
contador_diagonal: .byte 0                      
min_fil_col:       .byte 0                      

mostrar_diagonal_menor:                         
	   
	    pshs  X,Y,D                                  

	    lda   filas                                 
	    cmpa  columnas                              
	    blo   filas_menor                           
	    lda   columnas 
		                         
	filas_menor:

	    sta   min_fil_col                           

	    ldd   #0                                    
	    std   suma_principal                        
	    ldx   #m                                    
	    clr   contador_diagonal                     

	bucle_suma_principal:  
		                  
	    ldd   ,X                                    
	    addd  suma_principal                        
	    std   suma_principal                        

	    lda   columnas                              
	    inca                                       
	    lsla                                       
	    leax  A,X                                   
	    inc   contador_diagonal                    
	    lda   contador_diagonal                    
	    cmpa  min_fil_col                          
	    blo   bucle_suma_principal                  

	    ldd   #0                                    
	    std   suma_secundaria                       
	    ldx   #m                                    
	    lda   columnas                              
	    deca                                       
	    lsla                                       
	    leax  A,X                                   
	    clr   contador_diagonal                     

	bucle_suma_secundaria:   
		                
	    ldd   ,X                                    
	    addd  suma_secundaria                       
	    std   suma_secundaria                       

	    lda   columnas                              
	    deca                                       
	    lsla                                       
	    leax  A,X                                   
	    inc   contador_diagonal                    
	    lda   contador_diagonal                    
	    cmpa  min_fil_col                          
	    blo   bucle_suma_secundaria                 

	    ldd   suma_principal                        
	    cmpd  suma_secundaria                       
	    blo   imprimir_principal                    
	    bra   imprimir_secundaria                   

	imprimir_secundaria:  
		                  
	    ldx   #m                                    
	    lda   columnas                              
	    deca                                        
	    lsla                                       
	    leax  A,X                                   
	    clr   contador_diagonal                    
	    lda   #10                                  
	    sta   pantalla                              

	bucle_imprimir_secundaria:

	    ldd   ,X                                    
	    jsr   imprime_decimal                       
	    lda   #9                                   
	    sta   pantalla                              

	    lda   columnas                              
	    deca                                        
	    lsla                                       
	    leax  A,X                                   

	    inc   contador_diagonal                    
	    lda   contador_diagonal                    
	    cmpa  min_fil_col                          
	    blo   bucle_imprimir_secundaria            

	    bra   fin_impresion                         

	imprimir_principal: 
		                    
	    ldx   #m                                    
	    ldb   #1                                    

	imprimir_diagonal: 
		                     
	    clr   contador_diagonal                     
	    lda   #10                                   
	    sta   pantalla                              

	imprimir_bucle:
		                         
	    ldd   ,X                                    
	    jsr   imprime_decimal                       
	    lda   #9                                    
	    sta   pantalla                              

	    tstb                                        
	    beq   avance_secundaria                     

	    lda   columnas                              
	    adda  #1                                    
	    lsla                                       
	    bra   avanzar_diagonal                      

	avance_secundaria: 
		                     
	    lda   columnas                              
	    suba  #1                                    
	    lsla                                       

	avanzar_diagonal:
		                       
	    leax  A,X                                   
	    inc   contador_diagonal                    
	    lda   contador_diagonal                    
	    cmpa  min_fil_col                          
	    blo   imprimir_bucle                        

	fin_impresion:    
		                      
	    puls  X,Y,D,PC                              

