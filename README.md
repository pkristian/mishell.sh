# mishell.sh
> It's sexy and contains 'shell'.

Simple git deploy tool completely in bash.

## Introduction
Small tool detecting changes in git repository and deploying when needed.
Do you hate manually deploy you project to servers every time you push to master? So do I!  
This track your branch (for example `origin/master`) and if you are in *detached HEAD state*, it will just checkout to that.
  
Commnads before and after can be executed.  

Just put it in cron and forget about it.

## Features
 - Extremely simple installation
 - Works on machines in intranets (not accessible form internet)
 - Allows to run pre and post deploy commands
 - cross platform
 - Um... name sounds like a girl
 
## Requirements
 - bash
 - git
 
## Installation
Just download `mishell.sh` file to your machine.

## Usage
`mishell.sh .` is simplest usage is to deploy **origin/master** in current directory.

More complex usage with same outcome:
```
mishell.sh \
	--remote origin \
	--branch master \
	--before "" \
	--after "" \
	.
```

***Help:***  
```
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
```

## Testing
If you wish to alter code, you can run tests by `bash testCases/testAll.sh`
