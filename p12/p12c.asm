MODEL small
.STACK 100h

INCLUDE procs.inc
LOCALS
.DATA
	
	string1		db	20 dup(0)		;guardar caracteres de la cadena en consola y a escribir en archivo 
	fileName	db	20 dup (0)		;guardar nombre del archivo Ej. 'test.txt'
	string2		db	(?) 			;aqui se depositan los caracteres leidos
	errorx		db	'error',0
	succes		db  13,10,'Archivo creado con exito',0

.CODE
	Principal	PROC	
				mov ax,@data
				mov ds,ax
				call clrscr
				
				call getStrings ;proc para obtener los nombres del archivo y cadena a escribir en el archivo
				
				call createFile
				call openFile
				call writeFile
				call readFile
				call closeFile				

				mov ah,04ch		;fn de programa
				mov al,0
				int 21h
				ret
				ENDP
	
	
	getStrings PROC
				
				
	;==========================================================================
				;obetener nombre del archivo de la consola
	;==========================================================================
				mov si,82h		  
				lea di,fileName	  ;copiar offset en DI (donde se guardaran los chars del nombre del archivo a usar)
				
	   @@again: mov bl,es:[si]	;copiar en BL el char apuntado por SI del seg ES
				cmp bl,20h		;cmp si char es 'SPACE'
				je @@end		;si, salta
				mov [di],bl		;no, copiar char en donde apunta DI
				inc di		;inc DI para guardar en sig posición de 'fileName'
				inc si		;inc SI para apuntar a nxt char en consola
				jmp @@again
				
		 @@end: ;lea dx,fileName ;pruebe para checar que si se obtienen los char de la consola
				;call puts
				
	;==========================================================================
				;obetener cadena de la consola que se guardara en archivo
	;==========================================================================
				xor di,di
				xor bx,bx
				xor dx,dx
				
				inc si	;la ultima posicion tomada fue el char de 'SPACE', inc para tomar el char de la cadena a escribir en archivo
			
				mov di,offset string1	  ;copiar offset en DI (donde se guardaran los chars del de la cadena  a escribir en archivo)
	  @@again2: mov dl,es:[si]	;copiar en DL el char apuntado por SI
				cmp dl,13		;cmp si char es 'ENTER'
				je @@out		;si, salta
				mov [di],dl		;no, copiar char en donde apunta DI
				inc di		;inc DI para guardar en sig posición de 'fileName'
				inc si		;inc SI para apuntar a nxt char
				jmp @@again2
			
		 @@out: ;lea dx,string1		;pruebe para checar que si se obtienen los char de la consola
				;call puts

				ret
				ENDP

	createFile  PROC
				mov ah,3ch
				lea dx,fileName
				mov cx,00
				int 21h
				mov si,ax
				jc @@errorx
				jnc @@ok
				
	  @@errorx: lea dx,errorx
				call puts
				jmp @@out
				
		  @@ok: lea dx,succes
				call puts
				
		 @@out: ret
				ENDP
	
	openFile	PROC	
				mov ah,03dh
				mov al,02		;read/write
				lea dx,fileName	;nombre de archivo a abrir
				int 21h
				mov si,ax		;devuelve handle
				jc @@errorx
				jmp @@out
	  @@errorx: lea dx, errorx
				call puts
				
		 @@out: ret
				ENDP
				
	writeFile	PROC
				mov ah,040h
				mov bx,si	;entra handle
				mov cx,20	;numero de bytes a escribir
				lea dx,string1;de donde se van a tomar los caracteres a escribir.
				int 21h
				jc @@errorx
				jmp @@out
				
	  @@errorx: lea dx,errorx
				call puts
				
		@@out:  ret
				ENDP
				
	readFile	PROC
				mov ah,03fh
				mov bx,si	;entra handle
				mov cx,20	;numero de bytes a leer
				mov dx,offset string2 ;donde se depositarán los caracteres leídos
				int 21h
				jc @@errorx
				jmp @@out
				
	  @@errorx: lea dx,errorx
				call puts
					
		 @@out: ret
				ENDP
				
	closeFile	PROC
				mov ah,3eh
				mov bx,si	;entra handle
				int 21h
				jc @@errorx
				jmp @@out
				
	  @@errorx: lea dx,errorx
				call puts
				
		@@out:  ret
				ENDP
	END