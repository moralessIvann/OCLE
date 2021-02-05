dosseg
.model small
.code

   public _esIsograma
				
	_esIsograma	PROC
				push bp
				mov bp,sp
				
				mov di,[bp+4] ;recibe cadena
				mov si,[bp+4]
				mov bl,[si]
				
				cmp byte ptr[si],0	
				je @@yes
				
	   @@begin: cmp byte ptr[di],0 
				je @@nxtChar
				inc di
				cmp bl,[di]
				je @@no
				jmp @@begin
				
	 @@nxtChar: inc si
				push si
				call _esIsograma
				pop si
				jmp @@out
				
	     @@yes: mov ax,1	
				jmp @@out
					
		  @@no: mov ax,0
				
		 @@out: pop bp
				ret
	_esIsograma ENDP
				
END