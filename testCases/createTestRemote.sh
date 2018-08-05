#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

echo -e "\e[33m";
if [ ! -d "../testRemote" ]; then
	echo "Creating testRemote..."

	mkdir "../testRemote"
	cd "../testRemote"

	git init
	git remote add origin https://github.com/pkristian/mishell.sh.git

	git fetch origin demo_alpha
	git checkout -b demo_alpha origin/demo_alpha

	git fetch origin demo_beta
	git checkout -b demo_beta origin/demo_beta

	git fetch origin demo_delta
	git checkout -b demo_delta origin/demo_delta

	git remote remove origin

else
	echo "Existing testRemote."
fi
echo -e "\e[0m";
