%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "csv.h"

#define YY_NO_INPUT
#define YY_NO_UNPUT

#define YY_DECL int csv_lex(void)
%}

%option prefix="csv_"

%%

[ \t]+        ; /* Skip whitespace */

\n            { return NEWLINE; }
","           { return COMMA; }

\"[^\"]*\"    { 
    csv_lval.string = strdup(csv_text + 1);
    csv_lval.string[strlen(csv_lval.string) - 1] = '\0';
    return FIELD;
}

[^,\n\"]+     { 
    csv_lval.string = strdup(csv_text);
    return FIELD;
}

.             { printf("Invalid character: %s\n", csv_text); }

%%

int csv_wrap() { return 1; } 