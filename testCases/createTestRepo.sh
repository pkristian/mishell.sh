#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

rm -rf ../testRepo
mkdir ../testRepo
cd ../testRepo
git init
git remote add origin ../testRemote/.git
git pull origin demo_alpha
git checkout origin/demo_alpha
