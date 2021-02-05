;Programa que pide un num al usuario para ser evaluado con la estructura de control case_of. El
;numeros es evaluado en cada caso para saber que numero se ingreso. De lo contrario se termina el 
;programa.


MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS  

   .DATA
     
	  msg0		db  'Ingresa un numero (0-3): ',0
	  msg1		db  'El numer ingresado es 0',0
	  msg2		db  'El numer ingresado es 1',0
	  msg3		db  'El numer ingresado es 2',0
	  msg4		db  'El numer ingresado es 3',0
	  newLine	db   13,10,0
	  num 		db  (?)

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				
			    call clrscr  ;limpia pantalla
				mov dx, offset msg0
				call puts	;muestra en pantalla el msg0
				
				call getchar ;recibe num por teclado y se almacena en AL
				sub al,30h ;ajuste del num ingresado por teclado
				mov num,al ;copiar AL a num para comparar
				
				
	;case_of			
				
				cmp al,00h ;case_1: compara si el num ingresado es 0, si num=0 se muestra msg1 
				je @@case1
				cmp al,01h ;case_2: compara si el num ingresado es 1, si num=1 se muestra msg2
				je @@case2
				cmp al,02h ;case_3: compara si el num ingresado es 2, si num=2 se muestra msg3
				je @@case3
				cmp al,03h ;case_4: compara si el num ingresado es 3, si num=3 se muestra msg4
				je @@case4
				jne @@out ;default
				
				
	@@case1:    mov dx, offset newLine ;salto de linea
				call puts 
				mov dx,offset msg1 
				call puts ;muestra en pantalla el msg1
				jmp @@out ;break
				
	@@case2:    mov dx, offset newLine ;salto de linea
				call puts 
				mov dx,offset msg2 
				call puts ;muestra en pantalla el msg2
				jmp @@out ;break
				
	@@case3:    mov dx, offset newLine ;salto de linea
				call puts 
				mov dx,offset msg3 
				call puts ;muestra en pantalla el msg3
				jmp @@out ;break
				
	@@case4:    mov dx, offset newLine ;salto de linea
				call puts 
				mov dx,offset msg4 
				call puts ;muestra en pantalla el msg4
				jmp @@out ;break
				
	@@out:      mov ah,04ch ;salida del programa
				mov al,0
				int 21h	           
                ENDP
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
         END