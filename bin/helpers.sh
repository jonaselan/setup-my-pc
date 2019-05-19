#!/bin/bash

command_exists() {
	# redirect the output of your program to "nothing"
	type "$1" >/dev/null 2>&1
}

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

confirm_install(){
	echo "Do you want to install $1? (Y/n)"
	read choice
	if [[ $choice == "Y" || $choice == "y" || $choice == "yes" ]];  then
		install_$1
	else
		echo "...Not installed!"
	fi
}

first_letter_lower(){
	lower=$(echo $1 | tr '[:upper:]' '[:lower:]' | cut -b1)
	echo $lower
}