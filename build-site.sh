#!/usr/bin/env bash

#Cleaning up the dest directory
rm -rf ./site-dest/*

find ./site-src -mindepth 1 -type d -print0 |
    while IFS= read -r -d '' directory; do
	mkdir "./site-dest/${directory#*/*/}"
    done	

template=`realpath site-src/template/easy_template.html`

find ./site-src -name '*.md' -print0 |
    while IFS= read -r -d '' infile; do
	name="${infile%.*}"
	outfile="./site-dest/${name#*/*/}.html"
	pandoc ${infile} -f markdown -o ${outfile} --template=${template} --toc
    done

find ./site-src/images -mindepth 1 -type f -print0 |
    while IFS= read -r -d '' image; do
	image_src_dir="${image%*/*}"
	ln -srf -t  "./site-dest/${image_src_dir#*/*/}" ${image} "./site-dest/${image#*/*/}"
    done	

