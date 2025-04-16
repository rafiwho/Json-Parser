%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "xml.h"

#define YY_NO_INPUT
#define YY_NO_UNPUT

#define YY_DECL int xml_lex(void)
%}

%option prefix="xml_"

%%

[ \t\n\r]+    ; /* Skip whitespace */

"<"           { return LT; }
">"           { return GT; }
"/"           { return SLASH; }
"="           { return EQUALS; }
"?"           { return QUESTION; }
"!"           { return BANG; }

\"[^\"]*\"    { 
    xml_lval.string = strdup(xml_text + 1);
    xml_lval.string[strlen(xml_lval.string) - 1] = '\0';
    return QUOTED_STRING;
}

\'[^\']*\'    { 
    xml_lval.string = strdup(xml_text + 1);
    xml_lval.string[strlen(xml_lval.string) - 1] = '\0';
    return QUOTED_STRING;
}

[^<>\s/="']+  { 
    xml_lval.string = strdup(xml_text);
    return IDENTIFIER;
}

.             { printf("Invalid character: %s\n", xml_text); }

%%

int xml_wrap() { return 1; } 