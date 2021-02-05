extern int palindromo(char *);

char *str= {"anita lava la tina"};

void main (void)
{
	int c;
	c = palindromo(str);
	
	if(c==1)
		printf("Si es palindromo\n");
	else
		printf("No es palindromo");

	getchar();
}