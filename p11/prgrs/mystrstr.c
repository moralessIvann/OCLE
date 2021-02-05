extern int strstr(char * , char * );

char *strSource = {"esfera dorada y verde"};	/*carro azul*/
char *str = {"dorada"};


void main(void)
{
	int c;
	
	c = strstr(strSource, str);
	
	if(c>=0)
		printf("La palabra se encontro a partir de la posicion: %d.",c);
	else
		printf("La palabra no se encontro en la cadena.");
	
	getchar();
}