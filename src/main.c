#include <stdio.h>
#include "parser.h"
#include "common.h"

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    return parse_file(argv[1]);
} 