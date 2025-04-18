#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include "parser.h"
#include "format_parsers.h"

// Function to determine file format based on extension
static FileFormat determine_format(const char* filename) {
    if (!filename) {
        fprintf(stderr, "Error: Filename is NULL\n");
        return FORMAT_UNKNOWN;
    }

    const char* ext = strrchr(filename, '.');
    if (!ext) {
        fprintf(stderr, "Error: File has no extension\n");
        return FORMAT_UNKNOWN;
    }
    
    ext++; // Skip the dot
    
    if (strcasecmp(ext, "json") == 0) return FORMAT_JSON;
    
    fprintf(stderr, "Error: Unsupported file extension '%s'\n", ext);
    return FORMAT_UNKNOWN;
}

int parse_file(const char* filename) {
    if (!filename) {
        fprintf(stderr, "Error: Filename is NULL\n");
        return 1;
    }

    // Check if file exists and is readable
    FILE* file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Cannot open file '%s': %s\n", filename, strerror(errno));
        return 1;
    }
    fclose(file);

    FileFormat format = determine_format(filename);
    int result = 1;
    
    switch (format) {
        case FORMAT_JSON:
            result = json_parse_file(filename);
            if (result != 0) {
                fprintf(stderr, "Error: Failed to parse JSON file '%s'\n", filename);
            }
            break;
        case FORMAT_UNKNOWN:
            fprintf(stderr, "Error: Unknown file format. Only JSON files are supported.\n");
            break;
        default:
            fprintf(stderr, "Error: Unhandled file format\n");
            break;
    }
    
    return result;
} 