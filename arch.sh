#!/bin/bash

# files with arch linux default

sudo pacman-mirrors -ic Brazil

# basic
sudo pacman -Syu git vim wget curl copyq unzip xclip ncdu sxhkd flameshot zsh
#ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# sxhkd: add autostart script -> /usr/bin/sxhkd
# fusmua: add autostart script -> /.conf/fusuma/fusuma.sh

# yay
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -fr yay

# fun
sudo yay -S fortune-mod cowsay

# dev
sudo yay -Syu nodejs npm albert xdotool ripgrep diff-so-fancy tree redis postgresql alacritty tmux

# personal
sudo yay -Syu autojump tldr exa bat prettyping libsecret gnome-keyring aur/jumpapp-git

# system
sudo yay -Syu pulseaudio pavucontrol # audio control

# store: postman, vscode, chrome, dbeaver, mailspring

# tutorials
# docker: https://linuxconfig.org/manjaro-linux-docker-installation
# postgres: https://lobotuerto.com/blog/how-to-install-postgresql-in-manjaro-linux/


# scripts
cd /usr/local/bin && sudo wget -rnd https://dystroy.org/broot/download/x86_64-linux/broot && sudo chmod +x broot && cd -

git clone https://github.com/changyuheng/zsh-interactive-cd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-interactive

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/wfxr/forgit.git "$ZSH_CUSTOM/plugins/forgit"
git clone https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"

git clone https://github.com/jonaselan/dotfiles.git ~/.smpc
# Setup folders
mkdir ~/.config/terminator/
mkdir ~/.config/sxhkd/
mkdir ~/.config/fusuma/

# src:dest
# "$HOME/.smpc/terminator:$HOME/.config/terminator/config"
link_files=(
    "$HOME/.smpc/.zshrc:$HOME/.zshrc"
    "$HOME/.smpc/.vimrc:$HOME/.vimrc"
    "$HOME/.smpc/.tmux:$HOME/.tmux"
    "$HOME/.smpc/.gitconfig:$HOME/.gitconfig"
    "$HOME/.smpc/sxhkdrc:$HOME/.config/sxhkd/sxhkdrc"
    "$HOME/.smpc/fusuma.yml:$HOME/.config/fusuma/config.yml"
    "$HOME/.smpc/startship.toml:$HOME/.config/startship.toml"
    "$HOME/.smpc/alacritty.yml:$HOME/.config/alacritty/alacritty.yml"
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
