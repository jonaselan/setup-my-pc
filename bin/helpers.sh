#!/bin/bash

# function show_help()
show_help(){
	echo
	cat $SMPCPATH/help.txt
	echo
}

show_version(){
  cd $SMPCPATH && git fetch -vp 2&> /dev/null
	git tag -l --sort=v:refname | egrep v. | tail -1
	cd - 2&> /dev/null
}