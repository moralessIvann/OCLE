MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS

   .DATA
   
	msg1	db	13,10,'El m.c.d. es: ',0
    
   .CODE
   
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea dx,msg1
				call puts
				
				xor ax,ax
				xor bx,bx
				
				mov ax,94
				mov bl,7
				cmp al,bl	;cmp que dividendo no sea menor que divisor
				jb @@end	;si, salta
				call mcd	;no, llamada a proc
				
				mov bx,10	;base a convertir
				call printNumBase	;para convertir el numero a decimal
				
		 @@end: call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
				
				
	      mcd	PROC
				
				cmp bl,0	;casoBase y cmp que divisor no sea cero (después de 1ra recursión, el residuo se pasa a BL)
				je @@out	;si, salta y termina
				xor ah,ah	;limpiar residuo
				div bl		;dividir
				mov al,bl	;divisor es el nuevo dividendo
				mov bl,ah	;residuo es el nuevo divisor
				call mcd	;llamada a proc
				
		 @@out: ret
				ENDP
				
				
					
printNumBase	PROC			;para convertir el numero a decimal
				push ax
				push dx
				push cx
				
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