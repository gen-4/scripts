#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

file=$1
if [[ ! -f "$file" ]]; then
    echo "File not found or not specified."
    exit 1
fi

while IFS= read -r line || [[ -n $line ]]; do
    color=$RED
    displayIcon='⭕'
    status=$(curl -s --max-time 20 -I $line | head -n 1 | cut -d' ' -f2)
    if [[ $status -ge 200 && $status -lt 300 ]]; then
        color=$GREEN
        displayIcon='✅'
    fi

    echo -e "App: $line | Healthcheck: $color$displayIcon$NC"

done < "$file"
