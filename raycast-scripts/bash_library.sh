#!/bin/bash

query_toast='Inserting query syntax into the clipboard'

RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
ENDCOLOR='\033[0m' # No Color

ip_pattern='^([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}'
domain_pattern='([a-zA-Z0-9_-]+\.)[a-zA-Z]{2,}'
hash_pattern='(^[a-fA-F0-9]{32}|[a-fA-F0-9]{40}|[a-fA-F0-9]{64})'
email_pattern='[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'
file_pattern='.*\.(js|exe|dll|py|ps1|bat|vbs|zip)'

# USAGE: ioc=$(sanitize "$1")
function sanitize() {
    local input="$1"
    sanitized=$(echo "$input" | sed -e 's/\ *$//g')
    echo "$sanitized"
}

function open_bulk_tabs() {
    local clip=$(pbpaste)
    local url="$1"
    
    open -n -a "Google Chrome" --args --new-window
    sleep 0.25

    local counter=0
    for i in ${clip//,/ }
    do
        if [[ $counter -eq 10 ]]; then
            break
        fi

        sleep 0.5

        for x in $i
        do
            local ioc=$(sanitize "$x")
            open -a "Google Chrome" "$url$ioc"
        done

        ((counter++))
    done
}

function latest_download_by_extension() {
    latest_download=$(find ~/Downloads -type f -name "*.$infile_extension" -exec ls -t {} + | head -n 1)
    echo "$latest_download"
}

function vt(){

    local url=https://www.virustotal.com/api/v3/"$type"/"$ioc"
    
    response=$(curl -s --request GET --url "$url" --header "x-apikey: $VTAPI")

    if [[ -n $response ]]; then

        local last_analysis_date=$(epoch_to_human "$(echo "$response" | jq -r '.data.attributes.last_analysis_date')")
        local id=$(fang "$(echo "$response" | jq -r '.data.id')")
        local link=$(echo "$response" | jq -r '.data.links.self')
        local type=$(echo "$response" | jq -r '.data.type' )
        local last_analysis_stats=$(echo "$response" | jq -r '.data.attributes.last_analysis_stats')
        local tags=$(echo "$response" | jq -r '.data.attributes.tags')
    
        echo "IOC: $id
IOC Type: $type 
Last Scan Date: $last_analysis_date
Link: $link
Tags: $tags
"
        
        if [ "$type" == "domain" ]; then
            local creation_date=$(epoch_to_human "$(echo "$response" | jq -r '.data.attributes.creation_date')")
            echo "Domain Creation Date: $creation_date
            "

        elif [ "$type" == "ip_address" ]; then
            local country=$(echo "$response" | jq -r '.data.attributes.country')
            local regional_internet_registry=$(echo "$response" | jq -r '.data.attributes.regional_internet_registry')

            echo "Country: $country
Internet Registry: $regional_internet_registry
"

        elif [ "$type" == "files" ]; then
            local filetype=$(echo "$response" | jq -r '.data.attributes.exiftool.FileType')
            local names=$(echo "$response" | jq -r '.data.attributes.names')
            local md5=$(echo "$response" | jq -r '.data.attributes.md5')
            local sha256=$(echo "$response" | jq -r '.data.attributes.sha256')
            local sha1=$(echo "$response" | jq -r '.data.attributes.sha1')

            echo Names: "$names"
            echo Filetype: "$filetype"
            echo Link: "$vtlink"
            echo MD5: "$md5"
            echo SHA256: "$sha256"
            echo SHA1: "$sha1"
        fi

        if [[ -n $last_analysis_stats ]]; then
            echo "Detections:"
            echo "$last_analysis_stats" | jq -r '. | to_entries[] | "\(.key): \(.value)"' | \
                awk -F ': ' '   /harmless:/ { $2="\033[1;32m"$2"\033[0m" }
                                /malicious:/ { $2="\033[1;31m"$2"\033[0m" }
                                /undetected:/ { $2="\033[1;32m"$2"\033[0m" }
                                /suspicious:/ { $2="\033[1;33m"$2"\033[0m" } { print }'
    
        else
            echo "${RED}Error${ENDCOLOR}: Missing Last Analysis Stats in the Response."
        fi
  
    else
        echo "Error: Empty response from VirusTotal API."
    fi
}

function check_overlong(){
  n=$(echo -n "$ioc" | wc -m)
  if [[ $n -gt 100 ]]; then
    echo "That string is way to long. Im not sure you want to run this script."
    exit
  fi
}

function epoch_to_human(){
    local epoch_time=$1
    if [[ $epoch_time == *.* ]]; then
    epoch_time=$(echo "$epoch_time" | awk -F'.' '{print $1}')
    fi

    length=${#epoch_time}

    if [[ $length -eq 9 ]]; then
    date_format='%a %b %d %T %Z %Y'
    elif [[ $length -eq 10 ]]; then
    date_format='%a %b %d %T %Z %Y'
    elif [[ $length -eq 13 ]]; then
    date_format='%a %b %d %T %Z %Y'
    epoch_time=$(echo "$epoch_time / 1000" | bc)
    elif [[ $length -eq 14 ]]; then
    date_format='%a %b %d %T %Z %Y'
    epoch_time=$(echo "$epoch_time / 1000000" | bc)
    else
    echo "Unknown epoch time format"
    exit 1
    fi

    formatted_date=$(gdate -d "@$epoch_time" +"$date_format")

    echo "$formatted_date"
}

function fang(){
    local input="$1"

    IFS=$'\n' read -r -a values <<< "$input"
    
    for value in "${values[@]}"; do
    
        if [[ "$input" =~ .*\[.\] ]]
        then
        # Replace '[.]' and '[:]' with '.' and ':' respectively
        processed_line=$(echo "$input" | sed -r 's/\[\.\]/\./g; s/\[\:\]/:/g')
    
        else
        # Add '[.]' and '[:]' before instances of '.' and ':' respectively
        processed_line=$(echo "$input" | sed -e 's/\.\([^ ]\)/[.]\1/g; s/\:\([^ ]\)/[:]\1/g')
    
        fi
        echo "$processed_line"

        output+="$processed_line"$'\n'
    
    done
    echo "$output" | pbcopy
}