%{

#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

numbers		([0-9])+
alpha		([a-zA-Z])+

%%

"void"  |
"int"   |
"char"  |
"int*"  |
"char*"           	{yylval.data_type = strdup(yytext);return (DATA_TYPE);}
[a-z]				{yylval.var= *yytext - 'a'; return (VAR);}
"print"				{yylval.functions = strdup(yytext); return (PRINT);}
"return"			{yylval.functions = strdup(yytext); return (RET);}
"fn"				{yylval.functions = strdup(yytext); return (FUNCTION);}
{alpha}				{sscanf(yytext, "%s", yylval.name); return (STRING);}
{numbers}      		{yylval.number = atoi(yytext); return (NUM);}
[ \t\r\v\f]			;
.					return yytext[0];
%%

int yywrap(void){
	return 1;
}
