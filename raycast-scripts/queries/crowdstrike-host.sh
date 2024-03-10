#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Crowdstrike - Host Events
# @raycast.mode silent
# @raycast.packageName |  Query

# Optional parameters:
# @raycast.icon https://www.crowdstrike.com/etc.clientlibs/crowdstrike/clientlibs/crowdstrike-common/resources/favicon.ico
# @raycast.argument1 { "type": "text", "placeholder": "Hostname", "optional": true }

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Generates a query using parameters. This query identifies events on a host
source ~/raycast-scripts/bash_library.sh

host=$(sanitize "$1")

echo 'ComputerName="'"$host"'"' | pbcopy

echo "$query_toast"