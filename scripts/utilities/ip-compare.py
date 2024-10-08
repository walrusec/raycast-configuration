#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title IP List Comparer
# @raycast.mode silent
# @raycast.packageName |  Run without arguments for guidance

# Optional parameters:
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "File 1", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "File 2", "optional": false }

# Documentation:
# @raycast.author https://github.com/walrusec/walrusec
# @raycast.description Compares two lists of IPs and returns instances where the IP exists in both

import os
import sys
import subprocess
from datetime import datetime

# Function to read IPs from a file and return a set of IPs
def read_ips_from_file(file_path):
    with open(file_path, 'r') as file:
        ips = set(file.read().splitlines())
    return ips

# Paths to your text files
file1_path = sys.argv[1]
file2_path = sys.argv[2]

# Read IPs from both files
ips_file1 = read_ips_from_file(file1_path)
ips_file2 = read_ips_from_file(file2_path)

# Find the common IPs (matches)
common_ips = ips_file1.intersection(ips_file2)

current_datetime = str(datetime.now())

# Open a file in write mode
filepath = f"~/Desktop/ip_matches_{current_datetime}.txt"
with open(filepath, "w") as file:
    # Write header
    file.write("Common IPs:\n")
    
    # Write each IP to the file
    for ip in common_ips:
        file.write(ip + "\n")

subprocess.call(["open", os.path.expanduser(filepath)])

