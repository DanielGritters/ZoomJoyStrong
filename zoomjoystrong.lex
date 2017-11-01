%{
/*
*Lex/Flex file
*Defines the valid lexemes in this language
*Daniel Gritters
*11/1/2017
*ZoomJoyStrong
*/
#include <stdio.h>
#include "zoomjoystrong.tab.h"
%}

%option noyywrap
%option yylineno

%%
end 			{return (END);}
\; 			{return (END_STATEMENT);}
point			{return (POINT);}
line			{return (LINE);}
circle			{return (CIRCLE);}
rectangle 		{return (RECTANGLE);}
set_color 		{return (SET_COLOR);}
[0-9]+			{yylval.iVal = atoi(yytext);
			return (INT);}
[0-9]*\.[0-9]+ 	{yylval.fVal = atoi(yytext);
			return (FLOAT);}

[\n| |\t]+

.			{printf("Invalid Lexeme");}
