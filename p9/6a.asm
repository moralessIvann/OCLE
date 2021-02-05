MODEL small
.STACK 100h

INCLUDE procs.inc
		
		;macro para salto y nueva linea
		 newLine MACRO 
	    		 push ax
				 mov al,13
				 call putchar
				 mov al,10
				 call putchar
				 pop ax
				 ENDM
		
LOCALS
.DATA
	cadena 		db	'Cadena Memoria de video',0
	newLine		db  13,10,0
	msg1	    db	13,10,'Ingresa un caracter (DOS int 21h, 01h): ',0
	msg2		db	13,10,'Ingresa un caracter (BIOS int 16h, 10h): ',0
	msg3 		db	13,10,'Esta es la cadena (DOS int 21h, 09h)$'
	msg4 		db	13,10,'Esta es la cadena (BIOS int 10h, 13h)'
	smsg4		db	($-msg4)
	

.CODE
	Principal	PROC	
				mov ax,@data
				mov ds,ax
				
				call clrscr
				
				
				mov di,offset cadena	;recibe direccion de cadena
				mov bh,5			;coordenadas en pantalla ;X
				mov bl,1			;Y	posicion (41,0)
				call putcharxy		;imprime caracter (DL) en posicion (X,Y)
				;mov dx,offset newLine
				;call puts
				newLine
				
				call dos01h
				call bios10h
				call dos09h
				call bios13h
				newLine
				call puts
				
				mov ah,04ch		;fn de programa
				mov al,0
				int 21h
				ret
				ENDP
				
	putcharxy	PROC
				push ax		;salvar valoes de registros a
				push bx		;utilizar
				push cx
				push dx
				push di
				push si
				push ds	
				
				;calculo de coordenada en memoria de video
				mov cl,160				;calcular localidad en memoria segun
				mov al,bl				;posicion (X,Y)
				mul cl					;X: esta en BH y Y: en B
				mov bl,bh				;localidad en memoria = (x * 2) + (y * 160)
				mov bh,0				
				shl bx,1				;BX = (BL *2)
				add bx,ax				;resultado de coordenada de guarda en BX para despues mostrarse en pantalla
				
	   @@again: mov dl,[di]				;DL contiene el caracter a desplegar, direccionado por DI
				mov si,0b800h			;hacer que DS apunte al segmento de
	    	    mov ds,si				;memoria de video	
				mov [bx],dl				;mover DL a la localidad DS:BX para imprimir
				
				inc bx					;para direccionar 2 posiciones despues de la que se imprimio
				inc bx
				pop ds					;recuperar DS para tomar el sig caracter de cadena. La var cadena esta en DS, es por eso que hay sacar DS de la pila
				
				inc di					;obtener sig caracter de la cadena 
				cmp byte ptr[di],0		;cmp si se llego al final de la cadena
				je @@out				;si, salir
				push ds					;no, guardar DS en la pila para usarlo despues
				jmp @@again				;salta y repite
						
		@@out:  pop si			;dejar todo como estaba
				pop di
				pop dx		
				pop cx
				pop bx
				pop ax
				ret
				ENDP
				
	 dos01h		PROC
				push ax
				push dx
				
				mov dx,offset msg1
				call puts
				mov ah,01h	;caracter leido se guarda en AL y eco en pantalla
				int 21h		;llamada de interrupcion de DOS
				
				pop ax
				pop dx
				ret
				ENDP
				
	bios10h		PROC
				push ax
				push dx
				
				mov dx,offset msg2
				call puts
				mov ah,10h	;el caracter se guarda en AL
				int 16h		;llamada de interrupcion de BIOS
				call putchar;imprimir caracter
				
				pop ax
				pop dx
				ret
				ENDP
				
	dos09h		PROC
				push ax
				push dx
				
				
				mov ah,09h	;el caracter se guarda en AL
				mov dx,offset msg3
				int 21h		;llamada de interrupcion de DOS
				
				pop ax
				pop dx
				ret
				ENDP
				
	bios13h		PROC
				push ax
				push dx
				push bx
				push dx
				push cx
				push ds
				
				mov ax,ds
				mov es,ax
				
				mov ah,13h	;el caracter se guarda en AL
				mov al,0	;modo de escritura
				mov bh,0	;pag de video
				mov bl,10	;atributo color
				mov cx,39	;tamanio de cadena
				mov dh,4	;fila inicial
				mov dl,8	;columna incial
				mov bp,offset msg4	;direccionar offset en seg ES
				int 10h		;llamada de interrupcion de DOS
				
				pop ds
				pop cx
				pop dx
				pop bx
				pop dx
				pop ax
				ret
				ENDP
	END