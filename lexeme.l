/*
    YML 
    Designed by: Abhay Raj Malhotra - 1215
                 Smarth Mehta - 1525 
                 Simranpreet Kaur - 1203 
                 Jasmine Kaur - 1258 
                 Ruby Sharma -
*/


%{
#include <stdio.h>
#include "y.tab.h"
char *yytext;

%}


%%

[ \t\n]+

\<		{ return yml_start; } 

"yml"		{ return YML;}

"bdr"		{ return BORDER;}

"nest"		{return NEST_MAX;}

"/yml"          {return YMLE; }

\>	         { return yml_end;}

\<circle\>	{return CIRCLE_START;} 

\<\/circle\>	{return CIRCLE_STOP;} 

\<square\>	{return SQUARE_START;} 

\<\/square\>	{return SQUARE_STOP;}

"clr"		{ return CLR; }

[1-9]*		{ yylval.num = atoi(yytext);return NUMBER;}

. 		yyerror("Syntax Error occured");

%%

int yywrap(void) 
{
    return 1;
}


int main(int argc, char *argv[]) 
 
{
    yyin = fopen(argv[1], "r"); // taking the file parameter in yyin
    yyparse(); // now calling parser
    
}

