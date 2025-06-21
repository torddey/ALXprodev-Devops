#!/bin/bash

# This script parses pikachu.json to extract, format, and display Pokémon data.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
INPUT_FILE="$SCRIPT_DIR/pikachu.json"

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: $INPUT_FILE not found."
    exit 1
fi

# Pipeline using jq, awk, and sed:
# 1. jq: Extracts raw data (name, type, weight, height).
# 2. awk: Performs calculations (unit conversions for weight and height).
# 3. sed: Formats the final output string, including capitalization.
jq -r '[.name, .types[0].type.name, .weight, .height] | @tsv' "$INPUT_FILE" | \
awk -F'\t' '{printf "%s\t%s\t%s\t%s", $1, $2, $3/10, $4/10}' | \
sed -E 's/^([a-z])([^\t]*)\t([a-z])([^\t]*)\t([^\t]*)\t([^\t]*)/\U\1\E\2 is of type \U\3\E\4, weighs \5kg, and is \6m tall./' 