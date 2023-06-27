#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *getDirective(char *op);

void filePrinter(char *op, char *arg1, char *arg2, char *result, FILE *output) {
  if (strcmp("=", op) == 0) {
    fprintf(output, "\nMOV R0,%s", arg1);
    fprintf(output, "\nMOV %s,R0", result);
  } else {
    fprintf(output, "\nMOV R0,%s", arg1);
    fprintf(output, "\n%s R0,%s", getDirective(op), arg2);
    fprintf(output, "\nMOV %s,R0", result);
  }
}

char *getDirective(char *op) {
  if (strcmp(op, "+") == 0) {
    return "ADD";
  } else if (strcmp(op, "-") == 0) {
    return "SUB";
  } else if (strcmp(op, "*") == 0) {
    return "MUL";
  } else if (strcmp(op, "/") == 0) {
    return "DIV";
  }
  return "dum";
}

int main(int argc, char *argv[]) {
  // vars needed
  char op[2], arg1[5], arg2[5], result[5];
  // FILE DESCRIPTORS
  FILE *input;
  FILE *output;
  // open necessary files
  input = fopen("input.txt", "r");
  output = fopen("output.txt", "w");
  // while eof not reached
  while (!feof(input)) {
    fscanf(input, "%s%s%s%s", result, arg1, op, arg2);
    // now check op wise
    if (strcmp(op, "+") == 0) {
      filePrinter("+", arg1, arg2, result, output);
    }
    if (strcmp(op, "-") == 0) {
      filePrinter("-", arg1, arg2, result, output);
    }
    if (strcmp(op, "*") == 0) {
      filePrinter("*", arg1, arg2, result, output);
    }
    if (strcmp(op, "/") == 0) {
      filePrinter("*", arg1, arg2, result, output);
    }
    if (strcmp(op, "=") == 0) {
      filePrinter("*", arg1, arg2, result, output);
    }
  }
  fclose(input);
  fclose(output);
  getchar();
  return EXIT_SUCCESS;
}
