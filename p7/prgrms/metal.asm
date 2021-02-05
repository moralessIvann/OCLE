MODEL small
   .STACK 100h

   ;----- Insert INCLUDE "filename" directives here
   ;----- Insert EQU and = equates here
	  N     EQU 20
	  CR	EQU 13
	  LF 	EQU	10
   
 INCLUDE procs.inc
 
       LOCALS

   .DATA
		grado10 db 'ES GRADO 10',CR,LF,0
		grado9  db 'ES GRADO 9',CR,LF,0
		grado8  db 'ES GRADO 8',CR,LF,0
		grado7  db 'ES GRADO 7',CR,LF,0
		grado6  db 'ES GRADO 6',CR,LF,0
		grado5  db 'ES GRADO 5',CR,LF,0
		;newLine db  13,10,0
		
		;metal a evaluar
		a       db   (90) ;dureza,
		b       db   (3)  ;carbon y
		m       db   (9) ;maleabilidad del material
	  
   .CODE
    ;-----   Insert program, subrutine call, etc., here

    Principal  	PROC
	
				mov ax,@data 	;Inicializar DS al la direccion
				mov ds,ax     	; del segmento de datos (.DATA)
				call clrscr
				call grado_metal
                ENDP
	
   grado_metal  PROC
				;estandar de metal
				dureza = 50    ; a>50  61
				carbon = 7		; b<7   3
				maleable = 56   ; c>56  57
			
				cmp byte ptr[a],dureza	
				jbe @@grado8
				cmp byte ptr[b],carbon
				jae @@grado7
				cmp byte ptr[m],maleable
				jbe @@grado9
				mov dx,offset grado10
				call puts
				jmp @@salir
			
	@@malok:	cmp byte ptr[m],maleable
				jbe @@grado5
				jae @@grado6; maleable cumple
				

	@@grado9: 	mov dx,offset grado9 
				call puts	
				jmp @@salir
	
	@@grado8:	cmp byte ptr[b],carbon
				jae @@malok
				cmp byte ptr[m],maleable
				jbe @@grado6
				mov dx,offset grado8 
				call puts
				jmp @@salir
	
	@@grado7:	cmp byte ptr[m],maleable
				jbe @@grado6 ;dureza cumple
				mov dx,offset grado7
				call puts
				jmp @@salir
	
	@@grado6:	mov dx,offset grado6
				call puts
				jmp @@salir
	
	@@grado5:	mov dx,offset grado5
				call puts
				jmp @@salir
			
	@@salir:	call getch
				mov ah,04ch	     ; fin de programa
				mov al,0             ;
				int 21h              ; 
				
			
				ENDP

    END