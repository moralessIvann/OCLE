extern int substr(int, int ,  char *);

void main(void)
{
	char *strSource = {"cadenas"}; /*SI*/
	/*char *strDestiny [30]={""};*/
	int position=3;
	int total=8;
	int c;
	
	c = substr(total, position, strSource);
	
	if(c>=0)
		printf("La cantidad de caracteres copiados fue %d.",c);
	else
		printf("La posicion inicial a copiar es mayor que la longitud de cadena.");
	
	getchar();
}