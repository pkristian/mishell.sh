#!/usr/bin/env bash

set -e

#variables
remote="origin"
branch="master"
before=""
after=""
context="${@: -1}"

print_vars=0

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
		 	print_vars=1
		 	;;
		*)
			echo "unknown argument '${!i}'" 1>&2
			exit 1
	esac
done


if [ $print_vars -ne 0 ]
then
	echo "remote=$remote"
	echo "branch=$branch"
	echo "before=$before"
	echo "after=$after"
	echo "context=$context"
	echo "print_vars=$print_vars"
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
