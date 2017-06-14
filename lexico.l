%{

#include <stdio.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

%}
%option yylineno
%option noyywrap
%array
ASIGNACION \=
TOKENS ABS|AND|CONCAT|DO|ELSE|END|ENDIF|GOTO|IF|INPUT|LEN|NOT|OR|PRINT|REM|STOP|THEN|VAL|WEND|WHILE|RAN_ASC|NUMLINEA|COMENTARIO|IDEN_CARAC|IDEN_NUME|ENTERO|STRING
CHAR CHR\$
LEFT LEFT\$
RIGHT RIGHT\$
STRING [\"].[\"]
ENTERO 0|[\+\-]?[1-9][0-9]*
IDEN_INT [a-zA-Z][a-zA-Z0-9]{0,11}
IDEN_CAR [a-zA-Z][a-zA-Z0-9]{0,11}\$

%%
"ABS"		{return ABS;}
"AND"		{return AND;}
"CHR"		{return CHR;}
"CONCAT"	{return CONCAT;}
"DO"		{return DO;}
"ELSE"		{return ELSE;}
"END"		{return END;}
"ENDIF"		{return ENDIF;}
"GOTO"		{return GOTO;}
"IF"		{return IF;}
"INPUT"		{return INPUT;}
"LEFT"		{return LEFT;}
"LEN"		{return LEN;}
"NOT"		{return NOT;}
"OR"		{return OR;}
"PRINT"		{return PRINT;}
"REM"		{return REM;}
"RIGHT"		{return RIGHT;}
"STOP"		{return STOP;}
"THEN"		{return THEN;}
"VAL"		{return VAL;}
"WEND"		{return WEND;}
"WHILE"		{return WHILE;}
"RAN_ASC"	{return RAN_ASC;}
"NUMLINEA"	{return NUMLINEA;}
"COMENTARIO"	{return COMENTARIO;}
"IDEN_CARAC"	{return IDEN_CARAC;}
"IDEN_NUME"		{return IDEN_NUME;}
"ENTERO"		{return ENTERO;}
"STRING"		{return STRING;}

{CHAR}			{return CHAR;}
{LEFT}			{return LEFT;}
{RIGHT}			{return RIGTH;}
{STRING}		{return STRING;}
{IDEN_CAR}		{return yytext;}
{IDEN_INT}		{return yytext;}
{ENTERO}		{return yytext;}
%%

int main(argc, argv)
int argc;
char **argv;
{
	if(argc <= 1){
		printf("Error: Falta par%cmetro en la l%cnea de comandos.\nUso: sintactico.exe archivo",160,161);
		return 1;
	}
	else if(argc > 2){
		printf("Error: Demasiados par%cmetros en la l%cnea de comandos.\nUso: sintactico.exe archivo",160,161);
		return 1;
	}else{
		yyin =fopen(argv[1],"r");
		if(yyin == NULL){
			printf("Error: El archivo no existe.");
			fclose(yyin);
			return 1;
		}else{
				if(yyin!=NULL){
					int i = yyparse();
					fclose(yyin);
				if(i==0){
						printf("An%clisis sint%cctico terminado.",160,160);
					}
				return 0;
				}
		}
	}
    return 0;
}
  

