#!/bin/bash
#profile file

required_user=`whoami`

repo_dir=./test/repo/

repo_remote=""
repo_branch="master"

log_file=./test/testProfile.log

function beforeDeploy {
	echo ''
}

function afterDeploy {
	echo ''
}
