%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%

[ \t\n]+	{};
"main" { return tMAIN; }
"const " { return tCONST; }
"int " { return tINT; }
"printf" {return tPRINT; }

[0-9]+	{
	  yylval.nb = atoi(yytext);
	  return tNB;
	}

[0-9]+[Ee]("+"|"-")?[0-9]+ {
	yyval.nb = (int)strtold(yytext, NULL);
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

[a-zA-Z][a-zA-Z_0-9]* {
	  yylval.var = yytext[0];
	  return tID;
	}
	
.	{ return tERROR; }
