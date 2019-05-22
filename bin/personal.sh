#!/bin/bash

personal_packages=(
  'ohmyzsh'
  'terminator'
  'bat'
  'ripgrep'
	'fzr'
  'kolourpaint4'
  'spotify'
  'vlc'
)

install_personal(){
  for package in "${personal_packages[@]}"
  do
      if ! hash $package 2>/dev/null; then
          install_$package
      else
          echo "${$package} already installed"
      fi
  done
}

install_terminator(){
  echo "Installing terminator"
	echo "Based on: https://gnometerminator.blogspot.com/p/introduction.html"
	echo

  sudo add-apt-repository ppa:gnome-terminator
  sudo apt-get update
  sudo apt-get install terminator -y

  echo "Terminator installed!"
  echo
}

install_bat(){
  echo "Installing Bat"
	echo "Based on: https://github.com/sharkdp/bat#installation"
	echo

  wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat-musl_0.11.0_amd64.deb
  sudo apt install ./bat-musl_0.11.0_amd64.deb -y
  rm bat-musl_0.11.0_amd64.deb

  echo "Bat installed!"
  echo
}

install_kolourpaint4(){
  echo "Installing kolourpaint"
	echo "Based on: https://www.vivaolinux.com.br/artigo/Kolourpaint-Um-editor-grafico-muito-util"
	echo

  sudo apt-get update
  sudo apt-get install kolourpaint4 -y

  echo "kolourpaint installed!"
  echo
}

install_ripgrep(){
  echo "Installing ripgrep"
	echo "Based on: https://github.com/BurntSushi/ripgrep#installation"
	echo

  sudo apt-get update
  sudo apt-get install ripgrep -y

  echo "ripgrep installed!"
  echo
}

install_fzr(){
	echo "Installing fzr"
	echo "Based on: https://github.com/junegunn/fzf#using-git"
	echo

	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

	echo "fzr installed"
	echo
}

install_spotify(){
  echo "Installing Spotify"
	echo "Based on: https://www.spotify.com/br/download/linux/"
	echo

  # 1. Add the Spotify repository signing keys to be able to verify downloaded packages
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
  # 2. Add the Spotify repository
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  # 3. Update list of available packages
  sudo apt-get update
  # 4. Install Spotify
  sudo apt-get install spotify-client -y

  echo
	echo "Spotify installed"
}

install_vlc(){
  echo "Installing VLC..."
	echo "Based on: http://www.edivaldobrito.com.br/como-instalar-a-ultima-versao-do-vlc/"
	echo

	sudo add-apt-repository ppa:nicola-onorata/desktop
	sudo apt update
	sudo apt install vlc

	echo
	echo "VLC installed"
}

install_ohmyzsh(){
	if [[ -e /usr/bin/zsh && -e ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
		echo "Oh-My-Zsh is already installed!"
		exit 0
	fi

	echo "Installing Oh-My-Zsh"
	echo "Based on: https://github.com/robbyrussell/oh-my-zsh/blob/master/README.md"
	echo

	if [[ ! -e /usr/bin/zsh ]]; then
		echo "Zsh is required. Do you want install it? (y/n)"
		read choice;

		if [[ $choice == "y" ]]; then
			sudo apt update && sudo apt install zsh
			chsh -s $(which zsh)
			zsh --version
		fi
	fi

	if [[ -e /usr/bin/curl ]]; then
		cd
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		cd -
	else
		if [[ -e /usr/bin/wget ]]; then
			cd
			sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
			cd -
		else
			echo "curl or wget is required. Do you want install them? (y/n)"
			read choice;

			if [[ $choice == "y" ]]; then
				sudo apt update && sudo apt install wget curl
				smpc $_action $_option
			fi
		fi
	fi
	echo "Oh-My-Zsh Installed"

  confirm_install 'zshplugins'
  # baixar .zshrc do meu github
}

# I know the exist plugin managers, but this way I don't install extra things
install_zshplugins(){
	echo "Installing zsh-syntax-highlighting"
	echo "https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh"
	echo

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	echo "zsh-syntax-highlighting Installed"

	echo "Installing zsh-autosuggestions"
	echo "https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh"
	echo

	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	echo "zsh-autosuggestions Installed"

}
