MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
		contador	db	0
		segundos	db	0
		minutos		db	26
		horas		db	10
		flag		db	0
		newLine		db 	10,0
		lineas		db	'=================',0
		mensaje		db	'RELOJ NARANJA',0
		
   .CODE
    ;-----   Insert program, subrutine call, etc., here

	Principal  			PROC
						mov ax,0
						mov ds,ax	;ds apunta al inicio de la memoria
						
						mov bx,70h
						mov word ptr [bx],offset RELOJ ;los dos primeros bytes son para IP
						mov [bx+2],cs	;muevo dos adelante y guardo CS
						
						mov ax,@data 	;
						mov ds,ax     	;
						
						call clrscr
						call printMsg
						
			@@conteo:	cmp byte ptr [flag],1
						jne @@conteo
						call printReloj
						mov byte ptr [flag],0
						jmp @@conteo
							
						mov ah,04ch	     ; fin de programa
						mov al,0             ;
						int 21h              ; 

						ENDP

;===============================================================================
	RELOJ				PROC
						inc byte ptr [contador]
						cmp byte ptr [contador],18
						jb @@fin
						
						mov byte ptr [flag],1
						mov byte ptr [contador],0
						inc byte ptr [segundos]
						cmp byte ptr [segundos],60
						jb @@fin
						
						mov byte ptr [segundos],0
						inc byte ptr [minutos]
						cmp byte ptr [minutos],60
						jb @@fin
						
						mov byte ptr [minutos],0
						inc byte ptr [horas]
						cmp byte ptr [horas],24
						jb @@fin
						
						mov byte ptr [horas],0
						
		@@fin:			iret
						ENDP
;===============================================================================	
	printReloj		PROC
					
					mov ah,0
					mov bx,10
					
					mov cx,8
		@@llena:	mov al,32 	;espacio en blanco
					call putchar
					loop @@llena
					
					mov cx,8
		@@reset:	mov al,8
					call putchar
					loop @@reset
					
					mov al,[horas]
					call printNumBase	
					mov al,':'
					call putchar		
					mov al,[minutos]
					call printNumBase	
					mov al,':'
					call putchar		
					mov al,[segundos]
					call printNumBase	
					
					mov cx,8
		@@imprime:	mov al,8
					call putchar
					loop @@imprime
					
					ret
					ENDP
;===============================================================================				
	printNumBase	PROC
					
					mov cx,0
					mov dx,0
					
					cmp ax,0
					jz @@esCero
					
		@@next:	 	cmp ax,0 	;mientras dividendo > 0
					jbe @@print2
					div bx		;divido por la base
					push dx		;salvo el residuo en la pila
					mov dx,0	;reseteo a DX
					inc cx		;contador de divisiones
					jmp @@next
		
		@@print2:	pop dx			;saco residuos de la pila
					mov al,dl		
					cmp al,9		;verifico si es mayor a 10
					jbe @@continua	
					add al,7		;llegar a A-F en caso de hexa
		@@continua:	add al,30h		;ascii
					call putchar
					loop @@print2	;las veces que se hizo division
					jmp @@finPrint
					
		@@esCero:	add al,30h
					call putchar
					
		@@finPrint:	ret
					ENDP
;===============================================================================
	printMsg		PROC
					lea dx,lineas
					call puts
					mov al,10
					call putchar
					lea dx,mensaje
					call puts
					mov al,10
					call putchar
					lea dx,lineas
					call puts
					mov al,10
					call putchar	
					ret
					ENDP
				 END