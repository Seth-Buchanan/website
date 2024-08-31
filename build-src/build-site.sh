#!/usr/bin/env bash

#Cleaning up the dest directory
rm -rf ./site-dest/*
mkdir ./site-dest/images

template=`realpath site-src/template/easy_template.html`

find ./site-src -name '*.md' -print0 |
    while IFS= read -r -d '' infile; do
	name=`cut -d'/' -f3- <<< "${infile%.*}"`
	outfile="./site-dest/${name}.html"
	pandoc ${infile} -f markdown -o ${outfile} --template=${template} --toc --metadata title="${name}"
    done

find ./site-src/images -mindepth 1 -type d -print0 |
    while IFS= read -r -d '' directory; do
	mkdir "./site-dest/${directory#*/*/}"
    done	

find ./site-src/images -mindepth 1 -type f -print0 |
    while IFS= read -r -d '' image; do
	ln -s image "./site-dest/${image#*/*/}"
    done	
