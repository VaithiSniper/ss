%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%%
a { return A; }
b { return B; }
\n { return 0; }
. { return yytext[0]; }
