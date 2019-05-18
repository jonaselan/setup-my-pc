#!/bin/bash

# setting up the symbolic link to bin path

_user=$(whoami)
_pwd=$(pwd)

echo "$_prefix Creating symbolic link 'smpc' on /usr/local/bin/ path..."
if [[ $_user != "root" ]]; then
	sudo rm /usr/local/bin/smpc # case already exist
	sudo ln -s $_pwd/bin/smpc.sh /usr/local/bin/smpc
else
	rm /usr/local/bin/smpc
	ln -s $_pwd/bin/smpc.sh /usr/local/bin/smpc
fi

# adding execution permission to the scripts in bin path
echo "$_prefix Adding execution permission to the scripts in $_pwd/bin path..."
chmod +x ./bin/*.sh