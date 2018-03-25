#!/usr/bin/env bash

set -e

VERSION=v0.90

#variables
remote="origin"
branch="master"
before=""
after=""
context="${@: -1}"

printVars=0
printVersion=0
verbosity=1
help=0

for ((i = 1; i < $#; i++ )); do
	case ${!i} in
		"--remote")
			let i++
			remote=${!i}
			;;
		"--branch")
			let i++
			branch=${!i}
			;;
		"--before")
			let i++
			before=${!i}
			;;
		"--after")
			let i++
			after=${!i}
			;;
		"--print-vars")
		 	printVars=1
		 	;;
		 "--version")
		 	printVersion=1
		 	;;
		"-q"\
		|"--quiet")
			verbosity=0
			;;
		"-v"\
		|"--verbose")
			verbosity=2
			;;
		"--help")
		    help=1
			;;
		*)
			echo "unknown argument '${!i}'" 1>&2
			exit 1
	esac
done

# print version
if [ $printVersion -ne 0 ]
then
	echo "mishell.sh $VERSION"
	cat <<'TXT'
Licence: MIT
More at https://github.com/pkristian/mishell.sh
Written by Patrik Kristian
TXT
	exit 0
fi
#print vars
if [ $printVars -ne 0 ]
then
	echo "remote=$remote"
	echo "branch=$branch"
	echo "before=$before"
	echo "after=$after"
	echo "context=$context"
	echo "print_vars=$printVars"
	echo "verbosity=$verbosity"
	exit 0
fi

# print help
if [ $help -ne 0 ]
then
	cat <<'TXT'
Usage: mishell.sh [OPTION]... CONTEXT

CONTEXT is directory containing git repository
options:
  --remote string     Remote name
                        (default "origin")
  --branch string     Remote branch name
                        (default "master")
  --before string     Command executed before deploy
                        (default "")
  --after string      Command executed after deploy
                        (default "")
  --print-vars        Show variables and exit
  --version           Show version info and exit
  -q, --quiet         Do not print anything
  -v, --verbose       More verbose
  --help              Show this help

For any additional info visit:
    https://github.com/pkristian/mishell.sh
TXT
	exit 0
fi

# functions
function verbose()
{
	if [ $verbosity -ge "$1" ]
	then
		echo "$2";
	fi
}


# magic itself
################
remoteBranch="$remote/$branch"

verbose 2 "Starting..."
verbose 2 ""


#changing directory
cmd="cd $context"
	verbose 2 "$> $cmd"
	result="$($cmd)"
	verbose 2 "$result"

#check if is git installed
verbose 2 "Checking if git is installed..."
cmd="git --version"
	verbose 2 "$> $cmd"
	result="$($cmd)"
	verbose 2 "$result"

# fetching

verbose 2 "Fetching $remote/$branch ...";
cmd="git fetch $remote $branch"
	verbose 2 "$> $cmd"
	result="$($cmd 2>&1)"
	verbose 2 "$result"

verbose 2 ""

#current commit
currentCommit="$(git rev-parse HEAD)"
verbose 2 "Current commit: $currentCommit"

#target commit
targetCommit=`git show-ref $branch | awk '{print $1}'`
verbose 2 "Target commit:  $targetCommit"
verbose 2 ""

if [ "$currentCommit" == "$targetCommit" ]; then
	verbose 2 "Commits are same"
	verbose 2 "Exiting"
	verbose 2 ""
	exit 0
fi

targetCommitInfo="$(git log $targetCommit -n 1)"
verbose 1 "Target commit info:"
verbose 1 "$targetCommitInfo"


verbose 1 ""
verbose 1 "Deploying..."
#deploy stuff

#before
verbose 2 "Before deploy:"
cmd="$before"
	verbose 2 "$> $cmd"
	result="$($cmd)"
	verbose 2 "$result"
	verbose 2 ""

# checkout
verbose 2 "Checkout:"
cmd="git checkout -f $targetCommit"
	verbose 2 "$> $cmd"
	result="$($cmd 2>&1)"
	verbose 2 "$result"
	verbose 2 ""

verbose 2 "After deploy:"
cmd="$after"
	verbose 2 "$> $cmd"
	result="$($cmd)"
	verbose 2 "$result"
	verbose 2 ""

verbose 1 "Done"
verbose 1 ""

exit 0
