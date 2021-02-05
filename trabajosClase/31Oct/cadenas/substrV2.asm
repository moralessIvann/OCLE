MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS
   print MACRO msg
   push dx
   lea dx,msg
   call puts
   pop dx
   ENDM

   .DATA
	 newLine	db	 13,10,0
	 msg		db  'La posicion inicial a copiar es mayor que la longitud de cadena',0
     destino	db	 30 dup(?),0
	 string		db	'cadenas doradas',0;'cadena para copiar',0 ;na para
	 
   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				xor ax,ax
				xor cx,cx
				
				mov si,offset string	;cadena fuente
				mov di,offset destino	;cadena destino
				mov ch,30		;posicion inicial a copiar
				mov cl,3		;cantidad de caracteres a copiar
				call substring
			
		        call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
							
	substring	PROC
				
				mov ax,si
		
				xor dx,dx
				xor bx,bx
				
 @@cmpPosition: cmp dh,ch
				ja @@getPosition
				cmp byte ptr[si],0
				je @@dontCopy
				inc si
				inc dh		;contador de caracteres en cadena fuente
				jmp @@cmpPosition
				
 @@getPosition: mov si,ax
				xor dx,dx
				
		 @@get: cmp ch,dl ;cmp si se llego a la posicion de cadena para copiar los chars
				je @@toCopy
				cmp byte ptr[si],0 ;cmp si se llego al final de cadena
				je @@out	;si, salta
				inc si		;no, inc SI 
				inc dl		;inc DI para cmp con total de chars a copiar
				jmp @@get	
		
	  @@toCopy: cmp byte ptr[si],0
				je @@end
				mov bl,[si] 	;copiar char apuntado por posicion de SI a BL
				mov byte ptr[di],bl  ;copiar char a cadena DESTINO
				inc di
				cmp cl,bh
				je @@end
				inc si
				inc bh 			;contador de caracteres copiados antes de llegar al valor null
				jmp @@toCopy
				
	@@dontCopy: ;mov ax,-1
				lea dx,msg
				call puts
				jmp @@out
				
		 @@end: lea dx,destino
				call puts
				mov al,bh ;cantidad de caracteres copiados
				add al,'0'
				call putchar		
				
		 @@out:
				ret
				ENDP
    END