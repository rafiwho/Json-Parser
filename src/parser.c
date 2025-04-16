#include <stdio.h>
#include <string.h>
#include "parser.h"
#include "format_parsers.h"

// Function to determine file format based on extension
static FileFormat determine_format(const char* filename) {
    const char* ext = strrchr(filename, '.');
    if (!ext) return FORMAT_UNKNOWN;
    
    ext++; // Skip the dot
    
    if (strcasecmp(ext, "json") == 0) return FORMAT_JSON;
    
    return FORMAT_UNKNOWN;
}

int parse_file(const char* filename) {
    FileFormat format = determine_format(filename);
    
    switch (format) {
        case FORMAT_JSON:
            return json_parse_file(filename);
        case FORMAT_UNKNOWN:
            fprintf(stderr, "Error: Unknown file format. Only JSON files are supported.\n");
            return 1;
    }
    
    return 1; // Should never reach here
} 