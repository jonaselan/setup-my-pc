#!/bin/bash

basic_packages=(
  $(command_exists git || echo git)
  $(command_exists vim || echo vim)
  $(command_exists wget || echo wget)
  $(command_exists curl || echo curl)
  $(command_exists java || echo default-jdk) # https://thishosting.rocks/install-java-ubuntu/
  $(command_exists nodejs || echo nodejs)
  $(command_exists npm || echo npm)
  $(command_exists htop || echo htop)
  $(command_exists unzip || echo unzip)
  # google-chrome
)

install_basic(){
  update_packages

  if [[ ${#common_packages[@]} != 0 ]]
  then
      sudo apt-get install ${common_packages[@]} -y
  fi

  success "Basic tolls installed"
}