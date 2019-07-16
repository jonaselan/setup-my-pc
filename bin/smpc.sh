#!/bin/bash

# Command line arguments
_argc=$# # count of arguments
_script=$0 # name of this script
_action=$1 # action related to the option
_option=$2 # option of commands to run
_tag=$3 # tag to modify some behavior of the execution

# importing functions
. $SMPCPATH/bin/helpers.sh
. $SMPCPATH/bin/basic.sh
. $SMPCPATH/bin/dev.sh
. $SMPCPATH/bin/personal.sh

main() {
  if [[ $_action == "install" ]]; then
    # TODO: use flagh for install tools individually
    if [[ $_option == "personal" || $_option == "dev" || $_option == "basic" ]]; then
      install_$_option
    else
      echo 'Option not found'
    fi
  elif [[ $_action == 'version' ]]; then
    show_version
  elif [[ $_argc -eq 0 || $_action == "help" ]]; then
    show_help
  else
    echo 'Command not found'
  fi
}

#execute
main
