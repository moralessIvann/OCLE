MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
	char db '3',0
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
					
				mov di,offset char
				call atoi
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
				
		atoi 	PROC
		
				xor bx,bx
				mov ax,0
				mov cx,10
				
	   @@again: cmp byte ptr[di],0
				je @@out
				mov bl,[di]	;1		  ;2		 ;3
				sub bl,30h	;1-0=1    ;2-0=2	 ;3-0=3
				mul cl		;0*10=0   ;1*10=10   ;12*10=120
				add al,bl	;0+1=1    ;10+2=12	 ;120+3=123
							;ax=1	  ;12        ;123
				
				inc di
				jmp @@again
				
		 @@out: mov bx,10
				call printNumBase
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