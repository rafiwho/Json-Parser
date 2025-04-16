%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "json.h"

void json_error(const char* msg);
int json_lex(void);

extern FILE* json_in;
extern int json_parse(void);

static int indent_level = 0;
static void print_indent(void) {
    for (int i = 0; i < indent_level; i++) {
        printf("  ");
    }
}

FILE* yyin;
int yylex(void);
void yyerror(const char* s);
%}

%define api.prefix {json_}

%union {
    char* string;
    int number;
}

%token <string> STRING
%token <number> NUMBER
%token TRUE FALSE JSON_NULL
%token LBRACE RBRACE LBRACKET RBRACKET COLON COMMA

%%

json: value { printf("\n"); }
    ;

value: object
     | array
     | STRING    { printf("String: %s", $1); free($1); }
     | NUMBER    { printf("Number: %d", $1); }
     | TRUE      { printf("Boolean: true"); }
     | FALSE     { printf("Boolean: false"); }
     | JSON_NULL { printf("null"); }
     ;

object: LBRACE { 
    printf("Object:\n");
    indent_level++;
}
    members RBRACE {
    indent_level--;
}
    | LBRACE RBRACE { printf("Empty Object"); }
    ;

members: pair
       | members COMMA {
    printf("\n");
}
    pair
    ;

pair: STRING COLON {
    print_indent();
    printf("%s -> ", $1);
    free($1);
} value
    ;

array: LBRACKET { 
    printf("Array:\n");
    indent_level++;
}
    elements RBRACKET {
    indent_level--;
}
    | LBRACKET RBRACKET { printf("Empty Array"); }
    ;

elements: { print_indent(); printf("- "); } value
        | elements COMMA {
    printf("\n");
    print_indent();
    printf("- ");
} value
    ;

%%

void json_error(const char* msg) {
    fprintf(stderr, "JSON Parser Error: %s\n", msg);
}

int parse_json(const char* content) {
    FILE* temp = tmpfile();
    if (!temp) {
        fprintf(stderr, "Failed to create temporary file\n");
        return 1;
    }

    fwrite(content, 1, strlen(content), temp);
    rewind(temp);
    json_in = temp;

    int result = json_parse();
    fclose(temp);
    return result;
} 