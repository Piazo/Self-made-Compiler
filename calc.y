%{
#include <stdlib.h>
#include <stdio.h>
#include "symboltable.h"
#include "assembleur.h"
int var[26];
void yyerror(char *s);
int type = 2;
%}
%union {int nb; char* var; char* type; char* str}
%token tFL tEGAL tPO tIF tPF tCONDEGAL tDIFF tSUP tINF tSUPEG tINFEG tAND tOR tWHILE tSOU tADD tDIV tMUL tERROR tMAIN tCONST tINT tPRINT tOB tCB tEOI tVIRG
%token <nb> tNB
%token <var> tID
%type <nb> Expr 
%type <type> TypeNb

%start Clio4
%%

Clio4 : tMAIN tPO Parametres tPF Body ;

Body : tOB {incr_profondeur} Declarations Instructions tCB {decrem_profondeur};


Parametres : Parametre
     	   	| Parametre tVIRG Parametres;

Parametre : TypeNb tID {addsymbol($2);};

TypeNb : tINT {$$ = $1;};

Declarations : Declaration Declarations
				| ;

Declaration : TypeNb IDs tEOI
			| TypeNb tID tEGAL tNB tEOI {addsymbol($2); add_instruc_to_tab("AFC", get_index($2), $4, 0);};

IDs : tID {addsymbol($1);}
	| tID tVIRG tID {addsymbol($1);};

Instructions : Instruction Instructions
			| ;

Instruction : Affectation;


Affectation : tID tEGAL Operation tEOI {add_instruc_to_tab("COP", get_index($1), pop_var_tempo(), 0)}

Operation : Operation tADD MultDivi {add_ope_to_tab("ADD");}
			| Operation tSOU MultDivi {add_ope_to_tab("SOU");}
			| MultDivi;

MultDivi : MultDivi tMUL Terme {add_ope_to_tab("MUL");}
			| MultDivi tDIV Terme {add_ope_to_tab("DIV");}
			| Terme;

Terme : tID {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("COP", Var_Tempo, get_index($1), 0);}
		| tNB {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("AFC", Var_Tempo, $1, 0);};



%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
	printf("Calculatrice\n");
	yydebug=1;
	yyparse();
	return 0;
}
