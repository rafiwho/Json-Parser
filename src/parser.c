#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "parser.h"

// JSON parsing functions
static void parse_json_object(const char* content, int* pos, int indent);
static void parse_json_array(const char* content, int* pos, int indent);
static void parse_json_value(const char* content, int* pos, int indent);
static void print_indent(int indent);

// Function declarations for each parser
int parse_json(const char* content) {
    printf("\n=== JSON Parser Output ===\n");
    printf("Format: JSON\n");
    printf("Parsed Structure:\n");
    printf("-----------------\n");
    
    int pos = 0;
    // Skip whitespace
    while (content[pos] && isspace(content[pos])) pos++;
    
    // Start parsing from the first character
    parse_json_value(content, &pos, 0);
    
    printf("-----------------\n");
    return 0;
}

static void print_indent(int indent) {
    for (int i = 0; i < indent; i++) {
        printf("  ");
    }
}

static void parse_json_object(const char* content, int* pos, int indent) {
    // Skip opening brace
    (*pos)++;
    
    // Skip whitespace
    while (content[*pos] && isspace(content[*pos])) (*pos)++;
    
    // Check if empty object
    if (content[*pos] == '}') {
        printf("{}");
        (*pos)++;
        return;
    }
    
    printf("{\n");
    
    // Parse key-value pairs
    while (content[*pos]) {
        // Skip whitespace
        while (content[*pos] && isspace(content[*pos])) (*pos)++;
        
        // Check for closing brace
        if (content[*pos] == '}') {
            (*pos)++;
            print_indent(indent);
            printf("}");
            return;
        }
        
        // Parse key
        if (content[*pos] == '"') {
            (*pos)++;
            print_indent(indent + 1);
            printf("Key: ");
            while (content[*pos] && content[*pos] != '"') {
                printf("%c", content[*pos]);
                (*pos)++;
            }
            (*pos)++; // Skip closing quote
            
            // Skip whitespace
            while (content[*pos] && isspace(content[*pos])) (*pos)++;
            
            // Check for colon
            if (content[*pos] == ':') {
                (*pos)++;
                printf(" -> ");
                
                // Skip whitespace
                while (content[*pos] && isspace(content[*pos])) (*pos)++;
                
                // Parse value
                parse_json_value(content, pos, indent + 1);
                
                // Skip whitespace
                while (content[*pos] && isspace(content[*pos])) (*pos)++;
                
                // Check for comma or closing brace
                if (content[*pos] == ',') {
                    printf(",\n");
                    (*pos)++;
                } else if (content[*pos] == '}') {
                    printf("\n");
                    print_indent(indent);
                    printf("}");
                    (*pos)++;
                    return;
                }
            }
        } else {
            // Invalid JSON
            printf("Error: Expected key in object\n");
            return;
        }
    }
}

static void parse_json_array(const char* content, int* pos, int indent) {
    // Skip opening bracket
    (*pos)++;
    
    // Skip whitespace
    while (content[*pos] && isspace(content[*pos])) (*pos)++;
    
    // Check if empty array
    if (content[*pos] == ']') {
        printf("[]");
        (*pos)++;
        return;
    }
    
    printf("[\n");
    
    // Parse array elements
    while (content[*pos]) {
        // Skip whitespace
        while (content[*pos] && isspace(content[*pos])) (*pos)++;
        
        // Check for closing bracket
        if (content[*pos] == ']') {
            (*pos)++;
            print_indent(indent);
            printf("]");
            return;
        }
        
        // Parse value
        print_indent(indent + 1);
        printf("Element: ");
        parse_json_value(content, pos, indent + 1);
        
        // Skip whitespace
        while (content[*pos] && isspace(content[*pos])) (*pos)++;
        
        // Check for comma or closing bracket
        if (content[*pos] == ',') {
            printf(",\n");
            (*pos)++;
        } else if (content[*pos] == ']') {
            printf("\n");
            print_indent(indent);
            printf("]");
            (*pos)++;
            return;
        }
    }
}

