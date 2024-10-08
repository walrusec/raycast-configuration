#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Or statement Generator
# @raycast.mode silent
# @raycast.packageName |  Queries

# Optional parameters:
# @raycast.icon 🐗
#
# Documentation:
# @raycast.description Parses out a list of items to make a big OR statement
# @raycast.author https://github.com/walrusec/walrusec
source ../bash.lib

input_string=$(sanitize "$(pbpaste)")

input_string=$(echo "$input_string" | tr ',\n|' ' ' | tr -s ' ')
output_string=$(echo "$input_string" | awk -v OR=" OR " '{
    for (i = 1; i <= NF; i++) {
        if ($i ~ /^".*"$/) {
            printf("%s", $i);
        } else {
            printf("\"%s\"", $i);
        }
        if (i < NF) {
            printf(OR);
        }
    }
    print "";
}')

echo "$output_string" | pbcopy
