#!/bin/bash

personal_packages=(
  'ohmyzsh'
  'delta'
  'zshplugins'
  'prettyping'
  'terminator'
  'bat'
  'ripgrep'
  'fzf'
  'kolourpaint4'
  'spotify'
  'vlc'
  'fira_code'
  'exa'
  'diff_so_fancy'
  'system_monitor'
  'fusuma'  # need reload and setup startup command 'sudo fusuma'
	# albert https://software.opensuse.org/download.html?project=home:manuelschneid3r&package=albert
  # 'tweak'
  # 'statusubuntu'
)

install_personal(){
	for package in "${personal_packages[@]}"
	do
		if ! hash $package 2>/dev/null; then
			install_$package
		else
			fail "${$package} is already installed!"
		fi
	done

	user "Download jonaselan's dotfiles? (y/n)"
	read choice;

	if [[ $choice == "y" ]]; then
		update_dotfiles
	fi
}

install_terminator(){
  info "Installing terminator"
  info "Based on: https://gnometerminator.blogspot.com/p/introduction.html"

  sudo add-apt-repository ppa:gnome-terminator
  sudo apt-get update
  sudo apt-get install terminator -y

  success "Terminator installed!"
}

install_bat(){
  info "Installing Bat"
	info "Based on: https://github.com/sharkdp/bat#installation"

  wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat-musl_0.11.0_amd64.deb
  sudo apt install ./bat-musl_0.11.0_amd64.deb -y
  rm bat-musl_0.11.0_amd64.deb

  success "Bat installed!"
}

install_kolourpaint4(){
	info "Installing kolourpaint"
	info "Based on: https://www.vivaolinux.com.br/artigo/Kolourpaint-Um-editor-grafico-muito-util"

	sudo apt-get update
	sudo apt-get install kolourpaint4 -y

	success "kolourpaint installed!"
}

install_ripgrep(){
	info "Installing ripgrep"
	info "Based on: https://github.com/BurntSushi/ripgrep#installation"

	sudo apt-get update
	sudo apt-get install ripgrep -y

	success "ripgrep installed!"
}

install_fzf(){
	info "Installing fzf"
	info "Based on: https://github.com/junegunn/fzf#using-git"

	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

	success "fzf installed"
}

install_spotify(){
	user "Installing Spotify"
	user "Based on: https://www.spotify.com/br/download/linux/"

	# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
	# 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	# 3. Update list of available packages
	sudo apt-get update
	# 4. Install Spotify
	sudo apt-get install spotify-client -y

	success "Spotify installed"
}

install_vlc(){
  info "Installing VLC..."
	info "Based on: http://www.edivaldobrito.com.br/como-instalar-a-ultima-versao-do-vlc/"

	sudo add-apt-repository ppa:nicola-onorata/desktop
	sudo apt update
	sudo apt install vlc

	success "VLC installed"
}

install_ohmyzsh(){
	if [[ -e /usr/bin/zsh && -e ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
		fail "Oh-My-Zsh is already installed!"
	else
		info "Installing Oh-My-Zsh"
		info "Based on: https://github.com/robbyrussell/oh-my-zsh/blob/master/README.md"

		if [[ ! -e /usr/bin/zsh ]]; then
			user "Zsh is required. Do you want install it? (y/n)"
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
				user "curl or wget is required. Do you want install them? (y/n)"
				read choice;

				if [[ $choice == "y" ]]; then
					sudo apt update && sudo apt install wget curl
					smpc $_action $_option
				fi
			fi
		fi

		success "Oh-My-Zsh Installed"
	fi
}

install_prettyping(){
	info "Installing Prettyping"
	info "Based on: http://denilson.sa.nom.br/prettyping/"

	curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
	sudo mv prettyping /usr/local/bin/prettyping
	sudo chmod +x /usr/local/bin/prettyping

	success "Prettyping Installed"
}

install_delta() {
	info "Installing Delta"
	info "Based on: https://github.com/dandavison/delta"

	wget https://github.com/dandavison/delta/releases/download/0.0.14/delta_0.0.14_amd64.deb
	sudo dpkg -i delta_0.0.14_amd64.deb
	rm delta_0.0.14_amd64.deb

	success "Delta Installed"
}

# I know the exist plugin managers, but this way I don't install extra things
install_zshplugins(){
	info "Installing zsh-syntax-highlighting"
	info "Based on: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh"

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	success "zsh-syntax-highlighting Installed"
	# ------------
	info "Installing zsh-autosuggestions"
	info "https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh"

	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	success "zsh-autosuggestions Installed"
	# ------------
	info "Installing zsh-interactive-cd"
	info "https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh"

	git clone https://github.com/changyuheng/zsh-interactive-cd.git "$ZSH_CUSTOM/plugins/zsh-interactive"
	success "zsh-interactive-cd Installed"
	# ------------
	info "Installing Spaceship theme"
	info "https://github.com/denysdovhan/spaceship-prompt#oh-my-zsh"

	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	success "spaceship-theme Installed"
	# ------------
	info "Installing Forgit"
	info "https://github.com/wfxr/forgit"

	git clone https://github.com/wfxr/forgit.git "$ZSH_CUSTOM/plugins/forgit"

	success "Forgit Installed"
}

install_fira_code(){
	info "Downloading and Installing Fira Code font"
	info "Based on: https://github.com/tonsky/FiraCode/wiki/Linux-instructions#manual-installation"

	fonts_dir="${HOME}/.local/share/fonts"
	if [ ! -d "${fonts_dir}" ]; then
			echo "mkdir -p $fonts_dir"
			mkdir -p "${fonts_dir}"
	else
			echo "Found fonts dir $fonts_dir"
	fi

	for type in Bold Light Medium Regular Retina; do
			file_path="${HOME}/.local/share/fonts/FiraCode-${type}.ttf"
			file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
			if [ ! -e "${file_path}" ]; then
					echo "wget -O $file_path $file_url"
					wget -O "${file_path}" "${file_url}"
			else
		echo "Found existing file $file_path"
			fi;
	done

	echo "fc-cache -f"
	fc-cache -f

	success "Fira code installed"
}

install_exa(){
	info "Installing exa"
	info "Based on: https://www.tricksofthetrades.net/2018/08/30/exa-getting-started/"

	wget https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip -P ~/
	unzip ~/exa-linux-x86_64-0.9.0.zip -d ~/
	sudo mv ~/exa-linux-x86_64 /usr/local/bin/exa
	rm ~/exa-linux-x86_64-0.9.0.zip

	success "Exa installed"
}

install_diff_so_fancy() {
	info "Installing Diff So Fancy"
	info "Based on: https://gist.github.com/GregKWhite/dbf710ddf72cfae502ad695019a87a1c"

	npm install -g diff-so-fancy

	success "Diff So Fancy installed"
}

install_system_monitor() {
	info "Installing Widget System monitor"
	info "Based on: https://github.com/paradoxxxzero/gnome-shell-system-monitor-applet"

	sudo apt-get install gir1.2-gtop-2.0 gir1.2-networkmanager-1.0  gir1.2-clutter-1.0

	success "Widget System monitor installed"
}

install_fusuma() {
	if ! hash ruby 2>/dev/null; then
		fail "Ruby is not installed yet!"
	else
		sudo gpasswd -a $USER input
		sudo gem install fusuma
		sudo apt-get install libinput-tools xdotool
	fi
}
