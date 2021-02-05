dosseg
.model small
.code

   public _esIsograma
				
	_esIsograma	PROC
				push sp
				mov bp,sp
				mov di,[bp+4]
								
				mov bl,[di] ;tomar char y copiar a BL
	   @@begin: inc di		;inc DI para cmp nxt char
				;mov dx,di	;guardar offset
				push di		;guardar offset
				mov cl,[di] ;copiar en CL nxt char
				
	   @@again: cmp bl,[di]	;cmp char 
				je @@no		;si es igual, salta
				inc di		;no, inc DI para cmp con nxt char
				cmp byte ptr[di],0	;cmp si se llego al final de la cadena
				je @@nxtChar		;si es igual, salta
				jmp @@again			;no, repetir
				
	 @@nxtChar: ;mov di,dx		;guardar offset
				pop di			;guardar offset
				mov bl,cl	;copiar en BL char guardado anteriormente en @@begin
				cmp bl,0	;cmp si el final de cadena
				je @@yes	;si, salta
				jmp @@begin	;no, repetir
				jmp @@out
				
	     @@yes: mov ax,1	
				jmp @@out
					
		  @@no: mov ax,0
				pop di	;sacar offset
				
		 @@out: pop sp
				ret
	_esIsograma ENDP
				
END