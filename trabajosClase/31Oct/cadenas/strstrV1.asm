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
      msg3	db  13,10,0
	  msg1	db	'camino gris',0
	  msg2	db	'gris',0
	  msg4	db	13,10,'No se encontro la palabra en la cadena',0
	  msg5  db  13,10,'La palabra se encontro en la posicion: ',0

   .CODE
    
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea di,msg1
				lea si,msg2
				call strstr
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

		strstr	PROC
				push di
				push si
				push ax
				push cx
				
				print msg1
				print msg3
				print msg2
				
				xor ax,ax
				xor bx,bx
				xor cx,cx

	   @@again: mov bl,[si]	;msg2 se copia a BL
				mov bh,[di]	;msg1 se copia a BH
				cmp bh,bl	;cmp si caracteres de MSG1 y MSG2 son iguales	
				je @@again2
				inc di		;inc para pasar al sig caracter
				inc cl		;inc contador
				cmp bh,0	;cmp si se llego al final de la cadena
				je @@notFound ;si, salta
				jmp @@again   ;no, salta
				
	 @@again2:	inc di
				mov bh,[di]
				inc si
				mov bl,[si]
				cmp bh,bl
				jne @@notFound
				cmp bl,0
				je @@found
				jmp @@again
				
	   @@found: print msg5
				mov al,cl
				add al,30h
				cmp al,39h
				ja @@adjust
				call putchar
				jmp @@out
				
	 @@adjust:  add al,7h
				call putchar
				jmp @@out
				
	@@notFound: mov ah,-1
				print msg4
	 
		 @@out: pop cx
				pop ax
				pop si
				pop di
				ret
				ENDP
         END