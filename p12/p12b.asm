MODEL small
   .STACK 100h


 INCLUDE procs.inc
 
       LOCALS
   print MACRO msg
   push dx
   lea dx,msg
   call puts
   pop dx
   ENDM
	   

   .DATA
	msg1 db	13,10,'La cadena si es un pangrama.',0
	msg2 db	13,10,'La cadena no es un pangrama.',0
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
								
				call esPangrama
	
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
						
     esPangrama PROC
				mov dl,0		;contador de letras, debe llegar hast 25b (total de letras del abcdario)
				mov cl,'z'		;para ir comparando con letras del abc
				mov si,82h			;para direccionar en segmento ES
	   @@again: mov bl,es:[si]		;accessar char en segmento ES
				
				cmp bl,13		;cmp si char es 'ENTER'
				je @@no			;si, salta
				cmp bl,cl		;no, cmp si el char de la cadena es 'z' (luego se decrementara para cmp con 'y','x', etc.)
				jne @@nxtChar	;no, salta
				mov si,82h		;si, volver a posicionarse en el 1er char de cadena para cmp con sig char del abc
				dec cl		;dec char del abc
				inc dl		;inc contador
				cmp dl,25	;cmp si ya se cmp todas las letras del abc
				je @@yes 	;si, salta
				jmp @@again	;no, salta
				
	 @@nxtChar: inc si		;pasar al sig char de la cadena para cmp
			    jmp @@again	;salta
							
		  @@no: print msg2
				jmp @@out
				
		 @@yes: print msg1			
								
	     @@out: ret
				ENDP			
    END