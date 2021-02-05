dosseg
.model small
.code

	public _borrar
		
		_borrar	PROC
				push bp
				mov bp,sp
				mov si,[bp+8] ;string
				mov cl,[bp+6] ;cantidad de caracteres a borrar
				mov ch,[bp+4] ;posicion incial del caracter a borrar CH
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
				
 @@checkString: cmp byte ptr[si],0
				je @@copied
				cmp byte ptr[si],'x'
				je @@ignoreChar
				mov dl,[si]
				mov [di],dl
				inc si
				inc di
				
				jmp @@checkString
	
  @@ignoreChar: inc si
				jmp @@checkString
		
	  @@copied: ;lea dx,msg2 ;cadena destino
				;call puts
				;xor ax,ax
				mov ax,bx
				;add al,30h
				;call putchar
				jmp @@out
		
	 @@bigSize: mov ax,-1
				;lea dx,msg4 
				;call puts
			   
		 @@out: ;pop cx
				;pop ax
				pop bp
				ret
		_borrar ENDP
    END