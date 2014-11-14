%{
#include <string.h>
#include "include/util.h"
#include "include/absyn.h"
#include "include/errormsg.h"
#include "tiger.tab.h"

int charPos=1;

int yywrap(void)
{
 charPos=1;
 return 1;
}


void adjust(void)
{
 EM_tokPos=charPos;
 charPos+=yyleng;
}

%}

%%
[ \t]		{adjust(); continue;}
(\n|\r\n)  	{adjust(); EM_newline(); continue;}
"*"   	{adjust(); return TIMES;}
"/"   	{adjust(); return DIVIDE;}

","	{adjust(); return COMMA;}
":"	{adjust(); return COLON;}
";"	{adjust(); return SEMICOLON;}
"("	{adjust(); return LPAREN;}
")"    	{adjust(); return RPAREN;}
"["	{adjust(); return LBRACK;}
"]"	{adjust(); return RBRACK;}
"{"	{adjust(); return LBRACE;}
"}"	{adjust(); return RBRACE;}
"."	{adjust(); return DOT;}
"+"	{adjust(); return PLUS;}
"-"	{adjust(); return MINUS;}
"="	{adjust(); return EQ;}
"<>"	{adjust(); return NEQ;}
"<"	{adjust(); return LT;}
"<="	{adjust(); return LE;}
">"	{adjust(); return GT;}
">="	{adjust(); return GE;}
":="	{adjust(); return ASSIGN;}
"&"	{adjust(); return AND;}
"|"	{adjust(); return OR;}

if  	 {adjust(); return IF;}
then  	 {adjust(); return THEN;}
else  	 {adjust(); return ELSE;}
while  	 {adjust(); return WHILE;}
for  	 {adjust(); return FOR;}
to  	 {adjust(); return TO;}
do  	 {adjust(); return DO;}
let  	 {adjust(); return LET;}
in  	 {adjust(); return IN;}
end  	 {adjust(); return END;}
of  	 {adjust(); return OF;}
break  	 {adjust(); return BREAK;}
nil  	 {adjust(); return NIL;}
function {adjust(); return FUNCTION;}
var	 {adjust(); return VAR;}
type	 {adjust(); return TYPE;}

"/*"  {adjust(); EM_error(EM_tokPos,"\x1B[31m retire o commentário \x1B[0m");}

[a-zA-Z_][a-zA-Z0-9_]* 	{adjust(); yylval.sval=String(yytext); return ID;}
[0-9]+	 		{adjust(); yylval.ival=atoi(yytext); return INT;}
.	 {adjust(); EM_error(EM_tokPos,"illegal token");}
%%
