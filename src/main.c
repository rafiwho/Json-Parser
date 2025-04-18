#include <stdio.h>
#include <stdlib.h>
#include "parser.h"
#include "common.h"

static void print_usage(const char* program_name) {
    fprintf(stderr, "JSON Parser - A simple JSON file parser\n\n");
    fprintf(stderr, "Usage: %s <filename>\n", program_name);
    fprintf(stderr, "\nOptions:\n");
    fprintf(stderr, "  <filename>    Path to the JSON file to parse\n");
    fprintf(stderr, "\nExample:\n");
    fprintf(stderr, "  %s data.json\n", program_name);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        print_usage(argv[0]);
        return EXIT_FAILURE;
    }

    int result = parse_file(argv[1]);
    return result == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
} 