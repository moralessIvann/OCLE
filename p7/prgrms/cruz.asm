MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here

 INCLUDE procs.inc
 
       LOCALS
	   n	EQU	6

   .DATA
      msg       db  'Cruz de asteriscos',0,13,10
	  newLine   db  13,10,0
	  spaceLine db  ' ',0
	
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)

				call clrscr
				mov dx,offset msg
				call puts
				mov dx,offset newLine
				call puts
				
				call cruz
				call getch

				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP
						
				
	cruz		PROC
	
				xor bx,bx
				;xor cx,cx
				mov bh,00 ;i=0
				
	  @@for1:   cmp bh,n  ;i<=6
				ja @@out
				mov bl,00 ;j=0
				
	  @@for2:   cmp bl,n  ;j<=6
				ja @@newLine
				
	    @@if:   cmp bl,bh  ;i==j
				je @@print
				
	@@elseif:   add bl,bh
				;add cl,bl
				cmp bl,6  ;i+j==6
				jne @@spaceLine
				
	 @@print:	mov al,2Ah
				call putchar
				inc bl   ;j++
				jmp @@for2
  
  @@spaceLine:  lea dx,spaceLine		
				call puts
				inc bl   ;j++
				jmp @@for2
				
	@@newLine:  lea dx,newLine
				call puts
				inc bh  ;i++
				jmp @@for1
	
	@@out:      ret
				ENDP
         END