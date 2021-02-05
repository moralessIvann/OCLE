MODEL small
   .STACK 100h


 INCLUDE procs.inc
 
       LOCALS

   .DATA
	msg1	db	' El numero en binario es: ',0
	
   .CODE
  
    Principal  	PROC
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				
				lea dx,msg1
				call puts
				
				xor cx,cx	;limpiar registro
				xor ax,ax	;limpiar registro
				mov bl,2	;base a dividir
				mov al,0FFh  ;num a convertir a binario
				call printBinRec	;llmada de proc
	
				call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
                ENDP

	printBinRec PROC
				
				cmp al,0	;cmp si al es cero
				je @@out	;si, salta
				div bl		;no, dividir
				mov cl,ah	;copiar residuo en CH para guardar en la pila
				push cx		;copiar residuo a pila
				mov ah,0	;limpiar residuo
				call printBinRec	;llamada a proc recursivo
				
				pop ax		;sacar residuo de la pila
				add ax,30h	;ajuste para imprimir en pantalla
				call putchar ;imprimir
				
		 @@out: ret
				ENDP
         END