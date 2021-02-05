;Programa que imprimer el abecedario haciendo uso de cilo for.

MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS  

   .DATA
      newLine db 13,10,0
	  space db  ' ',0
	  msg1 	db	'ABCDario',0  ;41-5A
	  i		db  (?)
	  

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
			    call clrscr
				
				mov byte ptr[i],41h  ;i=41h....41h-->A
	@@for:		cmp byte ptr[i],5Ah  ;i<=5A....5Ah-->Z
				ja @@out 
				mov al,[i]
				;add al,'0'
				call putchar
				mov al, space
				call putchar
				inc byte ptr[i] ;i++
				jmp @@for
	
	@@out:      mov ah,04ch ;salida de programa
				mov al,0
				int 21h	           
                ENDP
         END