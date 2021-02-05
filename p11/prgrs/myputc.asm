dosseg
.model small
.code
	public _myputchar
	
	_myputchar PROC
			   push bp
			   mov bp,sp
			   
			   mov dl,[bp+4]
			   mov ah,2
			   int 21h
			   
			   pop bp
			   ret
   _myputchar  ENDP
   
   public _suma
   _suma	PROC
			push bp
			mov bp,sp
			
			mov bx,[bp+4]
			mov ax,[bp+6]
			add ax,bx
			
			pop bp
			ret
			ENDP		
   
END
			 