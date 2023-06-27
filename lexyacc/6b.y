%{
 #include <stdio.h>
 #include <stdlib.h>
int id=0,key=0,ops=0;
%}

%token ID KEY OP

%%
input: ID input { id++; }
     | KEY input { key++; }
     | OP input { ops++; }
     | ID { id++; }
     | KEY { key++; }
     | OP { ops++; }
     ;
%%
extern FILE* yyin;

void main() {
yyin = fopen("input6b.c", "r");
yyparse();
printf("Keywords = %d\nIdentifiers = %d\nOperators = %d\n", key, id, ops);
}

int yyerror() {
printf("Not valid grammar\n");
return 1;
}
