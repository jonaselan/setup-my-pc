#!/bin/bash

basic_packages=(
  $(command_exists vim || echo vim)
  $(command_exists wget || echo wget)
  $(command_exists curl || echo curl)
  $(command_exists java || echo java)
  $(command_exists node || echo node)
)

install_basic(){
  if [[ ${#common_packages[@]} != 0 ]]
  then
      sudo apt-get install ${common_packages[@]} -y
  fi
}