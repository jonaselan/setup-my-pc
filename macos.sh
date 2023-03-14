#!/bin/bash

echo "Installing homebrew..."
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating homebrew..."
brew update

echo "Installing basic applications..."
brew install git
brew install vim
brew install wget
brew install curl
brew install copyq
brew install unzip
brew install xclip
brew install ncdu
brew install git-extras
brew install --cask vlc
brew install --cask spotify
brew install --cask google-chrome

echo "Installing fun applications..."
brew install fortune-mod
brew install cowsay

echo "Installing dev applications..."
brew install ripgrep
brew install diff-so-fancy
brew install postgresql
brew install tmux
brew install autojump
brew install --cask dbeaver-community
brew install --cask postman
brew install --cask vscode
brew install --cask docker
brew install --cask alacritty
brew install --cask docker-compose

echo "Installing personal applications..."
brew install tldr
brew install broot
brew install exa
brew install bat
brew install prettyping

echo "cleaning brew packages..."
brew cleanup

echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "Installing zsh interactive..."
git clone https://github.com/changyuheng/zsh-interactive-cd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive

echo "Installing zsh syntax highlight..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Installing zsh auto suggestion..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Installing forgit..."
git clone https://github.com/wfxr/forgit.git "$ZSH_CUSTOM/plugins/forgit"

echo "Installing fzf-tab..."
git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
