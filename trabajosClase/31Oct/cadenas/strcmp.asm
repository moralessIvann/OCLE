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
      msg1	db	'poliia',0 ;cadena1 DI
	  msg2	db  'casass',0 ;cadena2 SI
	  msg3	db	13,10,0
	  msg4	db	'Las cadenas comparadas son iguales',0
	  msg5	db	'La cadena 1 es mayor',0
	  msg6	db	'La cadena 2 es mayor',0

   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea di,msg1
				lea si,msg2
				call strcmp
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
				
				
	strcmp	    PROC
				push si
				push di
				
				print msg1	;imprimir cadena a comparar
				print msg3
				print msg2
				
		@@cmp1: mov bl,[di]		;BX tiene caracter de strng1
				mov cl,[si]	
				cmp bl,cl		;cmp strng1 con strng2
				je @@cmp2		;si, salta
				jmp @@cmp3
				
	 
		@@cmp2: cmp byte ptr[di],0	;cmp si se llego a final de la cadena
				je @@equal			;si, son iguales
				inc di				;inc DI para cmp sig caracter
				inc si				;inc SI para cmp sig caracter	
				jmp @@cmp1
				
	   @@equal:	;mov ax,0
				print msg3
				print msg4
				jmp @@out
				
		@@cmp3: cmp bl,cl
				jb @@greater	;no, salta
				jmp @@below
		
	 @@greater: ;mov ax,1
				print msg3
				print msg5
				jmp @@out
				
	   @@below: ;mov ax,-1
				print msg3
				print msg6
				jmp @@out
	 
	 
				;mov ah,-1
				;jmp @@end
				
		 ;@@end: cmp ah,-1
				;je @@no
				;print msg3
				;print msg4
				;jmp @@out				
				
		;@@no:	print msg3
				;print msg5
				
		@@out:  pop di
				pop si
				ret
				ENDP
         END