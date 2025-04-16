#include <stdio.h>
#include "format_parsers.h"
#include "json.tab.h"

// External declarations for flex/bison generated functions
extern FILE* json_in;
extern int json_parse(void);

int json_parse_file(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file %s\n", filename);
        return 1;
    }

    json_in = file;
    int result = json_parse();
    fclose(file);

    return result;
} 