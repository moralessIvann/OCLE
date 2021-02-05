MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
      msg       db  'Ingresa numeros: ',0
	  msg1		db	13,10,'Los numeros ingresados son: ',0
	  cadena	db  (?)	;para guardar caracteres ingresados
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				mov dx,offset msg
				call puts
				
				mov bx,offset cadena	;copiar desplazamiento de cadena en BX, para guardar caracteres en 'cadena'
				call getsNum
				
				mov dx,offset msg1
				call puts
				mov dx,offset cadena	;********************************
				call puts

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

	getsNum	    PROC
				
	 @@capture: mov ah,01h	;servicio entrada de caracter con eco
				int 21h
				mov [bx],al	;copiar el caracter ingresado por teclado a lugar de memoria direccionado por bx (se guarda en cadena)
				cmp al,13	;cmp si caracter es tecla ENTER
				je @@out	;si, salir
				
				cmp al,'0'	;cmp si el num es menor a '0'
				jb @@out	;si, siguiente instruccion
				cmp al,'9'	;no, cmp con '9'
				ja @@out	;si, es mayor salta
				
				inc bx		;no, inc bx para guardar espacio
				mov byte ptr[bx],' '	;copiar espacio en donde apunta bx
				inc bx		;nc bx para guardar el sig digito
				jmp @@capture	;salta a capturar
				
		@@out:  mov byte ptr[bx],0	;caracter nulo copiado despues de ingresar los digitos
				ret
				ENDP
         END