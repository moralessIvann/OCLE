extern int strchr(char *, char);

void main(void)
{
	int c;
	char letter = 'a';
	char *str = {"un dia normal"};
	
	c = strchr(str, letter);
	
	if(c>=0)
		printf("El caracter se encuetra en la posicion: %d.",c);
	else
		printf("El caracter no se encuetra en la cadena.");
	
	getch();
}
	