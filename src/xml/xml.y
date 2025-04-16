%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void xml_error(const char* msg);
int xml_lex(void);

extern FILE* xml_in;
extern int xml_parse(void);

static int indent_level = 0;
static void print_indent(void) {
    for (int i = 0; i < indent_level; i++) {
        printf("    ");
    }
}

static void print_element_start(const char* name) {
    print_indent();
    printf("<%s", name);
}

static void print_element_end(const char* name) {
    print_indent();
    printf("</%s>\n", name);
}
%}

%define api.prefix {xml_}

%union {
    char* string;
}

%token <string> IDENTIFIER QUOTED_STRING
%token LT GT SLASH EQUALS QUESTION BANG

%type <string> element
%type <string> prolog
%type <string> attributes
%type <string> attribute
%type <string> content

%%

document: prolog element {
    printf("\nXML Document parsed successfully\n");
}
    ;

prolog: /* empty */ { $$ = strdup(""); }
      | LT QUESTION IDENTIFIER attributes QUESTION GT {
    printf("<?%s", $3);
    $$ = $3;
}
      ;

element: LT IDENTIFIER attributes GT content LT SLASH IDENTIFIER GT {
    print_element_end($8);
    free($2);
    free($8);
    $$ = $2;
}
    ;

attributes: /* empty */ { $$ = strdup(""); }
    | attributes attribute { $$ = $1; }
    ;

attribute: IDENTIFIER EQUALS QUOTED_STRING {
    printf(" %s=\"%s\"", $1, $3);
    free($1);
    free($3);
    $$ = strdup("");
}
    ;

content: /* empty */ { $$ = strdup(""); }
    | content element { $$ = $2; }
    | content IDENTIFIER {
    print_indent();
    printf("%s\n", $2);
    free($2);
    $$ = strdup("");
}
    ;

%%

void xml_error(const char* msg) {
    fprintf(stderr, "XML Parser Error: %s\n", msg);
}

int parse_xml(const char* content) {
    FILE* temp = tmpfile();
    if (!temp) {
        fprintf(stderr, "Failed to create temporary file\n");
        return 1;
    }

    fwrite(content, 1, strlen(content), temp);
    rewind(temp);
    xml_in = temp;

    int result = xml_parse();
    fclose(temp);
    return result;
} 