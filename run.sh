#!/bin/bash
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$script_dir"


echo "#################################"
echo "### Deployer by pkristian"
echo "### version 0.81"
echo "#################################"

profile_directory=
log_file=
#load config
. ./config.sh


profile_name=$1
profile_file=$profile_directory$profile_name'.sh'

current_user=`whoami`
echo "Profile:" $profile_name
echo "Current user:" $current_user


if [ ! -f $profile_file ]; then
	echo "ERROR: profile does not exist"
	echo "not found:" $profile_file
	exit
fi

#define variables
required_user=
repo_dir=
repo_branch=

#load profile file
echo "Loading profile file:" $profile_file
. $profile_file

echo "> required_user = "$required_user
echo "> repo_dir      = "$repo_dir
echo "> repo_branch   = "$repo_branch

#check right user

if [ $current_user != $required_user ]; then
	echo "ERROR: Mismatching user"
	echo "Required: " $required_user
	echo "Current:  " $actual_user
	exit
fi

#changing directory
cd $repo_dir
git fetch --all

#current branch
current_branch=`git branch`
#current_branch='* (detached from origin/m.com)'
current_branch=`echo "$current_branch" | grep \*`
current_branch=`echo "$current_branch" | awk '{print $NF}'`
current_branch=`echo "$current_branch" | tr -d ')'`

echo "CurrentBranch:   " "$current_branch"
if [ $current_branch == $repo_branch ]; then
	echo ""
	echo "### SKIPPING ###"
	exit
fi

echo "Required branch: " $repo_branch

##do stuff
echo "# Executing beforeDeploy:"
beforeDeploy

echo "# Executing deploy:"
git checkout -f $repo_branch

echo "# Executing afterDeploy:"
afterDeploy

cd "$script_dir"
if [ ! -f $log_file ]; then
echo $log_file
	touch $log_file
fi
now=`date +"%Y-%m-%d %H:%M:%S"`
echo $now "Deployed "$profile_name$'\r' > $log_file


echo "### DONE ###"
echo ""
exit
