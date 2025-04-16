#ifndef COMMON_H
#define COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Error codes
typedef enum {
    PARSER_SUCCESS = 0,
    PARSER_ERROR_FILE_NOT_FOUND = -1,
    PARSER_ERROR_INVALID_FORMAT = -2,
    PARSER_ERROR_MEMORY = -3,
    PARSER_ERROR_SYNTAX = -4
} ParserError;

// Common data structures
typedef struct {
    char* key;
    char* value;
} KeyValue;

typedef struct {
    char** columns;
    int column_count;
    char** values;
    int value_count;
} TableRow;

// Function declarations
void print_error(const char* message);
char* read_file_content(const char* filename, int* error);
char* get_file_extension(const char* filename);
void free_table_row(TableRow* row);
void free_key_value(KeyValue* kv);

// Parser function declarations
int parse_json(const char* content);
int parse_xml(const char* content);
int parse_sql(const char* content);
int parse_csv(const char* content);
int parse_yaml(const char* content);

#endif // COMMON_H 