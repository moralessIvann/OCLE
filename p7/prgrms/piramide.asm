MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS
	   num  EQU 9

   .DATA
    msg		db		'Piramide de numeros',0
	i		db      (?)
	j		db      (?)
	newLine db      13,10,0
	
	
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				call ciclo_for
				
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP				

	ciclo_for   PROC
				mov  dx,offset msg
				call puts
				
				xor bx,bx  ;limpiar regitro bx
				mov bh,00  ;i=0
				
	@@for1:     mov dx,offset newLine
				call puts
				
				inc bh  ;i=1
				cmp bh,num  ;i<=9
				mov bl,01   ;j=1
				ja @@out
				
	@@for2:     cmp bl,bh  ;j<=i
				ja @@for1
				
				;printNum
				mov al,bh
				add al,'0'
				call putchar
				inc bl
				jmp @@for2

	@@out:		mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
         END