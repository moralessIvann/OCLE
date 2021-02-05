MODEL small
   .STACK 100h


 INCLUDE procs.inc
 
       LOCALS

   .DATA
	msg db	13,10,'Value out of range.',0
	
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
								
				call atoi
				call numeroTriangular
	
		 @@end: call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
	
		atoi 	PROC
				mov ax,0
				mov cx,10
				
				mov si,82h
	   @@again: mov bl,es:[si]
	
				cmp bl,13
				je @@out
				sub bl,30h	;1-0=1    ;2-0=2	 ;3-0=3
				mul cl		;0*10=0   ;1*10=10   ;12*10=120
				add ax,bx	;0+1=1    ;10+2=12	 ;120+3=123
							;ax=1	  ;12        ;123
				inc si
				jmp @@again
			
		 @@out: ret
				ENDP
				
		
  numeroTriangular PROC
				
				cmp ax,1
				jb @@no
				cmp ax,255
				ja @@no
				
				mov bx,ax
				mov dx,bx
	   @@begin: mov bx,dx
	   @@again: mov ax,bx	;ax=5
	            add bx,1    ;bx=6
				mul bl		;ax=6*5=30
				mov bl,2	;
				div bl		;30/2
				mov ah,0	;limpiar residuo
				cmp al,1 
				jae @@print
				jmp @@out
				
	   @@print: mov bl,10
				call printNumBase
				cmp al,1
				je @@out
				mov al,','
				call putchar
				dec dx
				jmp @@begin
				
		  @@no: lea dx,msg
				call puts
					
	     @@out: ret
				ENDP
				
				
printNumBase	PROC
				push ax
				push dx
				push cx
				
				xor dx,dx
				xor cx,cx
				xor si,si
				xor di,di
				
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
   @@printRmdr: pop ax
				call putchar
				loop @@printRmdr	;decrementar cx para imprimir el numero de veces que se inc CX
					
		 @@out: pop cx
				pop dx
				pop ax
				ret
				ENDP
    END