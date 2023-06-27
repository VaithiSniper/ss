%{
#define SHIFT 1
#define REDUCE 2
#define SUCCESS 3
#define ERROR 4
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern FILE* yyin;
char input[30], stack[30];
int stackCount, inputCounter;
void displayRow(int, char*);
%}

%token ID star plus openpar closepar

%%

E : E P T { 
            displayRow(REDUCE, "E -> E+T");
            stackCount-= 3;
            stack[stackCount++] = 'E';
            stack[stackCount] = '\0';
          }
      | T { 
            displayRow(REDUCE, "E -> T");
            stackCount-= 1;
            stack[stackCount++] = 'E';
            stack[stackCount] = '\0';
          }

T : T S F {
            displayRow(REDUCE, "T -> T*F");
            stackCount-= 3;
            stack[stackCount++] = 'T';
            stack[stackCount] = '\0';
}
      | F { 
            displayRow(REDUCE, "T -> F");
            stackCount -= 1;
            stack[stackCount++] = 'T';
            stack[stackCount] = '\0';
  }

F: O E C {
            displayRow(REDUCE, "F -> (E)");
            stackCount -= 3;
            stack[stackCount++] = 'F';
            stack[stackCount] = '\0';
         }
    | ID {
            displayRow(SHIFT, "id");
            input[inputCounter++]=' ';
            input[inputCounter++]=' ';
            stack[stackCount++]='i';
            stack[stackCount++]='d';
            stack[stackCount]='\0';
            
            displayRow(REDUCE, "F -> id");
            stackCount -= 2;
            stack[stackCount++] = 'F';
            stack[stackCount] = '\0';
          }

O : openpar  {
            displayRow(SHIFT, "(");
            input[inputCounter++]=' ';
            stack[stackCount++]='(';
            stack[stackCount]='\0';
          }

C : closepar  {
            displayRow(SHIFT, ")");
            input[inputCounter++]=' ';
            stack[stackCount++]=')';
            stack[stackCount]='\0';
          }

P : plus  {
            displayRow(SHIFT, "+");
            input[inputCounter++]=' ';
            stack[stackCount++]='+';
            stack[stackCount]='\0';
          }

S : star  {
            displayRow(SHIFT, "*");
            input[inputCounter++]=' ';
            stack[stackCount++]='*';
            stack[stackCount]='\0';
          }
%%

void displayRow(int actionType, char* arg) {
switch(actionType) {
case SHIFT: 
  printf("$%s\t%s$\t%s %s\n", stack, input, "SHIFT", arg);
  break;
case REDUCE: 
  printf("$%s\t%s$\t%s\n", stack, input, "REDUCE", arg);
  break;
case SUCCESS: 
  printf("$%s\t%s$\t%s\n", stack, input, "SUCCESS");
  break;
case ERROR: 
  printf("$%s\t%s$\t%s\n", stack, input, "ERROR");
  break;
}
}

void main() {
// some input
printf("Enter the input\n");
scanf("%s ", &input);
// dump it to a file
FILE* temp = fopen("lab4.txt", "w");
fprintf(temp, "%s", input);
fclose(temp);
// access same file and use as yyin
yyin = fopen("lab4.txt", "r");
// call yyparse to run thru parser, display column headings
printf("Stack\tInput\tAction\n");
yyparse();
// display if it errored or was successfully parsed
if(stackCount == 1 && stack[stackCount-1] == 'E' && input[inputCounter]=='\0')
{
  // successfully parsed
displayRow(SUCCESS, "");
}
}

int yyerror() {
displayRow(ERROR, "");
exit(0);
}
