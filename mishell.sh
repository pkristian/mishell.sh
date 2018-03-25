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
  -q, --quiet         Less verbose
  -v, --verbose       More verbose
  --help              Show this help

For any additional info visit:
    https://github.com/pkristian/mishell.sh
TXT
	exit 0
fi


remoteBranch="$remote/$branch"

#changing directory
if [ ! -d "$context" ]; then
	echo "directory does not exists: '$context'" 1>&2
	exit 2
fi

cd $context

#check if is git installed
: $(git --version)

# fetching


: "$(git fetch "$remote" "$branch" 2>&1)"


#current commit
currentCommit=`git rev-parse HEAD`
: echo "Current commit: " "$currentCommit"

#target commit
targetCommit=`git show-ref $branch | awk '{print $1}'`
: echo "Target commit:" "$targetCommit"

if [ "$currentCommit" == "$targetCommit" ]; then
	exit 0
fi

#deploy
: "$(eval $before 2>&1)"
: "$(git checkout -f $targetCommit 2>&1)"
: "$(eval $after 2>&1)"


exit 0
