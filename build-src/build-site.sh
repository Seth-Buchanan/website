#!/usr/bin/env bash

find ./site-dest/ -name "*.html" -exec rm {} \;

find ./site-src -name '*.md' -print0 |
    while IFS= read -r -d '' infile; do
       outfile="./site-dest/`cut -d'/' -f3- <<< "${infile%.*}.html"`"
       echo "placing file in $outfile"
       pandoc ${infile} -f markdown -o ${outfile} --template=./site-src/templates/easy_template.html --toc
       # pandoc --verbose -f markdown -t html5 -o ${outfile} ${infile}
    done
