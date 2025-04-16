#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../include/common.h"

void print_error(const char* message) {
    fprintf(stderr, "Error: %s\n", message);
}

char* read_file_content(const char* filename, int* error) {
    if (!filename || !error) {
        if (error) *error = PARSER_ERROR_FILE_NOT_FOUND;
        return NULL;
    }
    
    FILE* file = fopen(filename, "r");
    if (!file) {
        *error = PARSER_ERROR_FILE_NOT_FOUND;
        return NULL;
    }
    
    // Get file size
    if (fseek(file, 0, SEEK_END) != 0) {
        fclose(file);
        *error = PARSER_ERROR_FILE_NOT_FOUND;
        return NULL;
    }
    
    long size = ftell(file);
    if (size < 0) {
        fclose(file);
        *error = PARSER_ERROR_FILE_NOT_FOUND;
        return NULL;
    }
    
    rewind(file);
    
    // Allocate memory for content
    char* content = malloc(size + 1);
    if (!content) {
        fclose(file);
        *error = PARSER_ERROR_MEMORY;
        return NULL;
    }
    
    // Read file content
    size_t read_size = fread(content, 1, size, file);
    if (read_size != (size_t)size) {
        free(content);
        fclose(file);
        *error = PARSER_ERROR_FILE_NOT_FOUND;
        return NULL;
    }
    
    content[read_size] = '\0';
    fclose(file);
    *error = PARSER_SUCCESS;
    return content;
}

char* get_file_extension(const char* filename) {
    if (!filename) {
        return NULL;
    }
    
    const char* ext = strrchr(filename, '.');
    if (!ext) {
        return NULL;
    }
    
    return strdup(ext);
}

void free_table_row(TableRow* row) {
    if (!row) return;
    
    if (row->columns) {
        for (int i = 0; i < row->column_count; i++) {
            free(row->columns[i]);
        }
        free(row->columns);
    }
    
    if (row->values) {
        for (int i = 0; i < row->value_count; i++) {
            free(row->values[i]);
        }
        free(row->values);
    }
    
    free(row);
}

void free_key_value(KeyValue* kv) {
    if (!kv) return;
    
    free(kv->key);
    free(kv->value);
    free(kv);
} 