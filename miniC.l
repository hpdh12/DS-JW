/* definitions */
%{
#include <stdio.h>
#include <stdlib.h>
#include "miniC.tab.h"
%}

num [0-9]
alpha [A-Za-z]

%%
 /* Rules */
[ \t]	;
[ \n]	{ yylineno = yylineno + 1; }
"int" return INT;
"float" return FLOAT;
"if" return IF;
"else" return ELSE;
"for" return FOR;
"while" return WHILE;
"do" return DO;
"return" return RETURN;
^"#include ".+ ;
{num}+ {
	yylval.intnum = atoi(yytext);
	return INTNUM;
}
{num}+\.{num}+ {
	yylval.floatnum = atof(yytext);
	return FLOATNUM;
}
{alpha}+({alpha}|{num})* {
	yylval.id = yytext;
	return ID;
}
[<>]=? {
	return RELA;
}
[!=]= {
	return EQLT;
}
[\+\-] {
	return ADDI;
}
[\*\/] {
	return MULT;
}
[\+\-\*\/]\- return UNARY;
^\- return UNARY;
. return yytext[0];
%%
 /* User Code */
