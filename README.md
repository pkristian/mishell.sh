# mishell
> It's sexy and contains 'shell'.

Simple git deploy tool completely in bash

## what is it for
Do you hate manually deploy you project to servers every time you push to master? So do I!  
This track your branch (for example `origin/master`) and if you are in detached HEAD state, it will just checkout to that.  
Actions before and after can be done.  
Logging present.  
Just put it in cron and forget about it.

## usage
`./mishell <profileName>`

## testing
`./test/test`
