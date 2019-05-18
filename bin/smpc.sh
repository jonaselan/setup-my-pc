#!/bin/bash

# Command line arguments
_argc=$# # count of arguments
_script=$0 # name of this script
_action=$1 # action related to the option
_option=$2 # option of commands to run
_tag=$3 # tag to modify some behavior of the execution

# importing functions
. $SMPCPATH/bin/helpers.sh
. $SMPCPATH/bin/dev.sh
. $SMPCPATH/bin/personal.sh

function command_exists() {
    type "$1" >/dev/null 2>&1
}

personal_packages=(

)

dev_packages=(
    $(command_exists ipython || echo ipython)
    $(command_exists composer || echo composer)
    $(command_exists node || echo nodejs)
)

main() {
  if [[ $_action == "install" ]]; then
    # which option must be runned
    case $_option in
      ohmyzsh)
        install_option $_option
        ;;
      # default case
      *)
        echo 'Option not found'
        ;;
    esac
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