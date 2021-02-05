extern int strcmp(char *, char *);
extern int strstr(char * , char *);
extern int strchr(char *, char);
extern int substr(int, int , char *, char *);
extern int borrar(int , int , char *, char *);

void main(void)
{
	int opcion;
	int e,d,c,b,a;	
	
	char *str1 = {"hola murdo"};  /*1*/
	char *str2 = {"hola mundo"};  /*1*/
	
	char *str3 = {"cielo gris y azul"}; /*2*/
	char *str4 = {"gris"};              /*2*/
	
	char *str5 = "olimpiada"; 	  /*3*/
	char letter = 'd'; 			  /*3*/
	
	char strDestx[30]={0};  	     /*4*/
	char *str6 = {"el universo"};    /*4*/
	int positionx = 6, totalx = 22;   /*4*/
	
	char *str7 = {"jeans y tennis"};    /*5*/
	char strDesty[40]={0};  	     /*5*/
	int positiony = 2, totaly = 3;   /*5*/
	
		do{
			printf("\n\n===MENU===\n");
			printf("1. STRCMP\n");
			printf("2. STRSTR\n");
			printf("3. STRCHR\n");
			printf("4. SUBSTR\n");
			printf("5. ERASE\n");
			printf("6. Salir\n");
			printf("Ingresa opcion: ");
			scanf("%d",&opcion);
			
			switch(opcion)
			{
				case 1: e = strcmp(str2,str1);
						printf("Cadena 1: %s\n",str1);
						printf("Cadena 2: %s\n",str2);
						if(e==0)
						{	
							printf("Las cadenas son iguales.");	
						}	
						else if(e>0)
						{
							printf("La cadena 1 es mayor.");
						}
						else
						{	
							printf("La cadena 2 es mayor.");
						}
					break;
				
				case 2: d = strstr(str4,str3);
						printf("Cadena fuente: %s\n",str3);
						printf("Cadena a buscar: %s\n",str4);
						if(d>=0)
						{	
							printf("La palabra se encontro a partir de la posicion: %d.",d);
						}
						else
						{	
							printf("La palabra no se encontro en la cadena.");
						}
					break;
					
				case 3: c = strchr(str5,letter);
						printf("Cadena fuente: %s\n",str5);
						printf("Caracter a buscar: %c\n",letter);
						if(c>0)
						{	
							printf("El caracter se encuetra en la posicion: %d.",c);
						}	
						else
						{	
							printf("El caracter no se encuetra en la cadena.");
						}	
					break; 
					
				case 4:	b = substr(totalx,positionx,str6,strDestx); 
						printf("Cadena fuente: %s\n",str6);
						if(b>=0)
						{
							printf("La cantidad de caracteres copiados fue %d.\n",b);
							printf("La cadena resultante es: %s",strDestx);
						}
						else
						{
							printf("La posicion inicial a copiar es mayor que la longitud de cadena.");
						}
					break;
					
				case 5:	a = borrar(positiony,totaly,str7,strDesty);
						printf("Cadena fuente: %s\n",str7);
						if(a>=0)
						{	
							printf("La cantidad de caracteres borrados fue %d.\n",a);
							printf("La cadena resutltante es: %s.",strDesty);
						}	
						else
						{	
							printf("La posicion inicial es mayor a la longitud de la cadena.");
						}	
					break;
				
				case 6:
					break;
				default: printf("Opcion no valida\n");
					break;	
			}
		}while(opcion!=6);
	
	getchar();
}