#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DNSChecker
# @raycast.mode silent
# @raycast.packageName |  Quicklink

# Optional parameters:
# @raycast.icon https://dnschecker.org/themes/common/images/general/favicon-32.png
# @raycast.argument1 { "type": "text", "placeholder": "Domain", "optional": true }

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Takes a Domain parameter. Opens and searches within DNSChecker. 

on run argv
    if item 1 of argv is not "" then
    	set domain to item 1 of argv
			tell application "Google Chrome"
				open location "https://dnschecker.org/all-dns-records-of-domain.php?query=" & domain & "&rtype=ALL&dns=google"
				delay 1
				execute front window's active tab javascript "document.querySelector(' #ddf_submit ').click()"
			end tell
    else
        set domain to the clipboard
        	tell application "Google Chrome"
				open location "https://dnschecker.org/all-dns-records-of-domain.php?query=" & domain & "&rtype=ALL&dns=google"
				delay 1
				execute front window's active tab javascript "document.querySelector(' #ddf_submit ').click()"
		end tell
    end if
end run