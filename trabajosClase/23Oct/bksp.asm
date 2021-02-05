MODEL small
   .STACK 100h

	;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc

       LOCALS

   .DATA
      cadena  db (?)
      cadena2 db 'Ingresa cadena: ',0

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr

				mov dx,offset cadena2
				call puts

				mov dx,offset cadena
				call backSpace
				call puts

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ;

                ENDP

      backSpace PROC
				push ax	;guardar en pila
				push bx

				mov bx,dx	;mover offset a bx

	  @@again:  call getchar
				cmp al,13	 ;cmp si es 'ENTER'
				je @@out     ;si, salta
				cmp al,8  	 ;no, cmp si es backSpace
				je isletter	 ;es letra
				cmp al,' '   ;si es espacio
				je isletter	 ;es letra
				cmp al,'A'	
				jb notletter
				cmp al,'z'
				ja notletter
				cmp al,'Z'
				jbe isletter
				cmp al,'a'
				jb notletter
				jmp isletter


	notletter:  mov al,8
				call putchar
				mov al,32
				call putchar
				mov al,8
				call putchar
				jmp @@again

	isletter:	cmp al,8  	;cmp si al es backSpace
				jne @@cmp1      ;no, almacenalo
				cmp bx,dx   ;si, cmp bx
				jne @@cmp2  	; si

				push ax 	;no hay algo
				mov al,00 	;14 igual desplazamiento derecha
				call putchar
				pop ax
				jmp @@again  ;no, pedir de otro caracter

		@@cmp2:	push ax       ;si, borra el caracter anterior
				char = 32     ;ESPACIO ascii
				mov ax,char
				call putchar
				char = 8      ;BACKSPACE ascii
				mov ax,char
				call putchar
				dec bx        ;decrementa indice
				pop ax
				jmp @@again   ;empieza de nuevo

		@@cmp1: mov [bx],al
				inc bx
				jmp @@again
	 
	 @@out:  	mov byte ptr[bx],0

				pop bx	;recuperar
				pop ax
				ret
                ENDP
         END
