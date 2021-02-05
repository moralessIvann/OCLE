MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS
	   ;macros
	print MACRO msg
		  push dx
		  lea dx,msg
		  call puts
		  pop dx
		  ENDM

   .DATA
      msg1  db  'lluvia fuerte',0
	  msg2	db	13,10,'El caracter no esta en la cadena',0
	  msg3	db	13,10,'El caracter esta en la posicion: ',0	  

   .CODE
  
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea bx,msg1		;apuntador cadena
				mov al,'t'		;caracter a buscar
				call strchr
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

		strchr  PROC
				push bx
				push ax
				push cx
				push di
				
				print msg1
				xor cx,cx	;contador para saber en que posicion se encuetra el caracter
				xor di,di
				
		 @@cmp: cmp byte ptr msg1[di],al	;cmp si caracter esta en cadena
				je @@yes					;si, salta
				inc di						;no inc DI para buscar en sig posicion
				inc cl						;inc contador
				cmp byte ptr msg1[di],0		;cpm si se llego al final de la cadena
				je @@no						;si llego a final, entonces no se encontro caracter en cadena
				jmp @@cmp					;repetir
						
		@@yes:	print msg3			;print caracter
				mov al,cl
				add al,30h			;sumarle '0' para mostrarlo en pantalla
				cmp al,39h
				ja @@adjust
				call putchar		;print caracter
				jmp @@out			;salta 
				
	 @@adjust:  add al,7h
				call putchar
				jmp @@out
		
		  @@no:	mov al,-1
				print msg2			;no se encontro caracter en cadena
		        
				
		 @@out: pop di				;recuperar registros
				pop cx
				pop ax
				pop bx
				ret
				ENDP
         END