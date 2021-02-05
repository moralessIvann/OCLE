MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS

   .DATA
   
   msg2	    db		'No es automorfico',0
   msg1		db		'Si es automorfico',0

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
			
				mov dx,9376
				call automorphic
				
				cmp ax,01
				jne @@no
				mov dx,offset msg1
				call puts
				jmp @@end
				
		 @@no:  mov dx,offset msg2
				call puts

	    @@end:  mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
	

  automorphic	PROC
				xor cx,cx	;limpiar registro cx
				mov si,dx	;guardar dato en SI para cmp en @@module
				mov bx,10	;valor con el que sera dividido AX para saber cuantos digitos tiene
				mov ax,si ;copiar el valor de SI en AX para dividir
		
	 @@divide:  xor dx,dx	;limpiar residuo
				div bx		;despues de cada division se inc CX para saber cuantos digitos tiene el num, no importa el residuo
				inc cx		;incrementa cada vez que se realiza la division, indicando el total de digitos en el num
				cmp ax,0	;cmp si el cociente es cero
				jne @@divide	 ;si, ya no dividir...no, seguir dividiendo y pasar a @@square
	
				mov ax,1	;copiar 1 para multiplicar
		@@mul:	mul bx		;multiplicar la base
				loop @@mul
				mov bx,ax	;copiar valor de base elevada a la potencia necesaria en BX
			
				
				
	 @@square:	mov ax,si	;pasar dato a AX para multiplicar
				mul si		;mul para obtener el num al cuadrado DX:AX

	 @@module:	div bx		;dividir entre el num^2
				cmp dx,si	;cmp el residuo con la palabra ingresada al inicio
				je @@isEqual
				mov ax,00	
				jmp @@out
				
	@@isEqual:  mov ax,01	

		@@out:  ret
				ENDP
         END