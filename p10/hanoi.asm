MODEL small
   .STACK 100h

 INCLUDE procs.inc

       LOCALS

   .DATA
   disk     db    'Disco ',0
   points   db    ': ',0
   arrow   db    '->',0
   println  db    '',13,10,0

   .CODE

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr

				mov al,3
				mov bl,'A'
				mov cl,'B'
				mov dl,'C'
				call torresDeHanoi

				mov ah,04ch	     ; fin de programa
				mov al,0         ;
				int 21h          ;
				ENDP
				
				

  torresDeHanoi PROC

				cmp al,1	;caso base 
				jne @@recursion
				call print
				jmp @@end

	@@recursion:xchg cl,dl	
				push ax
				dec al
				call torresDeHanoi
				
				pop ax
				xchg cl,dl
				call print
				push ax
				xchg bl,cl
				dec al
				
				
				call torresDeHanoi
				pop ax

		 @@end: ret
				ENDP

		  print PROC
			    push ax ; guardar registros 
			    push dx 

			    lea dx,disk   ;imprime 'Disco'
			    call puts       

			    add al,30h     ;prepara al # de disco para mostrar
				call putchar   ;muestra numero de disco

				lea dx,points  ;imprime ': '
				call puts             

				mov al,bl       ;imprime torre origen
				call putchar    

				lea dx,arrow   ;imprime ' -> '
				call puts             

				pop dx        ;recupera nombre de torre en DL
				mov al,dl     ;para mover su valor a AL
				call putchar  ;y poder mostrarlo

				push dx    		;guardar DX
				lea dx,println  ;salto de linea
				call puts               

				pop dx  ;recupera registros
				pop ax  

				ret
				ENDP
	END
