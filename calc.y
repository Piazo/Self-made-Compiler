%{
#include <stdlib.h>
#include <stdio.h>
#include "symboltable.h"
#include "assembleur.h"
#include <string.h>

int var[26];
void yyerror(char *s);
int type = 2;
extern FILE * yyin;
%}

%union {int nb; char* var; char* type; char* str}
%token tEGAL tPO tPF tSUP tINF tSOU tADD tDIV tMUL tMAIN tINT tPRINT tOB tCB tEOI tVIRG
%token <nb> tNB tIF tELSE tWHILE
%token <var> tID
%type <nb> Element Condition Else Operation MultDivi Terme

%start Clio4
%%

Clio4 : tMAIN tPO Parametres tPF Body
	| tMAIN tPO tPF Body;	

Parametres : Parametre
     	   	| Parametre tVIRG Parametres;

Parametre : tINT tID {addSymbol($2);};

Body : tOB {incr_profondeur();} DeclaInstrs tCB {decrem_profondeur();};

DeclaInstrs : DeclaInstr DeclaInstrs 
			| ;

DeclaInstr : Declarations |
			 Instructions;

Declarations : Declaration Declarations
				| ;

Declaration : tINT IDs tEOI
			| tINT tID tEGAL tNB tEOI {addSymbol($2); add_instruc_to_tab("AFC", get_index($2), $4, -1);};

IDs : tID {addSymbol($1); add_instruc_to_tab("AFC", get_index($1), -1, -1);}
	| tID tVIRG IDs {addSymbol($1); add_instruc_to_tab("AFC", get_index($1), -1, -1);};

Instructions : Instruction Instructions
			| ;

Instruction : Affectation
			| tIF tPO Condition tPF {$1=add_instruc_to_tab("JMF", $3, -1, -1);} 
				Body Else {patchJMF($1, (($7)+1));}
			| tWHILE tPO Condition tPF {$1 = add_instruc_to_tab("JMF", $3, -1, 51);} Body 
				{int indexJMP = add_instruc_to_tab("JMP", $1, -1, 51); patchJMF($1, (indexJMP+1));}
			| tPRINT tPO Element tPF tEOI {add_instruc_to_tab("PRI", $3, -1, -1);};

Else : tELSE {$1 = add_instruc_to_tab("JMP", -1, -1, -1);} Body 
				{int indLastInstr = get_index_last_instr(); patchJMP($1, indLastInstr); $$=$1;} 
		| {$$=(get_index_last_instr()-1);};


Element : tNB {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("AFC", Var_Tempo, $1, -1); $$=Var_Tempo;}
		| tID {$$ = get_index($1);};

Condition : Element tEGAL tEGAL Element {int Var_Tempo=push_var_tempo(); add_instruc_to_tab("EQU", Var_Tempo, $1, $4); $$=Var_Tempo;}
			| Element tINF Element {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("INF", Var_Tempo, $1, $3); $$=Var_Tempo;}
			| Element tSUP Element {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("SUP", Var_Tempo, $1, $3); $$=Var_Tempo;}
			| Element {$$ = $1;};

Affectation : tID tEGAL Operation tEOI {add_instruc_to_tab("COP", get_index($1), pop_var_tempo(), -1);};

Operation : Operation tADD MultDivi {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("ADD", Var_Tempo, $1, $3); $$=Var_Tempo;}
			| Operation tSOU MultDivi {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("SOU", Var_Tempo, $1, $3); $$=Var_Tempo;}
			| MultDivi {$$=$1;};

MultDivi : MultDivi tMUL Terme {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("MUL", Var_Tempo, $1, $3); $$=Var_Tempo;}
			| MultDivi tDIV Terme {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("DIV", Var_Tempo, $1, $3); $$=Var_Tempo;}
			| Terme {$$=$1;};

Terme : tID {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("COP", Var_Tempo, get_index($1), -1); $$=Var_Tempo;}
		| tNB {int Var_Tempo = push_var_tempo(); add_instruc_to_tab("AFC", Var_Tempo, $1, -1); $$=$1;};



%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(int argc, char** argv) {
	printf("Projet Systeme Info\n");
	//yydebug=1;
	if(argc != 2) { 
		fprintf(stderr, "Usage: %s <input file>\n", argv[0]); 
		exit(1); 
		} 
	FILE *f = fopen(argv[1], "r"); 
	if(f == NULL) { 
		fprintf(stderr, "Failed to open file \"%s\".\n", argv[1]); 
		exit(1); 
	} 
	yyin = f; 
	yyparse(); 
	print_instruction_table();
	interpreter();
	fclose(f);
	return 0;
}
