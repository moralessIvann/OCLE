MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS

   .DATA
	 newLine	db	13,10,0
	 msg		db  13,10,'La posicion de AL es mayor que la longitud de cadena',0
     destino	db	30 dup(?),0
	 string		db	'El lugar del silencio',0;'cadena para copiar',0 ;na para
	 sSize		db  ($-string)	  ;tamanio de string
	 
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				xor ax,ax
				xor cx,cx
				
				mov si,offset string	;cadena fuente
				mov di,offset destino	;cadena destino
				mov al,24		;posicion inicial a copiar
				mov cl,7		;cantidad de caracteres a copiar
				call substring
			
		        call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
				
				
	substring	PROC
				push si
				push di
				push ax
				push cx
				
				lea dx,string
				call puts
				lea dx,newLine
				call puts
				mov di,ax	;copiar en DI posicion inicial a copiar de la cadena
				
				mov dl,sSize
				cmp al,dl	;cmp si la posicion a copiar de la cadena es mayor a su longitud
				ja @@warning;si, salta
							;no, continua
							
	   @@again: mov al,string[di]	;copiar en AL el caracter direccionado
				mov destino[bx],al  ;copiar en destino[bx] caracter
				inc di				;inc offset de STRING para tomar caracter
				inc bx				;inc offset de BX para guardar en sig posicion
				loop @@again
				
				lea dx,destino
			    call puts
				jmp @@out
		
	 @@warning: mov ah,-1
	 
				cmp ah,-1
				je @@printError
				jmp @@out
				
  @@printError: lea dx,msg
				call puts
				mov ah,0
				
	 
		@@out:  pop cx
				pop ax
				pop di
				pop si
				ret
				ENDP
         END