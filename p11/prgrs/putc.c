extern void myputchar(char x);
extern int suma(int a, int b);


/*char *str = {"Hola mundo !!\n"};*/

void main (void)
{
	char *str = {"Hola mundo !!\n"};
	int a=56, b=2, c;
	
	while(*str){   /* usar (str) en palindromo*/
		myputchar(*str++);
	}
	
	c = suma(a,b);
	printf("\n\nEl resultado de %d mas %d es %d.",a,b,c);
	
	getchar();
}