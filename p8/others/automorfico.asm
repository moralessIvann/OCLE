MODEL small
.STACK 100h

;----- Insert INCLUDE "filename" directives here
;----- Insert EQU and = equates here

INCLUDE procs.inc

    LOCALS

.DATA

	msg 	db	'Es autoformico',0
	msg2	db	'No es autoformico',0
		
.CODE
 ;-----   Insert program, subrutine call, etc., here

 Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				
				mov dx,9376
				call esAutomorfico
				
				cmp ax,1
				jne @@nop
				
				lea dx,msg
				call puts
				jmp @@termina
				
	@@nop:		lea dx,msg2
				call puts
	@@termina:	call getch

				mov ah,04ch	     ; fin de programa
				mov al,0         ;
				int 21h          ;

				ENDP

;=======================================================
	esAutomorfico	PROC
					mov cx,0
					mov bx,10 	;base
					
					push dx		;salvo dato original
					mov ax,dx
					
		@@itera:	mov dx,0	;solo quiero dividir ax
					div bx		
					inc cx		;contador
					cmp ax,0	;cociente ==0?
					jnz @@itera
					
					mov ax,1
		@@mulBase: 	mul bx
					loop @@mulBase
					
					mov bx,ax	;bx=base multiplicada
					pop dx		;recupero dato
					push dx		;lo vuelvo a salvar
					
					mov ax,dx
					mul dx		;elevo al cuadrado
					div bx		;divido entre la base
					
					pop cx
					cmp dx,cx	;comparo residuo con el dato original
					je @@true
					mov ax,0
					jmp @@fin
					
		@@true:		mov ax,1			
		@@fin:		ret
					ENDP
      END
