extern int collatz(int x);

void main(void)
{
	int c, num =6;
	
	c = collatz(num);
	printf("El total de iteraciones para el numero %d fueron %d.",num,c);
	
	getchar();
}