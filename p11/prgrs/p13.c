extrn invertirPalabras(char, char *); 

void main(void)
{
	int a;
	
	char *str = {"universidad autonoma de baja california"};    /*5*/
    char strDesty[40]={0};  	     /*5*/
	
	a = invertirPalabras(str,strDesty);
						
	printf("%s",strDesty);				
	
	getch();
}
	