MODEL small
   .STACK 100h


 INCLUDE procs.inc
 
       LOCALS

   .DATA
	msg1	db	'El numero en binario es: ',0
	
   .CODE
  
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea dx,msg1
				call puts
				
				xor cx,cx	;limpiar registro
				xor ax,ax	;limpiar registro
				mov cl,8	;contador y total de corrimientos a hacer
				mov al,0FFh	;num a convertir a binario
				call printBinRec	;llmada de proc
				
				mov bl,2	;base a convertir (binario
				call printNumBase	;llamada a proc
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

	printBinRec PROC
				
				cmp cl,0	;cmp si contador llego a cero
				je @@out	;si, salta 
				dec cl		;no, dec contador
				shl al,1	;corrimiento a la izq
				adc ax,0	;el bit almacenda en carry se le suma cero para depositarlo en AL
				call printBinRec	;llamada a proc recursivo

		 @@out: ret
				ENDP
				
printNumBase	PROC			;para convertir el numero a binario
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