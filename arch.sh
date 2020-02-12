#!/bin/bash

# files with arch linux default

sudo pacman-mirrors -ic Brazil

# basic
sudo pacman -Syu git vim wget curl copyq unzip xclip ncdu sxhkd flameshot yaourt zsh

# dev
sudo pacman -Syu albert xdotool ripgrep diff-so-fancy terminator git-recent

# personal
sudo pacman -Syu  tldr exa bat prettyping libsecret gnome-keyring

# system
sudo pacman -Syu pulseaudio pavucontrol # audio control

# others: vscode, chrome

# yay 
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -fr ya
