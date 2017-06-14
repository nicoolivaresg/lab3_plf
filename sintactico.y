 %{
 #include <stdio.h>
  #include <stdlib.h>
  extern int yylex(void);
  extern char *yytext;
  extern int linea;
  extern FILE *yyin;
  void yyerror(char *s);
%}

%token ABS
%token AND
%token CHR
%token CONCAT
%token DO
%token ELSE
%token END
%token ENDIF
%token GOTO
%token IF
%token INPUT
%token LEFT
%token LEN
%token NOT
%token OR
%token PRINT
%token REM
%token RIGHT
%token STOP
%token THEN
%token VAL
%token WEND
%token WHILE
%token RAN_ASC
%token NUMLINEA
%token COMENTARIO
%token IDEN_CARAC
%token IDEN_NUME
%token ENTERO
%token STRING

%%
lineabas : /* empty */
	NUMLINEA lineagen
	;
lineagen : /* empty */
	lineagen ':' sentencia 
	| sentencia
	;
funcion_num : /* empty */
	ABS '(' expre_nume ')' 
	| LEN '(' string ')' 
	| VAL '(' string ')'
	;
funcion_str : /* empty */
	CHR '(' RAN_ASC ')' 
	| LEFT '(' string ',' expre_nume ')' 
	| RIGHT '(' string ',' expre_nume ')'
	;
string : /* empty */
	STRING 
	| IDEN_CARAC
	;
sentencia :	/* empty */
	END 
	| STOP 
	| GOTO NUMLINEA 
	| IF '(' expresion ')' THEN lineagen ENDIF 
	| IF '(' expresion ')' THEN lineagen ELSE lineagen ENDIF 
	| INPUT mensaje variable 
	| PRINT impreso 
	| REM COMENTARIO 
	| WHILE '(' expresion ')' DO lineagen WEND 
	| WEND 
	| IDEN_CARAC '=' expre_carac 
	| IDEN_NUME '=' expre_nume
	;
mensaje : /* empty */
	STRING
	;
variable : /* empty */
	identificador ',' variable 
	| identificador
	;
impreso : /* empty */
	constante cont_impreso 
	| identificador cont_impreso
	;
cont_impreso : /* empty */
	',' constante cont_impreso 
	| ',' identificador cont_impreso
	;
constante : /* empty */
	STRING 
	| ENTERO
	;
identificador : /* empty */
	IDEN_CARAC 
	| IDEN_NUME
	;
expresion :	/* empty */
	expresion AND expre_rel 
	| expresion OR expre_rel 
	| NOT expresion 
	| '(' expresion ')' 
	| expre_rel
	;
expre_rel :	/* empty */
	expre_nume '>' expre_nume 
	| expre_nume '>''=' expre_nume 
	| expre_nume '<' expre_nume 
	| expre_nume '<''=' expre_nume 
	| expre_nume '=' expre_nume 
	| expre_nume '<''>' expre_nume 
	| expre_carac '>' expre_carac 
	| expre_carac '>''=' expre_carac 
	| expre_carac '<' expre_carac 
	| expre_carac '<''=' expre_carac 
	| expre_carac '=' expre_carac 
	| expre_carac '<''>' expre_carac 
	| expre_nume 
	| expre_carac
	;
expre_carac : /* empty */
	expre_carac CONCAT expre_carac 
	| funcion_str 
	| string
	;
expre_nume : /* empty */
	expre_nume '+' expre_nume 
	| expre_nume '-' expre_nume 
	| expre_nume '/' expre_nume 
	| expre_nume '*' expre_nume 
	| '-' expre_nume 
	| funcion_num 
	| ENTERO 
	| IDEN_NUME 
	| '(' expre_nume ')'
	;
%%

void yyerror(char * s) { 
	printf("Error sint%cctico en la l%cnea: %s\n", 160,161,s);
}

