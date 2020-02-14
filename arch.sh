#!/bin/bash

# files with arch linux default

sudo pacman-mirrors -ic Brazil

# basic
sudo pacman -Syu git vim wget curl copyq unzip xclip ncdu sxhkd flameshot

# dev
sudo pacman -Syu nodejs npm albert xdotool ripgrep diff-so-fancy terminator postgresql

# personal
sudo pacman -Syu tldr exa bat prettyping

# system
sudo pacman -Syu pulseaudio pavucontrol # audio control

# shop: autojump, postman, vscode, chrome, dbeaver

# scripts
git clone https://github.com/changyuheng/zsh-interactive-cd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/wfxr/forgit.git "$ZSH_CUSTOM/plugins/forgit"

git clone https://github.com/jonaselan/dotfiles.git ~/.smpc
# Setup folders
mkdir ~/.config/terminator/
mkdir ~/.config/sxhkd/
mkdir ~/.config/fusuma/

# src:dest
link_files=(
    "$HOME/.smpc/.zshrc:$HOME/.zshrc"
    "$HOME/.smpc/.vimrc:$HOME/.vimrc"
    "$HOME/.smpc/.gitconfig:$HOME/.gitconfig"
    "$HOME/.smpc/terminator:$HOME/.config/terminator/config"
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
