/*
	flex lexico.l
	bison -d sintactico.y
	gcc -o PARSER lex.yy.c sintactico.tab.c  -lm
*/

%{
#include <math.h>
#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
int yylex();
int yyerror();
extern FILE *yyin;
extern FILE *yylineno;
extern FILE *errlx;
%}

%locations

%token TKN_CREATE TKN_TABLE TKN_SELECT TKN_FROM TKN_WHERE TKN_GROUP TKN_ORDER TKN_BY TKN_ASC TKN_DESC
%token TKN_NUMBER TKN_STRING
%token TKN_AND TKN_OR TKN_MAYORIGUAL TKN_MENORIGUAL TKN_MAYOR TKN_MENOR TKN_DISTINTO TKN_IGUAL
%token TKN_PTOCOMA TKN_COMA TKN_PTO TKN_APAR TKN_CPAR TKN_COMSIM TKN_COMDOB TKN_AST
%token ID NUM
%token ERROR

%start programa

%%
programa		: principal;
principal		: sentencia TKN_PTOCOMA opcsent;
opcsent			: /*vacio*/ | principal;
sentencia		: crear | seleccionar;
crear			: TKN_CREATE TKN_TABLE nuevatabla;
seleccionar		: TKN_SELECT idast TKN_FROM tabla opc;

idast			: identificadores | TKN_AST;
opc 			: /*vacio*/ | opc1 | opc2 | opc3;
opc1			: TKN_WHERE exp opc22;
opc22 			: /*vacio*/ | opc2 | opc3;
opc2			: TKN_ORDER TKN_BY tabla TKN_ASC  opc33	
				| TKN_ORDER TKN_BY tabla TKN_DESC opc33;
opc33 			: /*vacio*/ | opc3;
opc3			: TKN_GROUP TKN_BY ID;

exp				: identificadorcom operador identificadorcom opcexp
				| TKN_APAR identificadorcom operador identificadorcom opcexp TKN_CPAR opcexp;
opcexp			: /*vacio*/ | relacional exp;
identificadorcom: identificador | TKN_COMSIM texto TKN_COMSIM | NUM | TKN_COMDOB texto TKN_COMDOB ;
texto			: muchascosas | muchascosas texto;
muchascosas		: ID | TKN_COMA | TKN_PTO | NUM;

identificadores	: identificador 
				| identificador TKN_COMA identificadores;
identificador	: ID | ID TKN_PTO ID;

nuevatabla		: ID TKN_APAR deficolum TKN_CPAR;
deficolum		: ID tipo 
				| ID tipo TKN_COMA deficolum;
tipo			: TKN_NUMBER | TKN_STRING;

tabla			: ID 
				| ID TKN_COMA tabla;

operador		: TKN_MAYORIGUAL | TKN_MENORIGUAL | TKN_MAYOR | TKN_MENOR | TKN_DISTINTO | TKN_IGUAL;
relacional		: TKN_AND | TKN_OR;

%%

int yyerror(const char *str)
{
    if (errlx) {
   		fprintf(stderr,"Error lexico | Linea: %d\n%s\n",yylineno,str);
    }
    else {
    	fprintf(stderr,"Error sintactico | Linea: %d\n%s\n",yylineno,str);
    }
     getch();
}

int main (int argc, char *argv[])
{
printf("Parser\n");
	if (argc == 2)
	{
		yyin = fopen (argv[1], "rt");
		if (yyin == NULL)
		{
			printf ("El archivo %s no se puede abrir\n", argv[1]);
			exit (-1);
		}
	}
	else yyin = stdin;
	
	yyparse();
	return 0;
}; 