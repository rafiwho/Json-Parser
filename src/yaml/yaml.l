%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "yaml.h"

#define YY_NO_INPUT
#define YY_NO_UNPUT

#define YY_DECL int yaml_lex(void)
%}

%option prefix="yaml_"

%%

[ \t]+        ; /* Skip whitespace */

^[\t ]*"-"[ \t]* { return DASH; }
":"             { return COLON; }
\n              { return NEWLINE; }

\"[^\"]*\"     { 
    yaml_lval.string = strdup(yytext + 1);
    yaml_lval.string[strlen(yaml_lval.string) - 1] = '\0';
    return STRING;
}

\'[^\']*\'     { 
    yaml_lval.string = strdup(yytext + 1);
    yaml_lval.string[strlen(yaml_lval.string) - 1] = '\0';
    return STRING;
}

[^:\n\t -][^:\n]*  { 
    yaml_lval.string = strdup(yytext);
    return STRING;
}

.              { printf("Invalid character: %s\n", yytext); }

%%

int yaml_wrap() { return 1; } 