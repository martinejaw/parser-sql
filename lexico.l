%{
#include <stdio.h>
#include <conio.h>  
#include "sintactico.tab.h"
int numTOK=0; int numID=0; int numNUM=0; int numOP=0; int numCAR=0;
int errlx=0;
%}

%option noyywrap
%option yylineno

salir [sS][aA][lL][Ii][Rr]

TKN_AND [Aa][Nn][Dd]
TKN_OR [Oo][Rr]

TKN_MENORIGUAL ("<=")
TKN_MAYORIGUAL (">=")
TKN_DISTINTO ("!=")
TKN_MAYOR \>
TKN_MENOR \<
TKN_IGUAL \=

TKN_CREATE [Cc][Rr][Ee][Aa][Tt][Ee]
TKN_TABLE [Tt][Aa][Bb][Ll][Ee]
TKN_SELECT [Ss][Ee][Ll][Ee][Cc][Tt]
TKN_FROM [Ff][Rr][Oo][Mm]
TKN_WHERE [Ww][Hh][Ee][Rr][Ee]
TKN_GROUP [Gg][Rr][Oo][Uu][Pp]
TKN_ORDER [Oo][Rr][Dd][Ee][Rr]
TKN_BY [Bb][Yy]
TKN_ASC [Aa][Ss][Cc]
TKN_DESC [Dd][Ee][Ss][Cc]

TKN_STRING [Ss][Tt][Rr][Ii][Nn][Gg]
TKN_NUMBER [Nn][Uu][Mm][Bb][Ee][Rr]

TKN_APAR \(
TKN_CPAR \)
TKN_PTOCOMA \;
TKN_COMA \,
TKN_PTO \.
TKN_COMSIM \' 
TKN_COMDOB \"
TKN_AST \*

numero [0-9]+
ID [A-Za-z][A-Za-z0-9]*
ignora (" "|\t|\n)*


%%

{salir}		{printf("\nCantidades encontradas\nPalabras reservadas: %d\nIDs: %d\nNumeros: %d\nOperadores: %d\nCaracteres especiales: %d\nCaracteres no reconocidos: %d\n", numTOK,numID,numNUM,numOP, numCAR,errlx); return 0;}
{ignora}	{}

{TKN_AND}	{printf("Se encontro el TKN_AND %s\n", yytext); ++numTOK; return TKN_AND;}
{TKN_OR}	{printf("Se encontro el TKN_OR: %s\n", yytext); ++numTOK; return TKN_OR;}

{TKN_APAR}	{printf("Se encontro el TKN_APAR: %s\n", yytext); ++numCAR; return TKN_APAR;}
{TKN_CPAR}	{printf("Se encontro el TKN_CPAR: %s\n", yytext); ++numCAR; return TKN_CPAR;}
{TKN_PTOCOMA}	{printf("Se encontro el TKN_PTOCOMA: %s\n", yytext); ++numCAR; return TKN_PTOCOMA;}
{TKN_COMA}	{printf("Se encontro el TKN_COMA: %s\n", yytext); ++numCAR; return TKN_COMA;}
{TKN_PTO}	{printf("Se encontro el TKN_PTO: %s\n", yytext); ++numCAR; return TKN_PTO;}
{TKN_COMSIM}		{printf("Se encontro el TKN_COMSIM: %s\n", yytext); ++numCAR; return TKN_COMSIM;}
{TKN_COMDOB}		{printf("Se encontro el TKN_COMDOB: %s\n", yytext); ++numCAR; return TKN_COMDOB;}
{TKN_AST}		{printf("Se encontro el TKN_AST: %s\n", yytext); ++numCAR; return TKN_AST;}

{TKN_MAYORIGUAL}	{printf("Se encontro el TKN_MAYORIGUAL: %s\n", yytext); ++numOP; return TKN_MAYORIGUAL;}
{TKN_MENORIGUAL}	{printf("Se encontro el TKN_MENORIGUAL: %s\n", yytext); ++numOP; return TKN_MENORIGUAL;}
{TKN_DISTINTO}	{printf("Se encontro el TKN_DISTINTO: %s\n", yytext); ++numOP; return TKN_DISTINTO;}
{TKN_MENOR}	{printf("Se encontro el TKN_MENOR: %s\n", yytext); ++numOP; return TKN_MENOR;}
{TKN_MAYOR}	{printf("Se encontro el TKN_MAYOR: %s\n", yytext); ++numOP; return TKN_MAYOR;}
{TKN_IGUAL}	{printf("Se encontro el TKN_IGUAL: %s\n", yytext); ++numOP; return TKN_IGUAL;}

{TKN_CREATE}		{printf("Se encontro el TKN_CREATE: %s\n", yytext); ++numTOK; return TKN_CREATE;}
{TKN_TABLE}		{printf("Se encontro el TKN_TABLE: %s\n", yytext); ++numTOK; return TKN_TABLE;}
{TKN_SELECT}		{printf("Se encontro el TKN_SELECT: %s\n", yytext); ++numTOK; return TKN_SELECT;}
{TKN_FROM}		{printf("Se encontro el TKN_FROM: %s\n", yytext); ++numTOK; return TKN_FROM;}
{TKN_WHERE}		{printf("Se encontro el TKN_WHERE: %s\n", yytext); ++numTOK; return TKN_WHERE;}
{TKN_GROUP}		{printf("Se encontro el TKN_GROUP: %s\n", yytext); ++numTOK; return TKN_GROUP;}
{TKN_ORDER}		{printf("Se encontro el TKN_ORDER: %s\n", yytext); ++numTOK; return TKN_ORDER;}
{TKN_BY}		{printf("Se encontro el TKN_BY: %s\n", yytext); ++numTOK; return TKN_BY;}
{TKN_ASC}		{printf("Se encontro el TKN_ASC: %s\n", yytext); ++numTOK; return TKN_ASC;}
{TKN_DESC}		{printf("Se encontro el TKN_DESC: %s\n", yytext); ++numTOK; return TKN_DESC;}

{TKN_NUMBER}		{printf("Se encontro el TKN_NUMBER: %s\n", yytext); ++numTOK; return TKN_NUMBER;}
{TKN_STRING}		{printf("Se encontro el TKN_STRING: %s\n", yytext); ++numTOK; return TKN_STRING;}

{ID}		{printf("Se encontro el TKN_ID: %s\n", yytext);++numID; return ID;}
{numero}	{printf("Se encontro el TKN_NUM: %s\n", yytext);++numNUM; return NUM;}
.			{printf("Caracter no reconocido: %s\n", yytext); ++errlx; return ERROR;}

%%
