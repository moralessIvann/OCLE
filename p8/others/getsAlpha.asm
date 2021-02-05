MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
		string 	db ?
		flag 	db 0

   .CODE
    ;-----   Insert program, subrutine call, etc., here

	Principal  			PROC
						mov ax,@data 	;Inicializar DS al la direccion
						mov ds,ax     	; del segmento de datos (.DATA)

						call clrscr

						call getsAlpha
						
						lea dx,string	
						call puts

						mov ah,04ch	     ; fin de programa
						mov al,0             ;
						int 21h              ; 

						ENDP

;===============================================================================
	getsAlpha			PROC
						
						lea bx,string
						
			@@getChar:	mov ah,01h
						int 21h
						cmp al,13		;es enter?
						je @@getString
						cmp al,65		;menor que 'A'?
						jb @@espacio
						cmp al,90		;mayor que 'Z'?
						ja @@minus
						jmp @@save
						
			@@minus:	cmp al,97		;menor que 'a'?
						jb @@espacio
						cmp al,122		;mayor que 'z'?
						ja @@espacio
						jmp @@save
						
			@@espacio:	cmp al,8
						jz @@esBS
						mov al,8		;recorro el cursor
						call putchar
						mov al,32
						call putchar
						mov al,8		;recorro el cursor
						call putchar
						jmp @@getChar
			
			@@esBS:		mov al,[bx-1]
						call putchar
						jmp @@getChar
						
			@@save:		mov [bx],al
						inc bx
						jmp @@getChar
						
	@@getString:		mov byte ptr [bx],0
						ret
						ENDP		
;===============================================================================						
				 END