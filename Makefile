CC = gcc
CFLAGS = -I./include -I./src/json -Wall -Wextra
LDFLAGS = -lfl

SRC_DIR = src
OBJ_DIR = obj
INCLUDE_DIR = include

# Source files
SRCS = $(SRC_DIR)/main.c $(SRC_DIR)/parser.c \
       $(SRC_DIR)/json/json_parser.c
OBJS = $(SRCS:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

# Parser files
PARSER_SRCS = $(SRC_DIR)/json/json.y
PARSER_C_SRCS = $(PARSER_SRCS:.y=.tab.c)
PARSER_H_SRCS = $(PARSER_SRCS:.y=.tab.h)
PARSER_OBJS = $(PARSER_SRCS:$(SRC_DIR)/%.y=$(OBJ_DIR)/%.tab.o)

# Lexer files
LEXER_SRCS = $(SRC_DIR)/json/json.l
LEXER_C_SRCS = $(LEXER_SRCS:.l=.yy.c)
LEXER_OBJS = $(LEXER_SRCS:$(SRC_DIR)/%.l=$(OBJ_DIR)/%.yy.o)

# Main target
all: dirs parser

dirs:
	mkdir -p $(OBJ_DIR)/json

# Build main parser
parser: $(OBJS) $(PARSER_OBJS) $(LEXER_OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# Build object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(PARSER_H_SRCS)
	$(CC) $(CFLAGS) -c $< -o $@

# Build parser object files
$(OBJ_DIR)/%.tab.o: $(SRC_DIR)/%.tab.c
	$(CC) $(CFLAGS) -c $< -o $@

# Build lexer object files
$(OBJ_DIR)/%.yy.o: $(SRC_DIR)/%.yy.c
	$(CC) $(CFLAGS) -c $< -o $@

# Generate parser C files from Bison files
$(SRC_DIR)/%.tab.c $(SRC_DIR)/%.tab.h: $(SRC_DIR)/%.y
	cd $(dir $<) && bison -d $(notdir $<)

# Generate lexer C files from Flex files
$(SRC_DIR)/%.yy.c: $(SRC_DIR)/%.l $(SRC_DIR)/%.tab.h
	cd $(dir $<) && flex -o $(notdir $@) $(notdir $<)

# Clean
clean:
	rm -rf $(OBJ_DIR) parser $(PARSER_C_SRCS) $(PARSER_H_SRCS) $(LEXER_C_SRCS)

.PHONY: all clean dirs 