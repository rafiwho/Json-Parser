%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "json.h"

#define YY_NO_INPUT
#define YY_NO_UNPUT

#define YY_DECL int json_lex(void)
%}

%option prefix="json_"

%%

[ \t\n\r]+    ; /* Skip whitespace */

\"[^\"]*\"    { 
    json_lval.string = strdup(json_text + 1);
    json_lval.string[strlen(json_lval.string) - 1] = '\0';
    return STRING;
}

[0-9]+        { 
    json_lval.number = atoi(json_text);
    return NUMBER;
}

"true"        { return TRUE; }
"false"       { return FALSE; }
"null"        { return JSON_NULL; }

"{"           { return LBRACE; }
"}"           { return RBRACE; }
"["           { return LBRACKET; }
"]"           { return RBRACKET; }
":"           { return COLON; }
","           { return COMMA; }

.             { printf("Invalid character: %s\n", json_text); }

%%

int json_wrap() { return 1; }

void json_error(const char* msg) {
    fprintf(stderr, "JSON Lexer Error: %s\n", msg);
} 