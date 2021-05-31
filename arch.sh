#!/bin/bash

echo "Switch packages finder to Brazil..."
sudo pacman-mirrors -ic Brazil

echo "Installing basic applications..."
sudo pacman -Syu git vim wget curl copyq unzip xclip ncdu sxhkd flameshot zsh

echo "Installing yay..."
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -fr yay

echo "Installing fun applications..."
sudo yay -S fortune-mod cowsay

echo "Installing dev applications..."
sudo yay -Syu nodejs npm albert xdotool ripgrep diff-so-fancy postgresql alacritty tmux

echo "Installing personal applications..."
sudo yay -Syu  tldr exa bat prettyping libsecret gnome-keyring aur/jumpapp-git

echo "Installing system applications..."
sudo yay -Syu pulseaudio pavucontrol # audio control

# shop: autojump, postman, vscode, chrome, dbeaver, mailspring

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


