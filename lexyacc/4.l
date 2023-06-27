%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%%
"id" { return ID; }
"+" { return plus; }
"*" { return star; }
"(" { return openpar; }
")" { return closepar; }
. { return yytext[0]; }
\n { return 0; }
%%
