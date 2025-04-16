#ifndef PARSER_H
#define PARSER_H

// File format enumeration
typedef enum {
    FORMAT_UNKNOWN,
    FORMAT_JSON
} FileFormat;

// Main parsing function
int parse_file(const char* filename);

#endif /* PARSER_H */ 