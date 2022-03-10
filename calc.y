%{
#include <stdlib.h>
#include <stdio.h>
int var[26];
void yyerror(char *s);
%}
%union { int nb; char var; }
%token tFL tEGAL tPO tIF tPF tCONDEGAL tDIFF tSUP tINF tSUPEG tINFEG tAND tOR tWHILE tSOU tADD tDIV tMUL tERROR tMAIN tCONST tINT tPRINT tOB tCB tEOI tVIRG
%token <nb> tNB tEXP
%token <var> tID
%type <nb> Expr 
%start Clio4
%%

Clio4 : tMAIN tPO tPF Body ;

Body : tOB Section tCB;

Section : Expr tEOI Section
		| Expr tEOI
		| Expr Section
		|;

Expr : Declarations
	| DeclaAffec 
	| Affectation  
	| Operation 
	| Print 
	| Fun 
	| If
	| While
	| TypeNb;

Fun :	TypeVar tID tPO Parametres tPF Body;

Parametres : Declaration tVIRG Parametres
     	   	| Declaration
       		|;

If : tIF tPO Conditions tPF Body;

While : tWHILE tPO Conditions tPF Body;

Orand : tOR | tAND;

Conditions : Condition Orand Conditions | Orand Conditions | Condition;
Condition : Comparaison | tID | tNB;

Comparaison : Diff | Infeg | Supeg | Sup | Inf | Condegal;
Diff : TermeOpe tDIFF TermeOpe;
Infeg : TermeOpe tINFEG TermeOpe;
Supeg : TermeOpe tSUPEG TermeOpe;
Sup : TermeOpe tSUP TermeOpe;
Inf : TermeOpe tINF TermeOpe;
Condegal : TermeOpe tCONDEGAL TermeOpe;

TypeVar : tCONST tINT 
		| tINT;

TypeNb : tNB 
	| tEXP;

Declarations : TypeVar Declaration Findeclaration;

Declaration : tID | tID tEGAL Expr;
Findeclaration : tEOI
				| tVIRG Declaration Findeclaration;

DeclaAffec : TypeVar tID tEGAL TypeNb tEOI 
			| TypeVar tID tEGAL Operation tEOI;

Affectation : tID tEGAL TypeNb tEOI 
			| tID tEGAL Operation tEOI;

Operation :	Add 
			| Sub 
			| Mul 
			| Div;

Add : TermeOpe tADD TermeOpe;

Sub : TermeOpe tSOU TermeOpe;

Mul : TermeOpe tMUL TermeOpe;

Div : TermeOpe tDIV TermeOpe;

TermeOpe : tPO Operation tPF 
		| Operation 
		| tID 
		| TypeNb;

Print : tPRINT tPO tID tPF;

%%
void yyerror(char *s) { fprintf(stderr, "%s\n", s); }
int main(void) {
	printf("Calculatrice\n");
	yydebug=1;
	yyparse();
	return 0;
}
