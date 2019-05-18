#!/bin/bash

# general variables
_user=$(whoami)
_pwd=$(pwd)
_prefix="[SMPC]"

# symbolic link for keep ref anywhere
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

# setting up the user profile configs (to be persistent between users logins sessions)
echo "$_prefix Setting up the user profile configs (to be persistent between users logins sessions)..."
for _profiles in ~/.*rc; do
	echo -e "\n export SMPCPATH=$_pwd" >> $_profiles
done
export MEOUPATH=$_pwd

# Another Try to export
# echo -e "#!/bin/bash \n\n export SMPCPATH=$_pwd" >> ./export.sh
# chmod +x ./export.sh
# source ./export.sh
# export SMPCPATH=$_pwd
# rm ./export.sh