;Programa que pide un num al usuario para ser evaluado con la estructura de control if_then. El
;numero ingresado debe ser igual al numero a comparar. De lo contrario se termina el 
;programa.


MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS  

   .DATA
     
	  msg2		db  'Ingresa un numero (0-9): ',0
	  msg1		db  'El numero es 2',0
	  newLine	db   13,10,0
	  num 		db  (?)

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
			    call clrscr 		;limpia pantalla
				mov dx, offset msg2 
				call puts	;muestra en pantalla el msg2
				
				call getchar ;recibe num por teclado y se almacena en AL
				sub al,30h ;ajuste del num ingresado por teclado
				mov num,al ;copiar AL a num para comparar
				
				;if_then
				cmp al,02h ;compara si el num ingresado es 2, si num=2 se muestra msg1    
				jne @@out ; se salta a la salida del programa si num es != de 2
				
	@@if_then:  mov dx, offset newLine ;salto de linea
				call puts 
				mov dx,offset msg1 
				call puts ;muestra en pantalla el msg1
				
	@@out:      mov ah,04ch ;salida del programa
				mov al,0
				int 21h	           
                ENDP
         END