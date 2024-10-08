#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Defender - Host events
# @raycast.mode silent
# @raycast.packageName |  Query

# Optional parameters:
# @raycast.icon https://www.microsoft.com/favicon.ico?v2
# @raycast.argument1 { "type": "text", "placeholder": "Substring", "optional": true }

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Generates a query using parameters. The query identifies events on a host
source ~/raycast-scripts/bash.lib

host=$(sanitize "$1")

echo 'DeviceEvents | where DeviceName contains '\""$host"\" | pbcopy

echo "$query_toast"
