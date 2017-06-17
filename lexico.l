%option yylineno
%option noyywrap
%{

#include <stdio.h>
#include <stdio.h>
#include <string.h>
#include "sintactico.tab.h"

extern int yyparse();

%}

%x stateRA stateNL stateCOM stateGOTO

%array
string 		\"[^\"]{1,128}\"
id_carac 	[a-zA-Z][a-zA-Z0-9]{0,11}\$
id_nume 	[a-zA-Z][a-zA-Z0-9]{0,11}
lineno		[1-9][0-9]*
numero 		0|[\+\-]?[1-9][0-9]*
ranasc		3[2-9]|[4-9]\d|1[0-1]\d|12[0-6]
menorque 	\<
mayorque    \>
igual		\=
coma 		\,
abrepar		\(
cierrapar	\)
dospuntos	\:
multipl		\*
division	\/
adicion		\+
sustracc	\-
chr 		CHR
left 		LEFT
right 		RIGHT
abs 		ABS
and 		AND
concat 		CONCAT
do 			DO
else 		ELSE
end 		END
endif 		ENDIF
goto 		GOTO
if 			IF
input 		INPUT
len 		LEN
not 		NOT
or 			OR
print 		PRINT
rem 		REM
comentario  [^\n]+
stop 		STOP
then		THEN
val 		VAL
wend 		WEND
while		WHILE
eol			\n
%%

<*>^{lineno}		{
	if(atoi(yytext)<1 || atoi(yytext)>65535){
		}else{
			BEGIN(INITIAL);
			return NUMLINEA;
		}
	}
<stateGOTO>{lineno}		{
	if(atoi(yytext)<1 || atoi(yytext)>65535){
		}else{
			BEGIN(INITIAL);
			return NUMLINEA;
		}
	}
<stateRA>{ranasc}		{
					BEGIN(INITIAL);
					return RAN_ASC;
				}
<stateCOM>{comentario}	{
					BEGIN(INITIAL);
					return COMENTARIO;
				}
<*>{eol}		{
					BEGIN(stateNL);
				}
<*>{goto}		{
					BEGIN(stateGOTO);
					return GOTO;
				}
<*>{rem}		{
					BEGIN(stateCOM);
					return REM;
				}
<*>{string}		{
					return STRING;
				}
<*>{chr}			{
					BEGIN(stateRA);
					return CHR;
				}
<*>{numero}		{
	if(atoi(yytext)<-32768 || atoi(yytext)>32767){
	}else{
		return ENTERO;
	}
}
<*>{abs}		{
					return ABS;
				}
<*>{and}		{
					return AND;
				}
<*>{concat}		{
					return CONCAT;
				}
<*>{do}			{
					return DO;
				}
<*>{else}		{	
					return ELSE;
				}
<*>{end}		{
					return END;
				}
<*>{endif}		{
					return ENDIF;
				}
<*>{if}			{
					return IF;
				}
<*>{input}		{
					return INPUT;
				}
<*>{len}		{
					return LEN;
				}
<*>{not}		{
					return NOT;
				}
<*>{or}			{
					return OR;
				}
<*>{print}		{
					return PRINT;
				}
<*>{stop}		{
					return STOP;
				}
<*>{then}		{
					return THEN;
				}
<*>{val}		{
					return VAL;
				}
<*>{wend}		{
					return WEND;
				}
<*>{while}		{
					return WHILE;
				}
<*>{left}		{
					return LEFT;
				}
<*>{right}		{
					return RIGHT;
				}
<*>{id_carac}	{
					return IDEN_CARAC;
				}
<*>{id_nume}	{
					return IDEN_NUME;
				}
<*>{menorque}	{
					return '<';
				}
<*>{mayorque}	{
					return '>';
				}
<*>{igual}		{
					return '=';
				}
<*>{coma}		{
					return ',';
				}
<*>{abrepar}	{
					return '(';
				}
<*>{cierrapar}	{
					return ')';
				}
<*>{dospuntos}	{
					return ':';
				}
<*>{multipl}	{
					return '*';
				}
<*>{division}	{
					return '/';
				}
<*>{adicion}	{
					return '+';
				}
<*>{sustracc}	{
					return '-';
				}
<*>[\n\t]		{
					BEGIN(INITIAL);
				}
%%

void yyerror(char * s) { 
	printf("Error sint%cctico en la l%cnea: %d", 160,161,yylineno);
}

int main(argc, argv)
int argc;
char **argv;
{
	int i = 0;
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
			
			fclose(yyin);
			return 1;
		}else{
				if(yyin!=NULL){
					i = yyparse();
					fclose(yyin);
				if(i==0){
						printf("An%clisis sint%cctico terminado.",160,160);
					}else{
						return 0;
					}
				}
		}
	}
    return 0;
}
  

