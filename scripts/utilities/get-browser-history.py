#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get Browser History
# @raycast.mode silent
# @raycast.packageName |  Helper

# Optional parameters:
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "Username: Administrator", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Browser: Chrome", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "OS: Win", "optional": true }

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Provide inputs for a user, browser, and operating system. Updates the clipboard with the "get" command to retrieve the browser history file. Defaults are Administrator, Chrome, and Windows

import sys
import subprocess

def setClipboardData(data):
    inp = data.encode('utf8')
    p = subprocess.Popen(['pbcopy'], stdin=subprocess.PIPE)
    p.stdin.write(inp)
    p.stdin.close()

USERNAME_DEFAULT = 'administrator'
BROWSER_DEFAULT = 'chrome'
OS_DEFUALT = 'win'

#replaces defaults with args
user = USERNAME_DEFAULT
if sys.argv[1]:
    user = sys.argv[1].lower()
browser = BROWSER_DEFAULT
if sys.argv[2]:
    browser = sys.argv[2].lower()
os_ = OS_DEFUALT
if sys.argv[3]:
    os_ = sys.argv[3].lower()

browserError = f'{browser} is an invalid browser type. Try Chrome, Firefox, Edge, Opera, or Brave'
#Windows
if os_ in 'windows':
    if browser in 'chrome':
        hist = f'get "C:\\Users\\{user}\\AppData\\Local\\Google\\Chrome\\User Data\\Default\\History\"'
    elif browser in 'firefox':
        hist = f'get \"C:\\Users\\{user}\\AppData\\Roaming\\Mozilla\\Firefox\\Profiles\\%PROFILE%.default\\places.sqlite\"'
    elif browser in 'microsoft edge':
        hist = f'get \"C:\\Users\\{user}\\AppData\\Local\\Microsoft\\Edge\\User Data\\Default\\History\"'
    elif browser in 'brave':
        hist = f'get \"C:\\Users\\{user}\\AppData\\Local\\BraveSoftware\\Brave-Browser\\User Data\\Default\\History\"'
    elif browser in 'opera':
        hist = f'get \"C:\\Users\\{user}\\AppData\\Roaming\\Opera Software\\Opera Stable\\Default\\History\"'
    else:
        print(browserError)

#MacOS
elif os_ in 'macos':
    if browser in 'chrome':
        hist = f'get \"/Users/{user}/Library/Application Support/Google/Chrome/Default/History\"'
    elif browser in 'firefox':
        hist = f'get \"/Users/{user}/Library/Application Support/Firefox/Profiles/%PROFILE%.default/places.sqlite\"'
    elif browser in 'microsoft edge':
        hist = f'get \"/Users/{user}/Library/Application Support/Microsoft Edge/Default/History\"'
    elif browser in 'safari':
        hist = f'''get \"/Users/{user}/Library/Safari/History.db\"
get \"/Users/{user}/Library/Safari/Downloads.plist'''
    elif browser in 'brave':
        hist = f'get \"/Users/{user}/Library/Application Support/BraveSoftware/Brave-Browser/Default/History\"'
    else:
        print(browserError)

#Linux
elif os_ in 'linux/unix':
    if browser in 'chrome':
        hist = f'get \"/home/{user}/.config/google-chrome/Default/History\"'
    elif browser in 'firefox':
        hist = f'get \"/home/{user}/.mozilla/firefox/%PROFILE%.default/places.sqlite\"'
    elif browser in 'brave':
        hist = f'get \"/home/{user}/.config/BraveSoftware/Default/History\"'
    else:
        print(browserError)

else:
    print(f'{os_} is an invalid browser type. Try Windows, Mac, Or Linux')

print(hist)
clipboard.setClipboardData(hist)
