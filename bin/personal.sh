#!/bin/bash

common_packages=(
  $(command_exists vim || echo vim)
  $(command_exists wget || echo wget)
  $(command_exists curl || echo curl)
  $(command_exists java || echo java)
  $(command_exists node || echo node)
)

personal_packages=(
  'terminator'
  'ripgrep'
  'bat'
  'ohmyzsh'
  'kolourpaint4'
  'spotify'
  'vlc'
)

install_personal(){
  if [[ ${#common_packages[@]} != 0 ]]
  then
      sudo apt-get install ${common_packages[@]}
  fi

  for package in "${personal_packages[@]}"
  do
      if ! hash $package 2>/dev/null; then
          install_$package
      else
          echo 'installed'
      fi
  done
}

install_terminator(){
  echo "Installing ripgrep"
	echo "Based on: https://github.com/BurntSushi/ripgrep#installation"
	echo

  sudo apt-get update
  sudo apt-get install ripgrep -y

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

install_ohmyzsh(){
	if [[ -e /usr/bin/zsh && -e ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
		echo "Oh-My-Zsh is already installed!"
		exit 0
	fi

	echo "Installing Oh-My-Zsh"
	echo "Based on: https://github.com/robbyrussell/oh-my-zsh/blob/master/README.md"
	echo

	if [[ ! -e /usr/bin/zsh ]]; then
		echo "Zsh is required. Do you want install it? (Y/n)"
		read choice;
		choice=$(first_letter_lower $choice)
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
			echo "curl or wget is required. Do you want install them? (Y/n)"
			read choice;
			choice=$(first_letter_lower $choice)
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

# install_zshplugins(){
  # https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
  # https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh
# }
