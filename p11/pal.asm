dosseg
.model small
.code
	public _palindromo
	
	_palindromo PROC
				push sp
				mov bp,sp
				mov si,[bp+4]
				
				
				push si
				xor bx,bx
				xor di,di
					
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
	  @@again2: cmp byte ptr[si],0	
				je @@yes
				jmp @@cmp
				
 @@removeSpace: dec di
				jmp @@again
				
@@removeSpace2: inc si
				jmp @@again2
				
		@@yes:  mov ax,1
				jmp @@out
		
		 @@no:  mov ax,0
				
		 @@out: pop sp
				ret
	_palindromo ENDP		
   
END
			 