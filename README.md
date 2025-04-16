# Multi-Format Parser

A flexible and extensible parser that supports multiple data formats including JSON, XML, SQL, CSV, and YAML.

## Features

- **Multi-Format Support**: Parse files in various formats:
  - JSON
  - XML
  - SQL
  - CSV
  - YAML

- **Flexible Architecture**: Easily extensible to support additional formats
- **Standardized Interface**: Consistent parsing API across all formats
- **Error Handling**: Robust error reporting for each parser

## Requirements

- GCC compiler
- Flex (Fast Lexical Analyzer)
- Bison (Parser Generator)
- Make build system

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/Multi-Format-Parser.git
   cd Multi-Format-Parser
   ```

2. Build the project:
   ```bash
   make clean    # Clean previous builds (optional)
   make         # Build the project
   ```

## Usage

### Basic Usage
Run the parser with a file of any supported format:
```bash
./parser <filename>
```

### Running with Sample Files
The project includes sample files for testing in the `test_inputs` directory:

```bash
# Parse YAML file
./parser test_inputs/sample.yaml

# Parse SQL file
./parser test_inputs/sample.sql

# Parse JSON file
./parser test_inputs/sample.json

# Parse XML file
./parser test_inputs/sample.xml

# Parse CSV file
./parser test_inputs/sample.csv
```

### Error Handling
- If no filename is provided, usage instructions will be displayed
- If the file format is not supported, an error message will be shown
- If the file cannot be opened, an error message will be shown

### Supported File Extensions
- `.json` - JSON files
- `.xml` - XML files
- `.sql` - SQL files
- `.csv` - CSV files
- `.yaml` or `.yml` - YAML files

## Project Structure

```
Multi-Format-Parser/
├── include/           # Header files
├── src/              # Source files
│   ├── json/         # JSON parser
│   ├── xml/          # XML parser
│   ├── sql/          # SQL parser
│   ├── csv/          # CSV parser
│   └── yaml/         # YAML parser
├── test_inputs/      # Sample input files
├── obj/              # Object files (generated)
├── Makefile          # Build configuration
└── README.md         # This file
```

## Building

### Full Build
To build the project:
```bash
make
```

### Clean Build
To clean and rebuild:
```bash
make clean   # Remove all generated files
make        # Rebuild the project
```

## Extending the Parser

To add support for a new format:

1. Create a new directory in `src/` for your parser
2. Implement the lexer (`.l`) and parser (`.y`) files
3. Create a header file in `include/`
4. Update `parser.h` to include the new format
5. Update `parser.c` to handle the new format
6. Update the Makefile with build rules for the new parser

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributors

- Your Name - Initial work

## Acknowledgments

- Flex and Bison for parser generation tools
- The open-source community for inspiration and resources 