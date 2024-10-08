#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decode Base64
# @raycast.mode fullOutput
# @raycast.packageName |  Decoder

# Optional parameters:
# @raycast.icon 🪄

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Base64 decodes your clipboard.
source ../bash.lib

input=$(sanitize "$(pbpaste)")
echo -e "
Original String:

    ${YELLOW}$input${ENDCOLOR}

---------------------------------------------"
output=$(echo "$input" | base64 --decode)
echo -e "
Decoded String: 

    ${YELLOW}$output${ENDCOLOR}"
