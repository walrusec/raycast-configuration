#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open clipboard content in VSCode
# @raycast.mode silent
# @raycast.packageName |  Helpers

# Optional parameters:
# @raycast.icon /Applications/Visual Studio Code.app/Contents/Resources/Code.icns

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description opens VSCode with clipboard content

timestamp() {
  date "+%Y-%m-%d-%H:%M:%S"
}
DIR="/tmp"
FILENAME="$DIR/scratch-$(timestamp)" 
pbpaste >> "$FILENAME"

echo "Pasted clipboard content in $FILENAME"

code --file-uri "$FILENAME"