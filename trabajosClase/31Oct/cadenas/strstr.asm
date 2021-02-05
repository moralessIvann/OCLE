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
	  msg1	db	'carro azul',0		;'hola mundo',0  
	  msg2	db	'azul',0			;' mundo',0 		 		 
	  msg4	db	13,10,'No se encontro la palabra en la cadena',0
	  msg5  db  13,10,'La palabra se encontro apartir de la posicion: ',0

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
				push bx
				push cx
				
				print msg1
				print msg3
				print msg2
				
				xor ax,ax
				xor bx,bx
				xor cx,cx			
		  
				mov bh,[si]	;caracter contenido de MSG2 a BH
		@@cmp1: mov bl,[di]	;caracter contenido de MSG1 a BL
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
				
	   @@found: print msg5
				sub cl,1
				mov al,cl
				add al,30h
				cmp al,39h
				ja @@adjust
				call putchar
				jmp @@out
				
	  @@adjust:	add al,7h
				call putchar
				jmp @@out
				
	@@notFound:	mov ah,-1
				print msg4				
	 
		 @@out: pop cx
				pop bx
				pop ax
				pop si
				pop di
				ret
				ENDP
         END