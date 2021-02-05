;Programa que imprimie mientras la variable num, sea menor a 5.

MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS  

   .DATA
      newLine db  13,10,0
	  num	  db  1
	  msg	  db  'Mientras num<5, se imprime num+1)',0
	  spaceLine db ' ',0
	  
	  

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
				
	@@while:    cmp num,5h
				ja @@out
				mov al,num
				add al,30h ;
				call putchar
				lea dx,spaceLine
				call puts
				
				inc byte ptr[num]
				call getchar
				jmp @@while
			
	@@out:      mov ah,04ch ;salida de programa
				mov al,0
				int 21h	           
                ENDP
         END