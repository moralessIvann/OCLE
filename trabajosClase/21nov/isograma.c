extern int esIsograma(char *);


void main(void)
{
	int c;
	char *str={"pathfinder"}; /*si isograma*/
	
	c = esIsograma(str);
	printf("La cadena es: %s\n\n",str);
	
	if(c==1)
		printf("Si es un isograma");
	else
		printf("No es un isograma");
	
	
	getch();
	
}