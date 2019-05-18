#!/bin/bash

# Command line arguments
_argc=$# # count of arguments
_script=$0 # name of this script
_block=$1 # block of commands to run
_option=$2 # option related to the block
_tag=$3 # tag to modify some behavior of the execution

# importing functions
. $SMPCPATH/bin/helpers.sh
. $SMPCPATH/bin/dev.sh
. $SMPCPATH/bin/personal.sh

main() {
  echo $SMPCPATH
  echo '----'
  echo $_argc
  echo '----'
  echo $_script
  echo '----'
  echo $_block
  echo '----'
  echo $_option
  echo '----'
  echo $_tag
}

#execute
main