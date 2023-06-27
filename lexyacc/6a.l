%{
#include <stdio.h>
#include <stdlib.h>
int noOfCommentLines = 0;
%}
%s COMMENT
%%
"/*" {BEGIN(COMMENT);}
<COMMENT>"*/" {BEGIN(0);noOfCommentLines++;}
<COMMENT>. {;}
"//".* {noOfCommentLines++;}
.|\n {fprintf(yyout, "%s", yytext);}
%%

void main() {
yyin = fopen("input.c", "r");
yyout = fopen("output.c", "w");
yylex();
printf("The no. of comment lines are : %d\n", noOfCommentLines);
}

int yywrap() {
return 1;
}
