#!/usr/bin/env bash

find ./site-dest/ -name "*.html" -exec rm {} \;

template=`realpath site-src/template/easy_template.html`

find ./site-src -name '*.md' -print0 |
    while IFS= read -r -d '' infile; do
	name=`cut -d'/' -f3- <<< "${infile%.*}"`
	outfile="./site-dest/${name}.html"
	pandoc ${infile} -f markdown -o ${outfile} --template=${template} --toc --metadata title="${name}"
	# pandoc --verbose -f markdown -t html5 -o ${outfile} ${infile}
    done
