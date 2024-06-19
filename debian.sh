#!/bin/bash

echo "Installing basic applications..."
sudo apt-get install -y git vim wget curl copyq unzip xclip ncdu flameshot zsh

# sxhkd: add autostart script -> /usr/bin/sxhkd
# fusmua: add autostart script -> /.conf/fusuma/fusuma.sh

echo "Installing fun applications..."
sudo apt-get install -y fortune cowsay

echo "Installing dev applications..."
sudo apt-get install -y nodejs npm albert xdotool ripgrep diff-so-fancy tree redis postgresql postgresql-contrib alacritty tmux ngrok git-extras

echo "Installing personal applications..."
sudo apt-get install -y autojump tldr exa bat prettyping libsecret jumpapp

echo "Installing system applications..."
sudo apt-get install -y pulseaudio pavucontrol # audio control

# store: postman, vscode, chrome, dbeaver
# manual: jetbrains font
# https://www.jetbrains.com/lp/mono/#how-to-install

# tutorials
# docker: https://linuxconfig.org/manjaro-linux-docker-installation
# postgres: https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart

# ulauncher
# https://github.com/Ulauncher/ulauncher-emoji
# https://github.com/pwnyprod/ulauncher-ipcopy
# https://github.com/friday/ulauncher-clipboard
# https://github.com/episode6/ulauncher-system-management-direct
# https://github.com/isacikgoz/ukill
# https://github.com/ulauncher/ulauncher-timer

echo "Installing broot..."
sudo apt install build-essential libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev -y
cd /usr/local/bin && sudo wget -rnd https://dystroy.org/broot/download/x86_64-linux/broot && sudo chmod +x broot && cd -

echo "Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

#ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing zsh interactive..."
# git clone https://github.com/changyuheng/zsh-interactive-cd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive

echo "Installing zsh syntax highlight..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open
# git clone https://github.com/wfxr/forgit.git "$ZSH_CUSTOM/plugins/forgit"
# git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"

npm install --global git-open

echo "Setup my personal dotfiles..."
git clone https://github.com/jonaselan/dotfiles.git ~/.smpc

echo "Creating folders..."
mkdir ~/.config/alacritty/
mkdir ~/.config/sxhkd/
mkdir ~/.config/fusuma/

# src:dest
# "$HOME/.smpc/terminator:$HOME/.config/terminator/config"
link_files=(
    "$HOME/.smpc/.zshrc:$HOME/.zshrc"
    "$HOME/.smpc/.vimrc:$HOME/.vimrc"
    "$HOME/.smpc/.tmux:$HOME/.tmux.conf"
    "$HOME/.smpc/.gitconfig:$HOME/.gitconfig"
    "$HOME/.smpc/sxhkdrc:$HOME/.config/sxhkd/sxhkdrc"
    "$HOME/.smpc/fusuma.yml:$HOME/.config/fusuma/config.yml"
    "$HOME/.smpc/atuin.yml:$HOME/.config/atuin/atuin.toml"
    "$HOME/.smpc/alacritty.toml:$HOME/.config/alacritty/alacritty.toml"
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
