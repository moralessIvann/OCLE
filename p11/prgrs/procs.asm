dosseg
.model small
.code

	public _strcmp
	public _borrar
	public _substr
	public _strchr
	public _strstr

		
		_borrar	PROC
				push bp
				mov bp,sp
				
				mov di,[bp+10] ;string destino
				mov si,[bp+8] ;string fuente
				mov cl,[bp+6] ;cantidad de caracteres a borrar
				mov ch,[bp+4] ;posicion incial del caracter a borrar CH
				
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
		
	  @@copied: mov ax,bx
				jmp @@out
		
	 @@bigSize: mov ax,-1
			   
		 @@out: pop bp
				ret
		_borrar ENDP
    			
				
									
	  _substr	PROC
				push bp
				mov bp,sp
				
				mov di,[bp+10]  ;cadena destino
				mov si,[bp+8]	;cadena fuente
				mov ch,[bp+6]	;posicion inicial a copiar
				mov cl,[bp+4]	;cantidad de caracteres a copiar
		
				xor dx,dx
				xor bx,bx
				mov ax,si
				
@@cmpPositionx: cmp dh,ch			;cmp si DH es mayor a posicion de caracteres a copiar
				ja @@getPositionx	;si, salta
				cmp byte ptr[si],0	;cmp si se llego a final de cadena
				je @@dontCopy		;si,la posicion inicial es mayr a la cadena
				inc si
				inc dh				;contador de caracteres en cadena fuente
				jmp @@cmpPositionx
				
@@getPositionx: mov si,ax	;copiar offset de cadena fuente a SI
				xor dx,dx
				
		 @@get: cmp ch,dl 			;cmp si se llego a la posicion de cadena para copiar los chars
				je @@toCopy			;si, salta 
				cmp byte ptr[si],0 ;no, cmp si se llego al final de cadena
				je @@out1	;si, salta
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
				
		 @@end: xor dx,dx
				mov dl,bh
				mov ax,dx ;cantidad de caracteres copiados
				jmp @@out1
				
	@@dontCopy: mov ax,-1				
								
		@@out1: pop bp
				ret
	    _substr ENDP
	
		
	
		_strchr  PROC
				push bp
				mov bp,sp
				
				mov bh,[bp+6] ;caracter
				mov di,[bp+4] ;cadena fuente
				
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
						
		@@yes:	mov ax,cx
				jmp @@out2			;salta 
		
		  @@no:	mov ax,0
				
		 @@out2:pop bp
				ret
		_strchr ENDP
		
		
		

		_strstr	PROC
				push bp
				mov bp,sp
				
				mov di,[bp+6] ;str
				mov si,[bp+4] ;strSource
							
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
				
	   @@found: sub cl,1
				mov ax,cx
				jmp @@out3
	
	@@notFound:	mov ax,-1
				
		@@out3: pop bp
				ret
		_strstr ENDP
	
	
	
											
	   _strcmp  PROC
				push bp
				mov bp,sp
				mov di,[bp+6]	;str1
				mov si,[bp+4]   ;str2

	   @@cmp1x: mov bl,[di]		;BX tiene caracter de strng1
				mov cl,[si]	
				cmp bl,cl		;cmp strng1 con strng2
				je @@cmp2x		;si, salta
				jmp @@cmp3x
					 
		@@cmp2x: cmp byte ptr[di],0	;cmp si se llego a final de la cadena
				je @@equal			;si, son iguales
				inc di				;inc DI para cmp sig caracter
				inc si				;inc SI para cmp sig caracter	
				jmp @@cmp1x
				
	   @@equal: mov ax,0
				jmp @@out4
				
		@@cmp3x: cmp bl,cl
				jb @@greater	;La cadena 1 es mayor DI BL
				jmp @@below		;La cadena 2 es mayor SI CL
		
	 @@greater: mov ax,1
				jmp @@out4
				
	   @@below: mov ax,-1
				jmp @@out4

		@@out4: pop bp
				ret
	    _strcmp ENDP
	
	
	END