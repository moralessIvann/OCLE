MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS

   .DATA
   msg	db 'ensablador',0 ;pathfinder
   msg1 db 'no',0
   msg2 db 'si',0

   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				call esIsograma
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
	esIsograma	PROC
				xor bx,bx
				xor ax,ax
				
				lea di,msg	;tomar offset de cadena
				
				mov bl,[di] ;tomar char y copiar a BL
	   @@begin: inc di		;inc DI para cmp nxt char
				;mov dx,di	;guardar offset
				push di		;guardar offset
				mov cl,[di] ;copiar en CL nxt char
				
	   @@again: cmp bl,[di]	;cmp char 
				je @@no		;si es igual, salta
				inc di		;no, inc DI para cmp con nxt char
				cmp byte ptr[di],0	;cmp si se llego al final de la cadena
				je @@nxtChar		;si es igual, salta
				jmp @@again			;no, repetir
				
	 @@nxtChar: ;mov di,dx		;guardar offset
				pop di			;guardar offset
				mov bl,cl	;copiar en BL char guardado anteriormente en @@begin
				cmp bl,0	;cmp si el final de cadena
				je @@yes	;si, salta
				jmp @@begin	;no, repetir
				
	     @@yes: ;mov ax,1	
				jmp @@out
					
		  @@no: ;mov ax,0
				pop di	;sacar offset
				
		 @@out: ret
				ENDP
         END