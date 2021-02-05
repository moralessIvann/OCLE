MODEL small
   .STACK 100h

   ;invertir bit de un registro

 INCLUDE procs.inc
 
       LOCALS
	
   .DATA
   

   .CODE
 
	
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				xor ax,ax
				mov bx,16	;base
				mov ax,0ah	;num
				mov cx,3	;bit a activar
				
				call notBit
				call printNumBase
			
    			call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

		notBit	PROC
				push dx
				xor dx,dx
				
				mov dl,1	;bit a invertir
				shl dl,cl	;recorrer bit a la posicion a invertir
				xor al,dl	;invertir bit
				
				pop dx
				ret
				ENDP
				
				
printNumBase	PROC
				push ax
				push dx
				push cx
				
				xor dx,dx
				xor cx,cx
				
	@@division: div bx	;ax%bx...cociente=AX y residuo=DX
				add dx,30h	;sumarle '0' ascii para hacer ajuste
				cmp dx,39h ;comparar si residuo es menor a 9
				jbe @@storeRmdr ;si, saltar
				add dx,7h ;no, sumarle 7 para ajustar y no imprimir caracteres raros
				
   @@storeRmdr: push dx	;almacenar residuo en pila
				inc cx ;inc contador para despues imprimir decrementandolo
				mov dx,0	;limpiar dx
				cmp ax,0	;comparar si cociente es cero
				jne @@division	;no, saltar para dividir otra vez
								;si, la division ha terminado y ahora hay que imprimir residuos
				;printReminders
   @@printRmdr: pop ax	;sacar residuos de la pila y colocarlos en AX 
				call putchar	;imprimir residuos
            	loop @@printRmdr	;decrementar cx para imprimir el numero de veces que se inc CX
				
				pop cx
				pop dx
				pop ax
				ret
				ENDP

     END