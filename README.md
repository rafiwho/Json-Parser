# JSON Parser

A flexible and extensible JSON parser that provides human-readable output of JSON data structures.

## Features

- **JSON Parsing**: Parse and validate JSON files
- **Human-Readable Output**: Produces formatted output with:
  - Type information (String, Number, Boolean, etc.)
  - Clear structure visualization
  - Proper indentation for nested objects/arrays
  - Array element bullet points
- **Error Handling**: Robust error reporting for invalid JSON

## Requirements

- GCC compiler
- Flex (Fast Lexical Analyzer)
- Bison (Parser Generator)
- Make build system

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/JSON-Parser.git
   cd JSON-Parser
   ```

2. Build the project:
   ```bash
   make clean    # Clean previous builds (optional)
   make         # Build the project
   ```

## Usage

### Basic Usage
Run the parser with a JSON file:
```bash
./parser <filename.json>
```

### Running with Sample Files
The project includes a sample JSON file for testing in the `test_inputs` directory:

```bash
# Parse JSON file
./parser test_inputs/sample.json
```

### Example Output
For a JSON file like:
```json
{
    "name": "John Doe",
    "age": 30,
    "is_student": false,
    "address": {
        "street": "123 Main St",
        "city": "New York",
        "zip": 10001
    }
}
```

The parser will produce:
```
Object:
  name -> String: John Doe
  age -> Number: 30
  is_student -> Boolean: false
  address -> Object:
    street -> String: 123 Main St
    city -> String: New York
    zip -> Number: 10001
```

### Error Handling
- If no filename is provided, usage instructions will be displayed
- If the file is not a JSON file, an error message will be shown
- If the file cannot be opened, an error message will be shown
- If the JSON is invalid, a parsing error will be shown

## Project Structure

```
JSON-Parser/
├── include/           # Header files
├── src/              # Source files
│   ├── json/         # JSON parser implementation
│   │   ├── json.l    # Lexer definition
│   │   ├── json.y    # Parser definition
│   │   └── json_parser.c  # Parser implementation
│   ├── parser.c      # Main parser logic
│   └── main.c        # Entry point
├── test_inputs/      # Sample JSON files
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

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributors

- Your Name - Initial work

## Acknowledgments

- Flex and Bison for parser generation tools
- The open-source community for inspiration and resources 