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
%token tFL tEGAL tPO tIF tPF tELSE tCONDEGAL tDIFF tSUP tINF tSUPEG tINFEG tAND tOR tWHILE tSOU tADD tDIV tMUL tERROR tMAIN tCONST tINT tPRINT tOB tCB tEOI tVIRG
%token <nb> tNB
%token <var> tID
%type <nb> Element Condition 
%type <type> TypeNb

%start Clio4
%%

Clio4 : tMAIN tPO Parametres tPF Body {print_instruction_table();} ;

Body : tOB {incr_profondeur} Declarations Instructions tCB {decrem_profondeur};


Parametres : Parametre
     	   	| Parametre tVIRG Parametres;

Parametre : TypeNb tID {addsymbol($2);};

TypeNb : tINT { $$ = $1; };

Declarations : Declaration Declarations
				| ;

Declaration : TypeNb IDs tEOI
			| TypeNb tID tEGAL tNB tEOI {addsymbol($2); add_instruc_to_tab("AFC", get_index($2), $4, -1);};

IDs : tID {addsymbol($1);}
	| tID tVIRG tID {addsymbol($1);};

Instructions : Instruction Instructions
			| ;

Instruction : Affectation;
			| tIF tPO Condition tPF {push_cond_if(); 
				add_instruc_to_tab("JMF", $3, -1, -1); pop_var_tempo()} 
				Body {push_cond_else(); add_instruc_to_tab("JMP", -1, -1, -1); 
				pop_condition_if();} Else {pop_condition_else();}
			| tWHILE {push_while();} tPO Condition tPF {push_cond_if(); 
				add_instruc_to_tab("JMF", $4, -1, -1); pop_var_tempo();} Body 
				{pop_while(); pop_condition_if();}
			| tPRINT tPO Element tPF tEOI {add_instruc_to_tab("PRI", $3, -1, -1);};

Else : tELSE Body | {remove_jmp();};

Element : tNB {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("AFC", Var_Tempo, $1, -1); pop_var_tempo()}
		| tID {$$ = get_index($1);};

Condition : Element tEGAL tEGAL Element {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("EQU", Var_Tempo, $1, -1); pop_var_tempo()}
			| Element tINF Element {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("INF", Var_Tempo, $1, -1); pop_var_tempo()}
			| Element tSUP Element {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("SUP", Var_Tempo, $1, -1); pop_var_tempo()}
			| Element {$$ = $1; push_var_tempo();};

Affectation : tID tEGAL Operation tEOI {add_instruc_to_tab("COP", get_index($1), pop_var_tempo(), -1);};

Operation : Operation tADD MultDivi {add_ope_to_tab("ADD");}
			| Operation tSOU MultDivi {add_ope_to_tab("SOU");}
			| MultDivi;

MultDivi : MultDivi tMUL Terme {add_ope_to_tab("MUL");}
			| MultDivi tDIV Terme {add_ope_to_tab("DIV");}
			| Terme;

Terme : tID {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("COP", Var_Tempo, get_index($1), -1);}
		| tNB {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("AFC", Var_Tempo, $1, -1);};



%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
	printf("Calculatrice\n");
	yydebug=1;
	yyparse();
	return 0;
}
