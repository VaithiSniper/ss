%{
#include <stdio.h>
#include <stdlib.h>
int valid = 1;
%}

%token NUM OP
%left '+' '-'
%right '*' '/'

%%
Statement: expr '\n' { if(valid) { printf("Result=%d\n",$$); }  }
expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { if($3!=0) { $$ = $1 / $3; } else { valid = 0; printf("\nDivide by zero error\n"); } }
    | '(' expr ')' { $$ = $2; }
    | NUM { $$ = $1; }
    ;
%%

void main() {
yyparse();
if(valid==1)
  printf("Expression is valid\n");
}

yyerror() {
printf("Invalid expression\n");
exit(0);
}
