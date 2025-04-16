%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sql.h"

void sql_error(const char* msg);
int sql_lex(void);

extern FILE* sql_in;
extern int sql_parse(void);

static int indent_level = 0;
static void print_indent(void) {
    for (int i = 0; i < indent_level; i++) {
        printf("    ");
    }
}
%}

%define api.prefix {sql_}

%union {
    char* string;
    int number;
}

%token <string> IDENTIFIER STRING
%token <number> NUMBER
%token SELECT FROM WHERE INSERT INTO VALUES UPDATE SET DELETE CREATE TABLE DROP ALTER ADD COLUMN
%token AND OR NOT NULLVAL ORDER BY GROUP HAVING JOIN LEFT RIGHT INNER OUTER ON AS
%token COUNT SUM AVG MAX MIN DISTINCT UNION ALL LIMIT OFFSET
%token STAR COMMA DOT EQUALS NOTEQUALS GT LT GTE LTE PLUS MINUS MULTIPLY DIVIDE LPAREN RPAREN SEMICOLON

%type <string> sql_statement
%type <string> select_statement
%type <string> insert_statement
%type <string> update_statement
%type <string> delete_statement
%type <string> create_statement
%type <string> select_list
%type <string> column_list
%type <string> column
%type <string> value_list
%type <string> value
%type <string> update_list
%type <string> update_assignment
%type <string> column_definitions
%type <string> column_definition
%type <string> table_reference
%type <string> search_condition
%type <string> expression

%%

sql_statement: select_statement SEMICOLON {
    printf("\nSQL Statement parsed successfully\n");
}
             | insert_statement SEMICOLON {
    printf("\nSQL Statement parsed successfully\n");
}
             | update_statement SEMICOLON {
    printf("\nSQL Statement parsed successfully\n");
}
             | delete_statement SEMICOLON {
    printf("\nSQL Statement parsed successfully\n");
}
             | create_statement SEMICOLON {
    printf("\nSQL Statement parsed successfully\n");
}
             ;

select_statement: SELECT select_list FROM table_reference {
    printf("SELECT statement:\n");
    print_indent();
    printf("FROM: %s\n", $4);
    free($4);
}
                | SELECT select_list FROM table_reference WHERE search_condition {
    printf("SELECT statement:\n");
    print_indent();
    printf("FROM: %s\n", $4);
    print_indent();
    printf("WHERE: %s\n", $6);
    free($4);
    free($6);
}
                ;

insert_statement: INSERT INTO IDENTIFIER LPAREN column_list RPAREN VALUES LPAREN value_list RPAREN {
    printf("INSERT statement:\n");
    print_indent();
    printf("INTO: %s\n", $3);
    free($3);
}
                ;

update_statement: UPDATE IDENTIFIER SET update_list WHERE search_condition {
    printf("UPDATE statement:\n");
    print_indent();
    printf("TABLE: %s\n", $2);
    free($2);
}
                ;

delete_statement: DELETE FROM IDENTIFIER WHERE search_condition {
    printf("DELETE statement:\n");
    print_indent();
    printf("FROM: %s\n", $3);
    free($3);
}
                ;

create_statement: CREATE TABLE IDENTIFIER LPAREN column_definitions RPAREN {
    printf("CREATE TABLE statement:\n");
    print_indent();
    printf("TABLE: %s\n", $3);
    free($3);
}
                ;

select_list: STAR {
    printf("SELECT *\n");
}
           | column_list {
    printf("SELECT columns\n");
}
           ;

column_list: column {
    printf("%s", $1);
    free($1);
}
           | column_list COMMA column {
    printf(", %s", $3);
    free($3);
}
           ;

column: IDENTIFIER {
    $$ = $1;
}
      | IDENTIFIER DOT IDENTIFIER {
    char* result = malloc(strlen($1) + strlen($3) + 2);
    sprintf(result, "%s.%s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
      ;

value_list: value {
    printf("%s", $1);
    free($1);
}
          | value_list COMMA value {
    printf(", %s", $3);
    free($3);
}
          ;

value: STRING {
    $$ = $1;
}
     | NUMBER {
    char* result = malloc(20);
    sprintf(result, "%d", $1);
    $$ = result;
}
     ;

update_list: update_assignment {
    printf("SET\n");
}
           | update_list COMMA update_assignment
           ;

update_assignment: IDENTIFIER EQUALS value {
    print_indent();
    printf("%s = %s\n", $1, $3);
    free($1);
    free($3);
}
                ;

column_definitions: column_definition
                 | column_definitions COMMA column_definition
                 ;

column_definition: IDENTIFIER IDENTIFIER {
    print_indent();
    printf("%s %s\n", $1, $2);
    free($1);
    free($2);
}
                ;

table_reference: IDENTIFIER {
    $$ = $1;
}
               | table_reference JOIN table_reference ON search_condition {
    char* result = malloc(strlen($1) + strlen($3) + strlen($5) + 10);
    sprintf(result, "%s JOIN %s ON %s", $1, $3, $5);
    free($1);
    free($3);
    free($5);
    $$ = result;
}
               ;

search_condition: expression {
    $$ = $1;
}
                | search_condition AND search_condition {
    char* result = malloc(strlen($1) + strlen($3) + 6);
    sprintf(result, "%s AND %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
                | search_condition OR search_condition {
    char* result = malloc(strlen($1) + strlen($3) + 5);
    sprintf(result, "%s OR %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
                | NOT search_condition {
    char* result = malloc(strlen($2) + 5);
    sprintf(result, "NOT %s", $2);
    free($2);
    $$ = result;
}
                ;

expression: IDENTIFIER {
    $$ = $1;
}
          | NUMBER {
    char* result = malloc(20);
    sprintf(result, "%d", $1);
    $$ = result;
}
          | STRING {
    $$ = $1;
}
          | IDENTIFIER EQUALS expression {
    char* result = malloc(strlen($1) + strlen($3) + 4);
    sprintf(result, "%s = %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
          | IDENTIFIER NOTEQUALS expression {
    char* result = malloc(strlen($1) + strlen($3) + 4);
    sprintf(result, "%s != %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
          | IDENTIFIER GT expression {
    char* result = malloc(strlen($1) + strlen($3) + 3);
    sprintf(result, "%s > %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
          | IDENTIFIER LT expression {
    char* result = malloc(strlen($1) + strlen($3) + 3);
    sprintf(result, "%s < %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
          | IDENTIFIER GTE expression {
    char* result = malloc(strlen($1) + strlen($3) + 4);
    sprintf(result, "%s >= %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
          | IDENTIFIER LTE expression {
    char* result = malloc(strlen($1) + strlen($3) + 4);
    sprintf(result, "%s <= %s", $1, $3);
    free($1);
    free($3);
    $$ = result;
}
          ;

%%

void sql_error(const char* msg) {
    fprintf(stderr, "SQL Parser Error: %s\n", msg);
}

int parse_sql(const char* content) {
    FILE* temp = tmpfile();
    if (!temp) {
        fprintf(stderr, "Failed to create temporary file\n");
        return 1;
    }

    fwrite(content, 1, strlen(content), temp);
    rewind(temp);
    sql_in = temp;

    int result = sql_parse();
    fclose(temp);
    return result;
} 