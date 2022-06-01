%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%

[ \t\n]+	{};
"main" { return tMAIN; }
"int " { return tINT; }
"printf" {return tPRINT; }
"if" { return tIF; }
"else" {
	return tELSE; 
	}
"while" { return tWHILE; }

[0-9]+	{
	  yylval.nb = atoi(strdup(yytext));
	  return tNB;
	}

[0-9]+[Ee]("+"|"-")?[0-9]+ {
	yylval.nb = (int)strtold(strdup(yytext), NULL);
	return tNB;
}
"="	{ return tEGAL; }
"-"	{ return tSOU; }
"+"	{ return tADD; }
"*"	{ return tMUL; }
"/"	{ return tDIV; }
"("	{ return tPO; }
")"	{ return tPF; }
"{" { return tOB; }
"}" { return tCB; }
";"	{ return tEOI; }
"," { return tVIRG; }
">" { return tSUP; }
"<" { return tINF; }

[a-zA-Z][a-zA-Z_0-9]* {
	  yylval.var = strdup(yytext);
	  return tID;
	}

