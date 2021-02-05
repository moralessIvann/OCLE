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

						call getsNum
						
						lea dx,string	
						call puts

						mov ah,04ch	     ; fin de programa
						mov al,0             ;
						int 21h              ; 

						ENDP

;===============================================================================
	getsNum				PROC
						
						lea bx,string
						
			  @@get:	call captChar
						cmp al,13		;es enter?
						je @@getString
						
						cmp al,48		;menor que cero?
						jb @@espacio
						cmp al,57		;mayor que nueve?
						ja @@espacio
						jmp @@save
						
			@@espacio:	cmp al,8
						jz @@esBS
						
						mov al,8
						call putchar
						mov al,32
						call putchar
						mov al,8
						call putchar
						jmp @@get
						
			@@esBS:		mov al,[bx-1]
						call putchar	
						
						jmp @@get
						
			@@save:		mov [bx],al
						inc bx
						jmp @@get
						
	@@getString:		mov byte ptr [bx],0
						ret
						ENDP		
;===============================================================================
	captChar			PROC
						mov ah,01h
						int 21h
						ret
						ENDP
;===============================================================================

						
				 END