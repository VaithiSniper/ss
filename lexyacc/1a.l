%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
int valid = 0, countOfOperators = 0, countOfOperands = 0;
char operands[10][10];
char operators[10][10];
void fail();
%}

%%
"(" { valid++; }
")" { valid--; if(valid<0) fail(); }
"+"|"*" { strcpy(operators[countOfOperators++],yytext); }
[0-9]+ { strcpy(operands[countOfOperands++],yytext); }
[^+*]"("[0-9] { fail(); }
[+*]")" { fail(); }
%%

bool testValidity() {
  return ((valid == 0) && (countOfOperands - countOfOperators) == 1);
}

void displayArray(int type) {
  if(type==1)
  {
  for(int i=0;i<countOfOperands;i++)
  {
    printf("%s  ",operands[i]);
  }
  }
  else
  {
  for(int i=0;i<countOfOperators;i++)
  {
    printf("%s  ",operators[i]);
  }
  }
  printf("\n");
}

void main() {
yylex();
printf("Count of operators are : %d\n", countOfOperators);
printf("Count of operands are : %d\n", countOfOperands);
if(testValidity())
{
  printf("Expression is valid");
  printf("The operands are : \n");
  // 1 for operands, 2 for operators
  displayArray(1);
  displayArray(2);
}
else
{
  fail();
}
}

void fail() {
  printf("Expression is invalid!\n");
  exit(0);
}

int yywrap() {
return 1;
}