static void parse_json_value(const char* content, int* pos, int indent) {
    // Skip whitespace
    while (content[*pos] && isspace(content[*pos])) (*pos)++;
    
    // Parse based on value type
    if (content[*pos] == '{') {
        parse_json_object(content, pos, indent);
    } else if (content[*pos] == '[') {
        parse_json_array(content, pos, indent);
    } else if (content[*pos] == '"') {
        // String
        (*pos)++;
        printf("String: \"");
        while (content[*pos] && content[*pos] != '"') {
            printf("%c", content[*pos]);
            (*pos)++;
        }
        printf("\"");
        (*pos)++; // Skip closing quote
    } else if (isdigit(content[*pos]) || content[*pos] == '-') {
        // Number
        printf("Number: ");
        while (content[*pos] && (isdigit(content[*pos]) || content[*pos] == '.' || content[*pos] == '-')) {
            printf("%c", content[*pos]);
            (*pos)++;
        }
    } else if (content[*pos] == 't' && strncmp(content + *pos, "true", 4) == 0) {
        // Boolean true
        printf("Boolean: true");
        *pos += 4;
    } else if (content[*pos] == 'f' && strncmp(content + *pos, "false", 5) == 0) {
        // Boolean false
        printf("Boolean: false");
        *pos += 5;
    } else if (content[*pos] == 'n' && strncmp(content + *pos, "null", 4) == 0) {
        // Null
        printf("Null");
        *pos += 4;
    }
}

int parse_xml(const char* content) {
    printf("\n=== XML Parser Output ===\n");
    printf("Format: XML\n");
    printf("Content Structure:\n");
    printf("-----------------\n");
    printf("%s\n", content);
    printf("-----------------\n");
    return 0;
}

int parse_sql(const char* content) {
    printf("\n=== SQL Parser Output ===\n");
    printf("Format: SQL\n");
    printf("Content Structure:\n");
    printf("-----------------\n");
    printf("%s\n", content);
    printf("-----------------\n");
    return 0;
}

int parse_csv(const char* content) {
    printf("\n=== CSV Parser Output ===\n");
    printf("Format: CSV\n");
    printf("Content Structure:\n");
    printf("-----------------\n");
    printf("%s\n", content);
    printf("-----------------\n");
    return 0;
}

int parse_yaml(const char* content) {
    printf("\n=== YAML Parser Output ===\n");
    printf("Format: YAML\n");
    printf("Content Structure:\n");
    printf("-----------------\n");
    printf("%s\n", content);
    printf("-----------------\n");
    return 0;
}

static FileFormat get_file_format(const char* filename) {
    const char* ext = strrchr(filename, '.');
    if (!ext) {
        return FORMAT_UNKNOWN;
    }
    
    ext++; // Skip the dot
    
    if (strcasecmp(ext, "json") == 0) {
        return FORMAT_JSON;
    } else if (strcasecmp(ext, "xml") == 0) {
        return FORMAT_XML;
    } else if (strcasecmp(ext, "sql") == 0) {
        return FORMAT_SQL;
    } else if (strcasecmp(ext, "csv") == 0) {
        return FORMAT_CSV;
    } else if (strcasecmp(ext, "yaml") == 0 || strcasecmp(ext, "yml") == 0) {
        return FORMAT_YAML;
    }
    
    return FORMAT_UNKNOWN;
}

int parse_file(const char* filename) {
    FILE* file = fopen(filename, "r");
    if (!file) {
        fprintf(stderr, "Error: Could not open file %s\n", filename);
        return 1;
    }
    
    // Get file size
    fseek(file, 0, SEEK_END);
    long size = ftell(file);
    rewind(file);
    
    // Read file content
    char* content = malloc(size + 1);
    if (!content) {
        fprintf(stderr, "Error: Memory allocation failed\n");
        fclose(file);
        return 1;
    }
    
    size_t read_size = fread(content, 1, size, file);
    content[read_size] = '\0';
    fclose(file);
    
    // Determine file format and parse
    FileFormat format = get_file_format(filename);
    int result = 1;
    
    switch (format) {
        case FORMAT_JSON:
            result = parse_json(content);
            break;
        case FORMAT_XML:
            result = parse_xml(content);
            break;
        case FORMAT_SQL:
            result = parse_sql(content);
            break;
        case FORMAT_CSV:
            result = parse_csv(content);
            break;
        case FORMAT_YAML:
            result = parse_yaml(content);
            break;
        default:
            fprintf(stderr, "Error: Unknown file format\n");
            break;
    }
    
    free(content);
    return result;
} 