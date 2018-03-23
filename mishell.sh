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


