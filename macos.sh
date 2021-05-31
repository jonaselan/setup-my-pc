#!/bin/bash

echo "Installing homebrew..."
if test ! $(which brew); then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating homebrew..."
brew update

echo "Installing homebrew cask"
brew install caskroom/cask/brew-cask

echo "Installing basic applications..."
brew install git
brew install vim
brew install wget
# brew install curl
brew install copyq
brew install unzip
brew install xclip
brew install ncdu
brew install sxhkd
# brew install flameshot

echo "Installing fun applications..."
brew install fortune-mod
brew install cowsay

echo "Installing dev applications..."
brew install nodejs
brew install npm
brew install xdotool
brew install ripgrep
brew install diff-so-fancy
brew install postgresql
brew install alacritty
brew install tmux
brew install autojump

echo "Installing personal applications..."
brew install tldr
brew install exa
brew install bat
brew install prettyping
brew install libsecret
brew install gnome-keyring
brew install aur/jumpapp-git

# Apps
apps=(
  alfred
  bartender
  bettertouchtool
  cleanmymac
  cloud
  colloquy
  cornerstone
  diffmerge
  google-chrome
  hipchat
  licecap
  mou
  private-internet-access
  razer-synapse
  sourcetree
  steam
  spotify
  textexpander
  virtualbox
  mailbox
  vlc
  transmission
  zoomus
  onepassword
  docker
  docker-compose
  qlmarkdown
  qlstephen
  suspicious-package
  postman
  dbeaver
  vscode
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps with Cask..."
brew cask install --appdir="/Applications" ${apps[@]}

brew cask alfred link

brew cask cleanup
brew cleanup

echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

echo "Installing broot..."
cd /usr/local/bin && sudo wget -rnd https://dystroy.org/broot/download/x86_64-linux/broot && sudo chmod +x broot && cd -

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

echo "Setup my personal dotfiles..."
git clone https://github.com/jonaselan/dotfiles.git ~/.smpc

echo "Creating folders..."
mkdir ~/.config/terminator/
mkdir ~/.config/sxhkd/
mkdir ~/.config/fusuma/

# src:dest
link_files=(
    "$HOME/.smpc/.zshrc:$HOME/.zshrc"
    "$HOME/.smpc/.vimrc:$HOME/.vimrc"
    "$HOME/.smpc/.gitconfig:$HOME/.gitconfig"
    "$HOME/.smpc/alacritty.yml:$HOME/.config/alacritty/alacritty.yml"
    "$HOME/.smpc/sxhkdrc:$HOME/.config/sxhkd/sxhkdrc"
    "$HOME/.smpc/fusuma.yml:$HOME/.config/fusuma/config.yml"
)

# Link files
info 'Linking dotfiles'
for lf in "${link_files[@]}"
do
    src="$(echo -n $lf | cut -d':' -f1)"
    dest="$(echo -n $lf | cut -d':' -f2)"

    ln -sTf $src $dest

    # explicit simbolyc link
    stat -c '%N' "$(echo -n $lf | cut -d':' -f2)"
done


