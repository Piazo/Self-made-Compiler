%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tFL tEGAL tPO tPF tSOU tADD tDIV tMUL tERROR tMAIN tCONST tINT tPRINT tOB tCB tEOI
%token <nb> tNB tEXP
%token <var> tID
%type <nb> Expr DivMul Terme
%start Clio4
%%
Clio4 :	  tMAIN tOB Section tCB ;
Section : Expr tEOI Section | Expr tEOI;
Expr :	Declaration | DeclaAffec | Affectation  | Operation | Print;
Declaration : 	tCONST tID | tINT tID;
DeclaAffec :	tCONST tID tEGAL tNB | tINT tID tEGAL tNB;
Affectation : 	tID tEGAL tNB;
Operation :		
DivMul :	  DivMul tMUL Terme { $$ = $1 * $3; }
		| DivMul tDIV Terme { $$ = $1 / $3; }
		| Terme { $$ = $1; } ;
Terme :		  tPO Expr tPF { $$ = $2; }
		| tID { $$ = var[$1]; }
		| tNB { $$ = $1; } ;
%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
  printf("Calculatrice\n"); // yydebug=1;
  yyparse();
  return 0;
}
