#!/bin/bash

# files with arch linux default

sudo pacman-mirrors -ic Brazil

# basic
sudo pacman -Syu git vim wget curl copyq unzip xclip ncdu sxhkd flameshot autojump

# dev
albert xdotool ripgrep diff-so-fancy terminator git-recent

# personal
tldr exa bat prettyping

# system
sudo pacman -Syu pulseaudio pavucontrol # audio control
ncdu sxhkd flameshot copyq unzip
