MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS
	  print MACRO msg
			push dx
			lea dx,msg
			call puts
			pop dx
			ENDM	

   .DATA
	msg1 db 'El factorial es: ',0
	
   .CODE
  
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr

				xor cx,cx
				xor ax,ax
				
				mov ax,1		;multiplicador
				mov cx,4		;factorial a calcular
				call factorial
				
				;add ax,30h
				;call putchar
				
				mov bx,10			;base a convertir
				call printNumBase	;convertir y mostrarlo en pantalla

				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
	factorial   PROC
	;============ Otra manera de hacer el calculo factorial ============
			    ;cmp cx,1		;cmp si se llego a caso base
				;jbe @@out		;si, salta
				;push cx		;no, guardar en pila para multiplicarlo
				;dec cx			;dec num para multiplicarlo por el num-1
				;call factorial	;llamar a funcion
				;pop cx  		;sacar ultimo dato de la pila decrementado para multiplicarlo
				;mul cx			;multiplicar num por num-1	

	;============ Manera facil de hacer el calculo factorial ============
				cmp cx,1		;caso base
				jbe @@out		;termina si es 1
			    mul cx			;no, mul CX * AX
				dec cx			;dec CX
			    call factorial  ;llamar funcion
				
		@@out:  ret
				ENDP
				
printNumBase	PROC			;para convertir el numero a decimal
				push ax
				push dx
				push cx
				
				print msg1
				
				xor dx,dx
				xor cx,cx
				
	@@division: div bx			;ax%bx...cociente=AX y residuo=DX
				add dx,30h		;sumarle '0' ascii para hacer ajuste
				cmp dx,39h 		;comparar si residuo es menor a 9
				jbe @@storeRmdr ;si, saltar
				add dx,7h 		;no, sumarle 7 para ajustar y no imprimir caracteres raros
				
   @@storeRmdr: push dx			;almacenar residuo en pila
				inc cx 			;inc contador para despues imprimir decrementandolo
				mov dx,0		;limpiar dx
				cmp ax,0		;comparar si cociente es cero
				jne @@division	;no, saltar para dividir otra vez
								;si, la division ha terminado y ahora hay que imprimir residuos
				;printReminders
   @@printRmdr: pop ax			;sacar residuos de la pila y colocarlos en AX 
				call putchar	;imprimir residuos
            	loop @@printRmdr	;decrementar cx para imprimir el numero de veces que se inc CX
				
				pop cx
				pop dx
				pop ax
				ret
				ENDP
         END