#!/bin/bash

dev_packages=(
    $(command_exists php || echo php)
    $(command_exists composer || echo composer)
    $(command_exists docker || echo docker)
    $(command_exists dbeaver || echo dbeaver)
    $(command_exists vscode || echo vscode)
    $(command_exists postman || echo postman)
    $(command_exists htop || echo htop)
)

# install_dev(){

# }