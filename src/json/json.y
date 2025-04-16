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
        printf("    ");
    }
}
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
     | STRING    { printf("\"%s\"", $1); free($1); }
     | NUMBER    { printf("%d", $1); }
     | TRUE      { printf("true"); }
     | FALSE     { printf("false"); }
     | JSON_NULL { printf("null"); }
     ;

object: LBRACE { 
    printf("{\n");
    indent_level++;
    print_indent();
}
    members RBRACE {
    printf("\n");
    indent_level--;
    print_indent();
    printf("}");
}
    ;

members: pair
       | members COMMA {
    printf(",\n");
    print_indent();
}
    pair
    ;

pair: STRING COLON value {
    printf("\"%s\": ", $1);
    free($1);
}
    ;

array: LBRACKET {
    printf("[\n");
    indent_level++;
    print_indent();
}
    elements RBRACKET {
    printf("\n");
    indent_level--;
    print_indent();
    printf("]");
}
    ;

elements: value
        | elements COMMA {
    printf(",\n");
    print_indent();
}
    value
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