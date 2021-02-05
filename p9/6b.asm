MODEL small
.STACK 100h

INCLUDE procs.inc
LOCALS
.DATA
	
	newLine		db  13,10,0
	string1		db	'casa de lasdad',0
	fileName	db	'test.txt',0
	string2		db	(?)
	error		db	'error',0
	exito		db	'exito',0

.CODE
	Principal	PROC	
				mov ax,@data
				mov ds,ax
				
				call clrscr

				call openFile
				call writeFile
				call readFile
				call closeFile				

				mov ah,04ch		;fn de programa
				mov al,0
				int 21h
				ret
				ENDP
	
				
	openFile	PROC		
				mov ah,03dh
				mov al,02		;read/write
				mov dx, offset fileName	;nombre de archivo a abrir
				int 21h
				mov si,ax		;devuelve handle
				
				jc @@error
				jmp @@out
		@@error:mov dx,offset error
				call puts
				
		 @@out: ret
				ENDP
				
	readFile	PROC
				mov ah,03fh
				mov bx,si	;entra handle
				mov cx,10	;numero de bytes a leer
				mov dx,offset string2 ;donde se depositarán los caracteres leídos
				int 21h
				
				jc @@error
				jmp @@out
		@@error:mov dx,offset error
				call puts
					
		 @@out: ret
				ENDP
	
	writeFile	PROC
				mov ah,040h
				mov bx,si	;entra handle
				mov cx,10	;numero de bytes a escribir
				mov dx,offset string1	;de donde se van a tomar los caracteres a escribir.
				int 21h
				
				jc @@error
				jmp @@out
		@@error:mov dx,offset error
				call puts
				
		@@out:  ret
				ENDP
				
	closeFile	PROC
				mov ah,3eh
				mov bx,si	;entra handle
				int 21h
				
				jc @@error
				jmp @@out
		@@error:mov dx,offset error
				call puts
				
		@@out:  ret
				ENDP
	END