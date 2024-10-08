#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Fang Tool
# @raycast.mode silent
# @raycast.packageName |  Helpers

# Optional parameters:
# @raycast.icon 🪄

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Defangs or Refangs clipboard content depending on context.
source ../bash.lib

clip="$(pbpaste)"
fang "$clip"

echo "Added or removed [] to your clipboard content"
