#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Spotify - Pause/Play
# @raycast.mode silent
# @raycast.packageName |  Helpers

# Optional parameters:
# @raycast.icon /Applications/Spotify.app/Contents/Resources/icon.icns

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Toggles spotify play/pause state

tell application "Spotify" to playpause