%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "csv.h"

void csv_error(const char* msg);
int csv_lex(void);

extern FILE* csv_in;
extern int csv_parse(void);

static char** headers = NULL;
static int header_count = 0;
static int is_first_row = 1;
static char*** rows = NULL;
static int row_count = 0;
static int current_row = 0;
static char** current_fields = NULL;
static int current_field_count = 0;

static void print_row(char** fields, int count) {
    for (int i = 0; i < count; i++) {
        printf("%s", fields[i]);
        if (i < count - 1) {
            printf(", ");
        }
    }
    printf("\n");
}
%}

%define api.prefix {csv_}

%union {
    char* string;
}

%token <string> FIELD
%token COMMA NEWLINE

%%

csv: row_list {
    printf("\nCSV Data:\n");
    printf("Headers: ");
    print_row(headers, header_count);
    printf("\nRows:\n");
    for (int i = 0; i < row_count; i++) {
        print_row(rows[i], header_count);
    }
}
    ;

row_list: row
        | row_list row
        ;

row: field_list NEWLINE {
    if (!is_first_row) {
        char** new_rows = realloc(rows, (row_count + 1) * sizeof(char**));
        if (!new_rows) {
            csv_error("Memory allocation failed");
            YYABORT;
        }
        rows = new_rows;
        rows[row_count++] = current_fields;
        current_fields = NULL;
        current_field_count = 0;
    }
    is_first_row = 0;
}
    ;

field_list: FIELD {
    if (is_first_row) {
        headers = malloc(sizeof(char*));
        if (!headers) {
            csv_error("Memory allocation failed");
            YYABORT;
        }
        headers[0] = $1;
        header_count = 1;
    } else {
        current_fields = malloc(sizeof(char*));
        if (!current_fields) {
            csv_error("Memory allocation failed");
            YYABORT;
        }
        current_fields[0] = $1;
        current_field_count = 1;
    }
}
    | field_list COMMA FIELD {
    if (is_first_row) {
        char** new_headers = realloc(headers, (header_count + 1) * sizeof(char*));
        if (!new_headers) {
            csv_error("Memory allocation failed");
            YYABORT;
        }
        headers = new_headers;
        headers[header_count++] = $3;
    } else {
        char** new_fields = realloc(current_fields, (current_field_count + 1) * sizeof(char*));
        if (!new_fields) {
            csv_error("Memory allocation failed");
            YYABORT;
        }
        current_fields = new_fields;
        current_fields[current_field_count++] = $3;
    }
}
    ;

%%

void csv_error(const char* msg) {
    fprintf(stderr, "CSV Parser Error: %s\n", msg);
}

int parse_csv(const char* content) {
    FILE* temp = tmpfile();
    if (!temp) {
        fprintf(stderr, "Failed to create temporary file\n");
        return 1;
    }

    fwrite(content, 1, strlen(content), temp);
    rewind(temp);
    csv_in = temp;

    int result = csv_parse();
    
    // Clean up memory
    if (headers) {
        for (int i = 0; i < header_count; i++) {
            free(headers[i]);
        }
        free(headers);
    }
    
    if (rows) {
        for (int i = 0; i < row_count; i++) {
            for (int j = 0; j < header_count; j++) {
                free(rows[i][j]);
            }
            free(rows[i]);
        }
        free(rows);
    }
    
    if (current_fields) {
        for (int i = 0; i < current_field_count; i++) {
            free(current_fields[i]);
        }
        free(current_fields);
    }
    
    fclose(temp);
    return result;
} 