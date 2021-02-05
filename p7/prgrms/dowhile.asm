;Programa que imprimie el caracter 'e' las veces que el usuario lo desee. De lo contrario,
;la ejecución del programa termina.

MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS  

   .DATA
      newLine db  13,10,0
	  char	  db  (?)
	  msg	  db  'Ingresa numero (1=si, 2=no)',0
	  msg1    db  'Desea seguir imprimiendo: ',0
	  

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
			    call clrscr
				mov dx,offset msg
				call puts
				mov dx,offset newLine
				call puts
				
	@@do_while: mov dx,offset msg1
			    call puts
				mov dx,offset newLine
				call puts
                call getchar
				sub al,30h
				mov char,al ;31h-->1....32h-->2			   
				
				cmp char,01h  ;;;
				jne @@out
				mov al,65h ;imprimir caracter 'e'
				
				mov dx,offset newLine
				call puts
				call putchar ;imprimir caracter 'e'
				mov dx,offset newLine
				call puts
				jmp @@do_while
			
	@@out:      mov ah,04ch ;salida de programa
				mov al,0
				int 21h	           
                ENDP
         END