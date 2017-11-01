%{

/*
*Bison file
*Defines the Context Free Grammar for this language
*This language is for creating shapes
*Daniel Gritters
*11/1/2017
*ZoomJoyStrong
*/
#include <stdlib.h>
#include <stdio.h>
#include "zoomjoystrong.h"
/*
*yyerror takes in an error string and throws an error using the string
*/
int yyerror(char* s);
/*
*checkColor takes in the different color numbers and checks to see if they are in range
*It returns and int 1 if the color is in range and 0 if it is not
*/
int checkColor(int r, int g, int b);
/*
*checkRange checks to see if the origin(x,y) is inside the scope of the window
*It also returns 1 if the origin is in the window and 0 if it is not
*/
int checkRange(int x, int y);
%}

%union { int iVal; float fVal; char* sVal; }
%token END_STATEMENT
%token END
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <iVal> INT
%token <fVal> FLOAT

%%

program: 		statement_list end;

statement_list:		statement
	      | 	statement statement_list
	      ;

statement:		point 
	 | 		line 
	 | 		circle
	 |		rectangle 
	 | 		set_color
	 ;

point:			POINT INT INT END_STATEMENT 
			{
			 if( checkRange($2, $3) == 1){
			 	point($2, $3);
			 }
			};

line: 			LINE INT INT INT INT END_STATEMENT
			{
			 if(checkRange($2, $3) == 1 && checkRange($4, $5) == 1){
			 	line($2, $3, $4, $5);
			 }
			};

circle: 		CIRCLE INT INT INT END_STATEMENT
			{
			 if(checkRange($2, $3) == 1){
			 	circle($2, $3, $4);
			 }
			};

rectangle:		RECTANGLE INT INT INT INT END_STATEMENT
			{
			 if(checkRange($2, $3) == 1){
				rectangle($2, $3, $4, $5);
			 }
			};

set_color: 		SET_COLOR INT INT INT END_STATEMENT  
			{
		         if(checkColor($2, $3, $4) == 1){
		         	set_color($2, $3, $4);
			 }
		        };

end: 			END END_STATEMENT
			{
			 finish();
			 exit(0);
			};
%%
/*
*This main sets up the window for creating shapes
*Then parses the input using the lex file
*/
int main(int argc, char** argv){
	setup();
	yyparse();
	return 0;
}
int checkColor(int r, int g, int b){
	//check if colors are between 0-255
	if( r >= 0 && g >= 0 && b >= 0 && r <= 255 && g <= 255 && b <= 255){
		return 1;
	} else{
		printf("Your color entry was not between 0 and 255\n");
		return 0;
	}
}
int checkRange(int x, int y){
	//check if origin is between 0 and width, and 0 and height
	if(x >= 0 && y >= 0 && x <= WIDTH && y <= HEIGHT){
		return 1;
	} else{
		printf("Your entry was not in bounds!\n");
		return 0;
	}
}
int yyerror(char* s){
	fprintf(stderr, "%s\n", s);
}
