dosseg
.model small
.code
	
	public _strchr
	
		_strchr  PROC
				;push bx
				;push ax
				;push cx
				;push di
				push bp
				mov bp,sp
				mov bh,[bp+6] ;caracter
				mov di,[bp+4] ;cadena
				
				xor ax,ax
				xor cx,cx	;contador para saber en que posicion se encuetra el caracter
				
		 @@cmp: mov bl,[di]
				cmp bl,bh			;cmp si caracter esta en cadena
				je @@yes					;si, salta
				inc di						;no inc DI para buscar en sig posicion
				inc cl						;inc contador
				cmp bl,0		;cpm si se llego al final de la cadena
				je @@no						;si llego a final, entonces no se encontro caracter en cadena
				jmp @@cmp					;repetir
						
		@@yes:	;print msg3			;print caracter
				inc cl
				mov ax,cx
				;add al,30h			;sumarle '0' para mostrarlo en pantalla
				;cmp al,39h
				;ja @@adjust
				;call putchar		;print caracter
				jmp @@out			;salta 
				
	 ;@@adjust:  ;add al,7h
				;call putchar
				;jmp @@out
		
		  @@no:	mov ax,0
				;print msg2			;no se encontro caracter en cadena
		        
				
		 @@out: ;pop di				;recuperar registros
				;pop cx
				;pop ax
				;pop bx
				pop bp
				ret
		_strchr ENDP
    END