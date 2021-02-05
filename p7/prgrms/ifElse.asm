;Programa que pide un num al usuario para ser evaluado con la estructura de control if_else. El
;numeros es evaluado para saber si es menor o mayor al numero 5. De lo contrario se termina el 
;programa.


MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS  

   .DATA
      msg1  	db  'El numero ingresado es menor a 5',0
	  msg2		db  'Ingresa un numero (0-9): ',0
	  msg3  	db  'El numero igresado es mayor a 5',0
	  newLine	db   13,10,0
	  num 		db  (?)

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
			    call clrscr
				mov dx, offset msg2 ;muestra en pantalla el msg1
				call puts
				
				call getchar ;recibe num por teclado y se almacena en AL
				sub al,30h   ;ajuste del num ingresado por teclado
				mov num,al   ;copiar AL a num para comparar
				
				;if_then_else
				cmp al,05h ;si el num ingresado es menor, se imprime el msg1
				ja @@else   ;de ser mayor, se salta a la salida del programa
				
	@@if_then:  mov dx, offset newLine ;salto de linea
				call puts
				mov dx,offset msg1 ;muestra en pantalla el msg1
				call puts
				jmp @@out ;saltar a salida de programa
	
	@@else:		mov dx, offset newLine ;salto de linea
				call puts
				mov dx, offset msg3 ;muestra en pantalla el msg3
				call puts	
				
	@@out:      mov ah,04ch ;salida de programa
				mov al,0
				int 21h	           
                ENDP
         END