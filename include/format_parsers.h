#ifndef FORMAT_PARSERS_H
#define FORMAT_PARSERS_H

// Function declarations for format-specific parsers
int json_parse_file(const char* filename);
int xml_parse_file(const char* filename);
int sql_parse_file(const char* filename);
int csv_parse_file(const char* filename);
int yaml_parse_file(const char* filename);

#endif // FORMAT_PARSERS_H 