#!/usr/bin/env bash

rm ./root/*.html

find ./site-src -name '*.md' -print0 |
    while IFS= read -r -d '' input; do
       outfile="./root/`cut -d'/' -f3- <<< "${input%.*}.html"`"
       echo "placing file in $outfile"
       pandoc --verbose -f markdown -t html5 -o ${outfile} ${input}
    done
