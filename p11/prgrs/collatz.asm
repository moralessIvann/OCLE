dosseg
.model small
.code

	public _collatz
	
	  _collatz	PROC
				;push ax			;salvar registros
				;push bx
				;push cx
				;push dx
				
				push sp
				mov bp,sp
				mov ax,[bp+4]
					
				xor dx,dx	;se utilizara para guardara el valor original de AX en DX
				
				mov cl,3	;multiplicar x3
				mov bl,2	;dividir /2
				mov dl,al 	;valor original se copia en DX para usarlo en futuras iteraciones
				
		 @@cmp: div bl			;dividir entre 2 para saber si AX es num par
				cmp ah,0		;cmp si residuo es cero
				je @@siPar	    ;si, es num par
				inc dh			;no, inc SI			 									
				mov ax,dx		;copiar valor en AX
				mul cl			;mul x3
				add ax,1		;sumarle 1
				jmp @@cmp		;saltar para repetir proceso

       @@siPar:	inc dh			;inc contador
				cmp al,1		;cmp si cociente es 1																					 
				je @@end		;si, se termina el proceso							    
				mov dl,al		;no, copiar en AL el valor de DL
				xor ax,ax		;limpiar AX
				mov al,dl		;pasar valor de DX en AX para usar depues
				jmp @@cmp
		 
		 @@end: xor ax,ax
				mov al,dh	;copiar en AX total de iteraciones
				;add al,30h	;sumarle 30h para mostrarlo en pantalla
				;cmp al,39h	;cmp si el valor es mayor a 9
				;ja @@adjust ;si, se hace ajuste
				;call putchar;no, se imprime
				;jmp @@out
				
	  ;@@adjust: add al,7	 ;ajuste
				;call putchar ;print
	   ;@@out:
		        pop sp
				;pop dx
				;pop cx
				;pop bx
				;pop ax
				ret
	   _collatz ENDP
         END