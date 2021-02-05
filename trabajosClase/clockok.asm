MODEL small
   .STACK 100h

 INCLUDE procs.inc

       LOCALS

   .DATA
    i dw 0    ;contador
    s dw 0    ;segundos
    m dw 0    ;min
    h dw 0     ;horas
    flag db 0  ;bandera

   .CODE
   

 Principal  PROC
			mov ax,0
			mov ds,ax

			mov ds:word ptr[70h],offset clock
			mov ds:[72h],cs

			mov ax,@data 	
			mov ds,ax     	

			base = 10
			mov bx,base
			call clrscr

	  wh:
			cmp byte ptr[flag],1
			jne wh

			mov byte ptr[flag],0

			mov ax,[h]        ;horas
			call printNumBase
			mov al,':'
			call putchar


			mov ax,[m]          ;minutos
			call printNumBase
			mov al,':'
			call putchar

			mov ax,[s]          ;segundos
			call printNumBase

			mov al,13           ;nueva linea
			call putchar
			mov al,10
			call putchar

			jmp wh

			mov ah,04ch	     
			mov al,0             
			int 21h              
			ENDP

	  clock PROC
			sec=60
			min=60

			inc word ptr[i]
			cmp word ptr[i],18
			jne @@final             ;if contador!= 18
									;if contador==18
			mov byte ptr[flag],1    ;actualizar bandera
			mov word ptr[i],0 		;contador igual a 0
			inc word ptr[s]
			cmp word ptr[s],sec
			jne @@final
			sec=0
			mov word ptr[s],sec
			inc word ptr[m]
			cmp word ptr[m],min
			jne @@final
			min=0
			mov word ptr[m],min
			inc word ptr[h]
	@@final:iret
			ENDP

printNumBase PROC
            push ax 
            push cx
            push dx

            xor dx,dx 
            contador = 0
            mov cx,contador

        doo:
            div bx      
            add dx,30h  
            cmp dx,39h  
            jbe l1      
            add dx,7h   
        l1: push dx
            inc cx
            xor dx,dx 
            cmp ax,0 
            jne doo

     print: pop ax
            call putchar
            loop print
			
            pop dx
            pop cx
            pop ax
            ret
        ENDP
       END
