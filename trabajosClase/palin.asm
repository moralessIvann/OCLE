MODEL small
   .STACK 100h

 INCLUDE procs.inc
 
       LOCALS
	   
	  ;macro para salto y nueva linea
	  newLine MACRO 
			  push dx
			  lea dx,nuevaLinea
			  call puts
			  pop dx
			  ENDM
			  
	   print  MACRO msg
			  push dx
			  lea dx,msg
			  call puts
			  pop dx
			  ENDM
	  

   .DATA
      ;nuevaLinea	 db	  13,10,0
	  msg1       db  'Si es palindromo',0
	  msg2       db  'No es palindromo',0
	  string	 db	 'anita lava la tina',0
	
   .CODE
  
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea si,string			;SI tiene direccion de string
				call palindromo
				
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
				
	palindromo  PROC
				push si
				xor bx,bx
				xor di,di
			
				;mov bl,sString	;pasar size de cadena original a DL
				;add si,bx		;sumar size a SI para colocarse al final de la cadena
				;mov di,si		;copiar offset a DI (final de la cadena)
				;pop si			;sacar offset original de la pila (inicio de la cadena)
				;dec di
				;xor bx,bx
				
				;=========== otra manera =============
		@@cmp1: cmp byte ptr[si],0
				je @@endString
				inc si
				jmp @@cmp1
				
   @@endString: mov di,si
				pop si
				dec di
				
		 @@cmp: mov bl,[di]
				cmp byte ptr[si],bl
				jne @@no
				dec di
				inc si
				cmp byte ptr[di],32
				je @@removeSpace
	   @@again: cmp byte ptr[si],32
				je @@removeSpace2
	  @@again2: cmp byte ptr[si],0	;============== faltaba cmp con byte
				je @@yes
				jmp @@cmp
				
 @@removeSpace: dec di
				jmp @@again
				
@@removeSpace2: inc si
				jmp @@again2
				
		@@yes:  print msg1
				jmp @@out
		
		 @@no:  print msg2
				
		 @@out: ret
				ENDP

         END