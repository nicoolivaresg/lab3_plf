%{

#include <stdio.h>
#include <stdio.h>
#include <string.h>


%}
%option noyywrap
%array
ASIGNACION \=
PALABRAS_RESERVADAS ABS|AND|CONCAT|DO|ELSE|END|ENDIF|GOTO|IF|INPUT|LEN|NOT|OR|PRINT|REM|STOP|THEN|VAL|WEND|WHILE|RAN|NUMLINEA|CTE_CARAC|CTE_NUME|IDEN_CARAC|IDEN_NUME|ASC|CONCAT
CHAR CHR\$
LEFT LEFT\$
RIGHT RIGHT\$
STRING [\"].{1,128}[\"]
ENTERO 0|[\+\-]?[1-9][0-9]*
ARITMETICO \+|\-|\*|\/
RELACIONAL \>|(>=)|\<|(<=)|(<>)
IDEN_INT [a-zA-Z][a-zA-Z0-9]{0,11}
IDEN_CAR [a-zA-Z][a-zA-Z0-9]{0,11}\$




%%

{PALABRAS_RESERVADAS}	{fprintf(yyout,"%s",yytext);}
{CHAR}			{fprintf(yyout,"CHAR");}
{LEFT}			{fprintf(yyout,"LEFT");}
{RIGHT}			{fprintf(yyout,"RIGHT");}
{STRING}		{fprintf(yyout,"STRING");}
{ASIGNACION}	{fprintf(yyout,"ASIGNACION");}
{ARITMETICO}	{fprintf(yyout,"ARITMETICO");}
{RELACIONAL}	{fprintf(yyout,"RELACIONAL");}
{IDEN_CAR}		{fprintf(yyout,"IDENTIFICADOR");}
{IDEN_INT}		{fprintf(yyout,"IDENTIFICADOR");}
{ENTERO}		{
	if(atoi(yytext)<-32768 || atoi(yytext)>32767){
		fprintf(yyout,"%s",yytext);
	}else{
		fprintf(yyout,"ENTERO");
	}
}
%%

int main(argc, argv)
int argc;
char **argv;
{
	if(argc <= 2){
		printf("Error: Faltan par%cmetros en la l%cnea de comandos.\nUso: lexico.exe archivo_entrada archivo_salida",160,161);
		return 0;
	}
	else if(argc > 3){
		printf("Error: Demaciados par%cmetros en la l%cnea de comandos.\nUso: lexico.exe archivo_entrada archivo_salida",160,161);
		return 0;
	}else{
		yyin =fopen(argv[1],"r");
		yyout =fopen(argv[2],"r");
		if(yyin == NULL){
			printf("Error: El archivo de entrada no existe.");
			fclose(yyin);
			fclose(yyout);
			return 0;
		}else if(yyout!=NULL){
			printf("Error: El archivo de salida ya existe.");
			fclose(yyin);
			fclose(yyout);
			return 0;
		}
	}
	yyin=stdin;
	yyin =fopen(argv[1],"r");
	yyout =fopen(argv[2],"w");
	yylex();
	fclose(yyin);
	fclose(yyout);	
    return 0;
}
  

