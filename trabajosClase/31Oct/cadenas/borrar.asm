MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS
	   
	   print  MACRO msg
			  push dx
			  lea dx,msg
			  call puts
			  pop dx
			  ENDM

   .DATA
	msg3	db   13,10,0
	msg2    db   20 dup (?),0
	msg4	db	'Posicion solicitada en AL es mayor a longitud de cadena',0
	msg1	db	'hola mundo',0 
	sSize   db	 ($-msg1)
	
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
				call clrscr
				xor ax,ax
				xor cx,cx
				
				mov bx,offset msg1	;apuntador a cadena
				mov al,12	;posicion del 1er caracter a borrar
				mov cl,3 	;cantidad de caracteres a borrar		
				call borrar 
			
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
				
				
		borrar	PROC
				push ax
				push cx

				cmp al,sSize		;cmp si la posicion de AL es mayor a la longitud de la cadena
				ja @@error
				
				mov di,ax			;copiar AL en DI para direccionar
	   @@again: mov msg1[di],'x'	;copiar 'x' las posiciones a borrar de la cadena
				inc di				;inc offset de cadena
				loop @@again
				lea dx,msg1			;recibiar cadena resultante de el proceso anterior
			    call puts
							
				xor di,di			;limpiar DI
				xor si,si			;limpiar SI
	  @@again2: cmp msg1[di],'x'	;cmp si posicion en cadena es 'x'
				jne @@sort			;no, salta
				inc di				;si, inc DI para direccionar en MSG1
				jmp @@again2		;repetir
				
				;xor si,si				;========nunca se ejecuta		
	    @@sort: mov al,msg1[di]		;copiar caracter a AL para
				mov msg2[si],al		;pasarlo a la nueva cadena MSG2
				inc si				;inc SI para tomar sig caracter
				inc di				;inc DI para tomar sig caracter
				cmp byte ptr msg1[di],0 ;=========cmp byte ptr[di],0...cmp si se llego a fin de cadena MSG1
				je @@print
				jmp @@again2

       @@print: mov byte ptr msg2[si],0	;=========mov byte ptr[si],0...cmp si se llego a fin de cadena MSG2
				print msg3
				lea dx,msg2			
			    call puts
				jmp @@out
		
	  @@error:  mov ah,-1
				
		@@cmpAH:cmp ah,-1
				je @@printError
				jmp @@out
				
  @@printError: print msg4
				mov ah,0
			   
		 @@out: pop cx
				pop ax
				ret
				ENDP
         END