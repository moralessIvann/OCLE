MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr

				mov ax,0FFFFh
				mov bx,16
				call printNumBase

				call getch

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 

                ENDP

;===============================================================================
	printNumBase	PROC
					
					mov cx,0
					mov dx,0
					
		@@next:	 	cmp ax,0 	;mientras dividendo > 0
					jbe @@print
					div bx		;divido por la base
					push dx		;salvo el residuo en la pila
					mov dx,0	;reseteo a DX
					inc cx		;contador de divisiones
					jmp @@next
		
		@@print:	pop dx			;saco residuos de la pila
					mov al,dl		
					cmp al,9		;verifico si es mayor a 10
					jb @@continua	
					add al,7		;llegar a A-F en caso de hexa
		@@continua:	add al,30h		;ascii
					call putchar
					loop @@print	;las veces que se hizo division
						
					ret
					ENDP

         END
		 
		 
		 
		 
		 
		 
		 