#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Bulk Hash Lookup - Virustotal
# @raycast.mode silent
# @raycast.packageName |  OSINT

# Optional parameters:
# @raycast.icon https://virustotal.com/favicon.ico

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Uses your clipboard.                              Takes a list of hashes and opens results for each within Virustotal. Handles rows of ips, or a comma separated list.
source ~/raycast-scripts/bash_library.sh

open_bulk_tabs "https://www.virustotal.com/gui/search/"
