#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Hash Lookup
# @raycast.mode silent
# @raycast.packageName |  OSINT

# Optional parameters:
# @raycast.icon https://virustotal.com/favicon.ico

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Looks up common OSINT resources for a copied hash
source ~/raycast-scripts/bash.lib

hash=$(sanitize "$(pbpaste)")

open -n -a "Google Chrome" --args --new-window "https://www.virustotal.com/gui/search/$hash" "https://github.com/search?q=$hash" "https://www.google.com/search?q=%22$hash%22" "https://twitter.com/search?lang=en&q=%22$hash%22&src=typed_query" "https://otx.alienvault.com/indicator/file/$hash" "https://app.any.run/submissions/#filehash:$hash" "https://www.joesandbox.com/search?q=$hash" "https://www.hybrid-analysis.com/search?query=$hash" "https://tria.ge/s?q=$hash"