 %{
  extern int yylex(void);
  extern char *yytext;
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
%token COMENTARIO
%token IDEN_CARAC
%token IDEN_NUME
%token ENTERO
%token STRING
%token NUMLINEA
%token RAN_ASC

%left '*' '/'
%left '+' '-'
%right NOT
%left AND OR
%right '='

%%
start : lineabas | lineabas start;

lineabas: NUMLINEA lineagen;

lineagen: lineagen ':' sentencia | sentencia;

funcion_num:	ABS '(' expre_nume ')' | LEN '(' string ')' | VAL '(' string ')';

funcion_str:	CHR '(' RAN_ASC ')' | LEFT '(' string ',' expre_nume ')' |
RIGHT '(' string ',' expre_nume ')';

string: STRING | IDEN_CARAC;

sentencia:	END | STOP | GOTO NUMLINEA | IF '(' expresion ')' THEN lineagen ENDIF |
IF '(' expresion ')' THEN lineagen ELSE lineagen ENDIF |
INPUT mensaje variable | PRINT impreso | REM COMENTARIO |
WHILE '(' expresion ')' DO lineagen WEND | WEND |
IDEN_CARAC '=' expre_carac | IDEN_NUME '=' expre_nume;

mensaje: STRING |;

variable: identificador ',' variable | identificador;

impreso: constante cont_impreso | identificador cont_impreso |;

cont_impreso: ',' constante cont_impreso | ',' identificador cont_impreso |;

constante: STRING | ENTERO;

identificador: IDEN_CARAC | IDEN_NUME;

expresion:	expresion AND expre_rel | expresion OR expre_rel |
NOT expresion | '(' expresion ')' | expre_rel;

expre_rel:	expre_nume '>' expre_nume | expre_nume '>''=' expre_nume |
expre_nume '<' expre_nume | expre_nume '<''=' expre_nume |
expre_nume '=' expre_nume | expre_nume '<''>' expre_nume |
expre_carac '>' expre_carac | expre_carac '>''=' expre_carac |
expre_carac '<' expre_carac | expre_carac '<''=' expre_carac |
expre_carac '=' expre_carac | expre_carac '<''>' expre_carac | expre_nume |
expre_carac;

expre_carac: expre_carac CONCAT expre_carac | funcion_str | string;

expre_nume:	expre_nume '+' expre_nume | expre_nume '-' expre_nume |
expre_nume '/' expre_nume | expre_nume '*' expre_nume | '-' expre_nume |
funcion_num | ENTERO | IDEN_NUME | '(' expre_nume ')';
