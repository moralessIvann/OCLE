extern int strcmp(char *, char *);

void main(void)
{
	int c;
	char *str1 = {"camino"}; /*cadena1*/
	char *str2 = {"cabeza"}; /*cadena2*/
	
	char *str11 = str1; /*cadena1*/
	c = strcmp(str2, str1);
	
	printf("cadena 1: %s\n",str11);
	printf("cadena 2: %s\n",str2);
	
	if(c==0)
	{	
		printf("Las cadenas son iguales.");	
	}	
	else if(c>0)
	{
		printf("La cadena 1 es mayor.");
	}
	else
	{	
		printf("La cadena 2 es mayor.");
	}
	
	getchar();
}