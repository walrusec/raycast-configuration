#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Spotify - Previous Track
# @raycast.mode silent
# @raycast.packageName |  Helpers

# Optional parameters:
# @raycast.icon /Applications/Spotify.app/Contents/Resources/icon.icns

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Skips back

tell application "Spotify" to previous track