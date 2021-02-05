MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
      msg       db  'Ingresa cadena: ',0
	  msg1		db	'La cadena es: ',0
	  cadena	db  (?)	;para guardar caracteres ingresados
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				mov dx,offset msg
				call puts
				
				mov bx,offset cadena	;copiar desplazamiento de cadena en BX, para guardar caracteres en 'cadena'
				call gets
				
				mov dx,offset msg1
				call puts
				mov dx,offset cadena;cadena	;copiar desplazamiento de cadena (ya tiene los caracteres) en DX, para imprimir 'cadena'
				call puts
				call getch

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

	gets		PROC
				
	 @@capture: mov ah,01h	;servicio entrada de caracter con eco
				int 21h
				mov [bx],al	;copiar el caracter ingresado por teclado a lugar de memoria direccionado por bx (se guarda en cadena)
				cmp al,13	;cmp si caracter es tecla ENTER
				je @@out	;si, salir
				inc bx		;no, inc bx 
				jmp @@capture
				
		@@out:  mov byte ptr[bx],0	;caracter nulo copiado despues de ingresar la cadena
				ret
				ENDP
         END