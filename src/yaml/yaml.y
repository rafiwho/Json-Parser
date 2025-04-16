%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "yaml.h"

void yaml_error(const char* msg);
int yaml_lex(void);

extern FILE* yaml_in;
extern int yaml_parse(void);
%}

%define api.prefix {yaml_}

%union {
    char* string;
}

%token <string> IDENTIFIER STRING NUMBER
%token DASH COLON

%type <string> document
%type <string> content
%type <string> key_value
%type <string> value
%type <string> list_item

%%

document: content {
    printf("\nYAML Document parsed successfully\n");
}
        ;

content: /* empty */ { $$ = strdup(""); }
       | content key_value { $$ = $2; }
       | content list_item { $$ = $2; }
       ;

key_value: IDENTIFIER COLON value {
    printf("%s: %s\n", $1, $3);
    free($1);
    free($3);
    $$ = strdup("");
}
        ;

value: STRING {
    $$ = $1;
}
    | NUMBER {
    $$ = $1;
}
    | /* empty */ {
    $$ = strdup("");
}
    ;

list_item: DASH value {
    printf("- %s\n", $2);
    free($2);
    $$ = strdup("");
}
        ;

%%

void yaml_error(const char* msg) {
    fprintf(stderr, "YAML Parser Error: %s\n", msg);
}

int parse_yaml(const char* content) {
    FILE* temp = tmpfile();
    if (!temp) {
        fprintf(stderr, "Failed to create temporary file\n");
        return 1;
    }

    fwrite(content, 1, strlen(content), temp);
    rewind(temp);
    yaml_in = temp;

    int result = yaml_parse();
    fclose(temp);
    return result;
} 