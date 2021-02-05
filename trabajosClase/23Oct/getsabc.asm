MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
      msg       db  'Ingresa cadena: ',0
	  msg2		db	' Ultimo caracter no valido',13,10,0
	  cadena	db  (?)	;para guardar caracteres ingresados
	
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 		;Inicializar DS al la direccion
				mov ds,ax     		; del segmento de datos (.DATA)

				call clrscr			;limpiar pantalla
				mov dx,offset msg	;mostrar msg1
				call puts
				
				mov si,offset msg2	;mostrar msg2
				mov bx,offset cadena;copiar desplazamiento de cadena en BX, para guardar caracteres en 'cadena', BX direcciona a 'cadena'
				call getsABC			;llamada a funcion
	
				call getch

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

	getsABC  	PROC
				
	 @@capture: inc bx		;inc BX para almacenar los caracteres en una lugar de memoria consecutivo al anterior
				mov ah,01h	;servicio entrada de caracter con eco
				int 21h
				mov [bx],al	;copiar el caracter ingresado por teclado a lugar de memoria direccionado por bx (se guarda en cadena)
			
				cmp al,'Z' ;cmp si caracter es menor a 'Z'
				ja @@minus			 ;si, salta a etiqueta minus, para comparar si esta en rango de minisculas
				cmp al,'A' ;cmp si es menor a 'A'
				jb @@noValido		 ;si, salta 
				jmp @@capture		 ;no, volver a capturar
				
	  @@minus:  cmp al,'z' ;cmp si caracter es mayor a 'z'
			    ja @@noValido		 ;si, salta
			    cmp al,'a' ;no, cmp si es menor a 'a'
			    jb @@noValido		 ;no es menor, salta
				jmp @@capture		 ;si es menor, captura otro caracter
				
	@@noValido: cmp al,13  ;cmp si caracter es tecla ENTER
				je @@out			 ;si, salir
				mov dx,offset si	 ;no, por lo que se ha validado que no es un caracter del abc o ABC
				call puts
				
		@@out:  mov byte ptr[bx],0	;caracter nulo copiado despues de ingresar el ultimo caracter
				ret
				ENDP
         END