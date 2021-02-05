extern int borrar(int , int , char *);

void main(void)
{
	char *str = {"libre"};
	int c;
	int total = 3;
	int position =3;
	
		
	c = borrar(position,total,str);
	
	if(c>=0)
		printf("La cantidad de caracteres borrados fue %d.",c);
	else
		printf("La posicion inicial es mayor a la longitud de la cadena.");
	
	getch();
}