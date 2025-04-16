#ifndef COMMON_H
#define COMMON_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
char* read_file_content(const char* filename);
char* get_file_extension(const char* filename);

// Parser function declarations
int parse_json(const char* content);
int parse_xml(const char* content);
int parse_sql(const char* content);
int parse_csv(const char* content);

#endif // COMMON_H 