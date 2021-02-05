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
	msg4	db	'Posicion solicitada es mayor a longitud de cadena',0
	msg1	db	'mundo',0 
	
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
				call clrscr
				xor ax,ax
				xor cx,cx
				
				
				mov si,offset msg1	;apuntador a cadena
				lea di,msg2
				mov ch,10	;posicion incial del caracter a borrar CH
				mov cl,4 	;cantidad de caracteres a borrar		
				call borrar 
			
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
				
				
		borrar	PROC
				;push ax
				;push cx
				xor dx,dx
				xor bx,bx
				mov ax,si
				
 @@cmpPosition: cmp dh,ch			;cmp si DH es mayor a posicion de caracteres a copiar
				ja @@getPosition	;si, salta
				cmp byte ptr[si],0	;cmp si se llego a final de cadena
				je @@bigSize		;si,la posicion inicial es mayr a la cadena
				inc si
				inc dh				;contador de caracteres en cadena fuente
				jmp @@cmpPosition
				
 @@getPosition: mov si,ax
				mov dh,0
				
@@getPosition2: cmp dh,ch		;llegar a la posicion del 1er char a borrar
				je @@deleteChar
				cmp byte ptr[si],0
				je @@out
				inc si
				inc dh
				jmp @@getPosition2
							
  @@deleteChar: cmp bl,cl
				je @@deleted
				mov byte ptr[si],'x'
				inc si
				inc bl
				cmp byte ptr[si],0
				je @@deleted
				jmp @@deleteChar
				
	 @@deleted: mov si,ax			;dl...bh
				
 @@checkString: cmp byte ptr[si],'x'
				je @@ignoreChar
				mov dl,[si]
				mov [di],dl
				inc si
				inc di
				cmp byte ptr[si],0
				je @@copied
				jmp @@checkString
	
  @@ignoreChar: inc si
				jmp @@checkString
		
	  @@copied: lea dx,msg2
				call puts
				mov al,bl
				add al,30h
				call putchar
				jmp @@out
		
	 @@bigSize: mov ah,-1
				print msg4
				jmp @@out
			   
		 @@out: ;pop cx
				;pop ax
				ret
				ENDP
         END