MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
	cadena	db	'1608',0
	msg		db	'La cadena es: ',0
		
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				mov  dx,offset msg
				call puts
				
				mov bx,offset cadena	;recibe cadena
				call atoi
				call getch

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP



		atoi	PROC		
				push dx
				push bx
				push ax
				
				xor dx,dx
				xor ax,ax
				
		@@for:  cmp byte ptr[bx],0	;cmp si la cadena es vacia
			    je @@out	;si, salir
				
				mov dl,[bx]	;no, copiar el 1er byte de la cadena al DL
				sub dl,30h	;restar 30h para obetener el valor real del digito de la cadena
				mov al,dl	;copiar el digito real en AL para sumarle 30h 
				add al,30h	;sumarle 30h al digito para mostrarlo en pantall
				call putchar	;imprimir en pantalla
				inc bx			;inc el offset de BX para obetener el sig digito de la cadena
				cmp byte ptr[bx],0	;cmp si el sig digito es cero (caracter nulo) 
				je @@out	;si, salir
				jmp @@for	;no, saltar para repetir proceso
				
	@@out:	  	pop ax
				pop bx
				pop dx
				ret
				ENDP
			
         END