MODEL small
.STACK 100h

INCLUDE procs.inc
LOCALS
.DATA
	msgDirecto	db	13,10,'Desplegado de caracter en forma directa: ',0
	msgDOS		db	13,10,'Desplegado de  caracter usando DOS: ',0
	msgBIOS		db	13,10,'Desplegado de caracter usando BIOS: ',0

.CODE
	Principal	PROC	
				mov ax,@data
				mov ds,ax
				
				call clrscr
				mov dx,offset msgDirecto
				call puts
				
				mov al,'X'			;caracter a desplegar
				mov bh,41
				mov bl,0			;posicion (41,0)
				call putcharxy		;imprime caracter (DL) en posicion (X,Y)
				
				mov dx,offset msgDOS
				call puts
				mov dl,'Y'				;caracter a desplegar
				mov ah,2				;servicio: desplegar caracter
				int 21h					;llamada a DOS servicio 2
				
				mov dx,offset msgBIOS
				call puts
				mov al,'Z'				;caracter a desplegar
				mov ah,0Ah				;servicio: desplegar caracter
				mov bx,0				;no. de pagina para desplegar
				mov cx,1				;num de veces a desplegar
				int 10h					;llamada a BIOS servicio 0Ah
				
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
				push ds
				
				mov dx,ax				;DL sera el caracter a desplegar
				mov ax,0b800h			;hacer que DS apunte al segmento
				mov ds,ax				;de memoria de video
				mov cl,160				;calcular localidad en memoria segun
				mov al,bl				;posicion (X,Y)
				mul cl					;X: esta en BH y Y: en B
				mov bl,bh				;localidad en memoria = (x * 2) + (y * 160)
				mov bh,0				
				shl bx,1				;se quere BX = (BL * 160) + (BH*2)
				add bx,ax				
				mov [bx],dl				;mover DL a la localidad DS:BX
				
				pop ds		;recuperar valores originales de registros
				pop dx		;utilizados
				pop cx
				pop bx
				pop ax
				ret
				ENDP
	END