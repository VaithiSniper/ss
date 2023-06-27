%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int givenCount = 0;
int acount = 0;
void fail();
extern FILE* yyin;
%}

%token A
%token B

%%
S: R B { if(acount != givenCount) { fail(); } }
R: R T | T
T: A { acount++; }
%%

void main() {
printf("Input n for the grammar `a^nb`\n");
scanf("%d ",&givenCount);
printf("Enter the string\n ");
printf("");
//yyin = fopen("test.txt", "r")
yyparse();
printf("Valid string\n");
}

void fail() {
printf("Doesn't belong to the grammar\n");
exit(0);
}

yyerror() {
printf("Invalid string\n");
exit(0);
}
