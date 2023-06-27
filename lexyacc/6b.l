%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
int|char|bool|float|void|for|if|else|while|do|for|return|main { printf("keyword is : %s",yytext); return KEY; } 
[+|-|*|/|=|<|>] { printf("operator is : %s",yytext); return OP; } 
[a-zA-Z][a-zA-Z0-9]* { printf("identifier is : %s",yytext); return ID; } 
.;
%%

int yywrap() {
return 1;
}
