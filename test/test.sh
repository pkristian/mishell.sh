#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"

echo "### Testing deployer ###"

#create repo
echo "Create repo..."
test_repo_dir=./repo/

rm -rf $test_repo_dir
mkdir $test_repo_dir

cd $test_repo_dir

git init -q

echo 'First' > first.txt
git add . &> /dev/null
git commit -m 'first commit' -q

echo 'second' > second.txt
git add . &> /dev/null
git commit -m 'second commit' -q

echo 'third' > third.txt
git add . &> /dev/null
git commit -m 'third commit' -q

git rev-parse --abbrev-ref HEAD
git checkout HEAD~1 &> /dev/null
# /repo created

git log --oneline --decorate --all

echo "### Executing deployer:"
echo "------------------------"

cd "$script_dir"
sh ../run.sh testProfile

sh ../run.sh testProfile

exit
