dosseg
.model small
.code

	public _strcmp
											
	_strcmp	    PROC
				push bp
				mov bp,sp
				mov di,[bp+6]
				mov si,[bp+4]
				
				;push si
				;push di
				
		@@cmp1: mov bl,[di]		;BX tiene caracter de strng1
				mov cl,[si]	
				cmp bl,cl		;cmp strng1 con strng2
				je @@cmp2		;si, salta
				jmp @@cmp3
					 
		@@cmp2: cmp byte ptr[di],0	;cmp si se llego a final de la cadena
				je @@equal			;si, son iguales
				inc di				;inc DI para cmp sig caracter
				inc si				;inc SI para cmp sig caracter	
				jmp @@cmp1
				
	   @@equal: mov ax,0
				jmp @@out
				
		@@cmp3: cmp bl,cl
				jb @@greater	;La cadena 1 es mayor DI BL
				jmp @@below		;La cadena 2 es mayor SI CL
		
	 @@greater: mov ax,1
				jmp @@out
				
	   @@below: mov ax,-1
				jmp @@out

		@@out:  ;pop di
				;pop si
				pop bp
				ret
	    _strcmp ENDP
    END