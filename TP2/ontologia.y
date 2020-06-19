%{
#include <stdio.h>
#include <string.h>


int yylex();
int yyerror();	
char* yytext;
int yylineno;

%}

%union{
    char* id;
}

%token START 
%token <id>Relacao Conceito Progenitor Propriedade Sujeito
%type <id>Triplo Objeto Predicado

%%

Ontologia : START ListaTriplos
          ;

ListaTriplos : ListaTriplos Triplo 			
             | Triplo                       
             ;

Triplo : Sujeito Predicado Objeto 			{printf("%s    %s   %s", $1, $2, $3);}
       ;

Predicado : Relacao							{$$ = $1; printf("Apanhou Relacao %s\n", $1);}
          | Propriedade				    	{$$ = $1; printf("Apanhou Proprieadade %s\n", $1);}
          ;

Objeto : Progenitor							{$$ = $1; printf("Apanhou Progenitor %s\n", $1);}
	   | Conceito							{$$ = $1; printf("Apanhou Conceito %s\n", $1);}
	   ;



%%

#include "lex.yy.c"

int yyerror()
{
  printf("Erro sintatico ou lexico na linha: %d, com o texto: %s\n", yylineno, yytext);
}

int main(int argc, char **argv) {
	
	FILE* fp;
	fp = fopen("graph.tmp", "w+");
	fprintf(fp, "digraph familytree {\n\t");
	
	yyparse();	
	
	fprintf(fp, "}\n");
	fclose(fp);
	return 0;
}