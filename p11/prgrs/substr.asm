dosseg
.model small
.code

	public _substr
				
				;mov si,offset string	;cadena fuente
				;mov di,offset destino	;cadena destino
				;mov ch,30		;posicion inicial a copiar
				;mov cl,3		;cantidad de caracteres a copiar
						
							
	  _substr	PROC
				
				push bp
				mov bp,sp
				mov si,[bp+8]
				;mov di,[bp+8]
				mov ch,[bp+6]
				mov cl,[bp+4]
		
				xor dx,dx
				xor bx,bx
				mov ax,si
				
 @@cmpPosition: cmp dh,ch			;cmp si DH es mayor a posicion de caracteres a copiar
				ja @@getPosition	;si, salta
				cmp byte ptr[si],0	;cmp si se llego a final de cadena
				je @@dontCopy		;si,la posicion inicial es mayr a la cadena
				inc si
				inc dh				;contador de caracteres en cadena fuente
				jmp @@cmpPosition
				
 @@getPosition: mov si,ax	;copiar offset de cadena fuente a SI
				xor dx,dx
				
		 @@get: cmp ch,dl 			;cmp si se llego a la posicion de cadena para copiar los chars
				je @@toCopy			;si, salta 
				cmp byte ptr[si],0 ;no, cmp si se llego al final de cadena
				je @@out	;si, salta
				inc si		;no, inc SI 
				inc dl		;inc DI para cmp con total de chars a copiar
				jmp @@get	
		
	  @@toCopy: cmp byte ptr[si],0	;cmp si se llego al final de cadena
				je @@end			;si, salta
				mov bl,[si] 		;no, copiar char apuntado por posicion de SI a BL
				mov byte ptr[di],bl ;copiar char a cadena DESTINO
				inc di			;inc direccion de cadena DESTINO
				cmp cl,bh		;cmp si cantidad de caracteres es igual a contador
				je @@end		;si, salta
				inc si			;no, inc SI
				inc bh 			;contador de caracteres copiados antes de llegar al valor null
				jmp @@toCopy
				
	@@dontCopy: mov ax,-1
				;lea dx,msg
				;call puts
				jmp @@out
				
		 @@end: ;lea dx,destino
				;call puts
				mov al,bh ;cantidad de caracteres copiados =========================checar
				;add al,'0'
				;call putchar		
				
		 @@out: pop bp
				ret
	    _substr ENDP
    END