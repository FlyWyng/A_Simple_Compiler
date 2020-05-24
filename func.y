%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>

	#include "ST.h"

	//void fsym_put(char*,int);
	//void fsym_get(char*);
	int yylex();
	int yyerror(char *s);
	int sym[26];
	
%}

%token STRING PRINT NUM FUNCTION VAR DATA_TYPE RET
%right '='
%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%nonassoc uminu

%type <name> STRING
%type <number> NUM
%type <functions> PRINT 
%type <functions> FUNCTION
%type <functions> RET
%type <data_type> DATA_TYPE
%type <number> exp
%type <var> VAR

%union{
	char* name;
	int number;
	char* functions;
	char* data_type;
	char var;
	
}


%%

prog: stmts;

stmts: 	| PrintFunction ';' stmts
		| ArithmeticExpression ';' stmts
		| FunctionCall ';' stmts
		| FunctionDeclare stmts

PrintFunction: PRINT'('NUM')'{
				printf("%d",$3);
			}
			| PRINT'(''"'STRING'"'')'{
				printf("%s",$4);
			}
			| PRINT VAR{
				printf("%d",sym[$2]);
			}
			;
			

//progAE: stmtAE;

ArithmeticExpression: 	VAR '=' exp{ sym[$1]=$3; }
						//|VAR '=' STRING'('FunctionCallArg')'{ sym[$1]=(int)fsym_get($3);}
						|exp{printf("%d",$1);}

exp: 	 exp'+'exp{ $$=$1+$3;}
        |exp'-'exp{ $$=$1-$3;}
        |exp'*'exp{ $$=$1*$3;}
        |exp'/'exp{ $$=$1/$3;}
        |exp'%'exp{ $$=$1%$3;}
        |'-'exp{ $$=-$2;}
        |'('exp')'{ $$=$2;}
        |NUM
        |VAR { $$=sym[$1];} 
        ;
         

FunctionArg:	| DATA_TYPE VAR
				| DATA_TYPE VAR',' FunctionArg
				;

FunctionCallArg:| STRING
				| NUM
				| FunctionCallArg ',' FunctionCallArg 
				;

FunctionDeclare: FUNCTION STRING'('DATA_TYPE VAR')''{'stmts RET exp';''}'{
					fsym_put($2,$10);
				}
				//|FUNCTION NUM'('FunctionArg')''{'stmts RET STRING'}'{
				//	  fsym[$2]='$9';
				//};
FunctionCall:	FUNCTION STRING'('')'{
					//fsym_get($2);
					fsym_get($2);
				};
%%

int yyerror(char *s)
{
	printf("Syntax Error on line %s\n", &s);
	return 0;
}

int main()
{
    yyparse();
    return 0;
}