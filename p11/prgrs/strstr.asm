dosseg
.model small
.code
	
	public _strstr

		_strstr	PROC
				push bp
				mov bp,sp
				mov di,[bp+4] ;strSource
				mov si,[bp+6] ;str
				
				;push di
				;push si
				;push ax
				;push bx
				;push cx

				xor ax,ax
				xor bx,bx
				xor cx,cx			
		  
				mov bh,[si]	;caracter contenido de MSG2 a BH  str
		@@cmp1: mov bl,[di]	;caracter contenido de MSG1 a BL  strSource
				inc cl		;inc contador
				cmp bh,bl	;cmp si caracteres son iguales
				je @@cmp2	;si, salta
				inc di		;no, inc DI para seguir cmp
				cmp byte ptr[di],0	;cmp para saber si llego al final de cadena
				je @@notFound	;no esta en cadena
				jmp @@cmp1		;repetir cmp1
				
		@@cmp2: inc si			;inc SI para cmp sig caracter si se encontro un caracter de la palabra final en la palabra incial 
		        mov bh,[si]	
		        inc di			;inc SI para cmp sig caracter si se encontro un caracter de la palabra final en la palabra incial 
	   @@cmp2a: mov bl,[di] 
				inc cl
				cmp bh,bl ;cmp si caracteres son iguales
				je @@fndSomewhere	;si, salta
				inc di				;no, inc DI para seguir cmp en los caracteres restantes de la cadena
				cmp byte ptr[di],0	;cmp para saber si se llego al final de la cadena
				je @@notFound		;si, salta
				jmp @@cmp2a			;no, salta para repetir
				
@@fndSomewhere: dec di		;dec para empezar a cmp en la palabra que econtro caracter similar
				dec si		;dec para empezar a cmp en la palabra que econtro caracter similar
				dec cl
		@@cmp3: mov bl,[di]
				mov bh,[si]
				cmp bh,bl	;cmp si caracteres son iguales
				jne @@notFound	;no, salta
				inc si			;inc SI para cmp los siguientes caracteres
				inc di			;inc SI para cmp los siguientes caracteres
				cmp byte ptr[si],0 ;cmp para saber si se llego al final de la cadena
				je @@found			;si, salta
				jmp @@cmp3			;no, salta para repetir
				
	   @@found: ;print msg5
				sub cl,1
				mov ax,cx
				;add al,30h
				;cmp al,39h
				;ja @@adjust
				;call putchar
				jmp @@out
				
	  ;@@adjust:	add al,7h
				;call putchar
				;jmp @@out
				
	@@notFound:	mov ax,-1
				;print msg4				
	 
		 @@out: ;pop cx
				;pop bx
				;pop ax
				;pop si
				;pop di
				pop bp
				ret
		_strstr ENDP
         END