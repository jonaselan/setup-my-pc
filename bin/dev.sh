#!/bin/bash

dev_packages=(
    'php'
    'composer'
    'docker'
    'docker-compose'
    'dbeaver'
    'apache2'
    'nginx'
    'postgresql'
    'mysq'
    'postman'
)
# 'vscode'

install_dev(){
    update_packages

    for package in "${dev_packages[@]}"
    do
        if ! hash $package 2>/dev/null; then
            install_$package
        else
            fail "${$package} already installed"
        fi
    done
}

install_php(){
    info "Installing PHP"
	info "Based on: https://thishosting.rocks/install-php-on-ubuntu/#php73"
    update_packages
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:ondrej/php
    sudo apt-get update
    sudo apt-get install php7.3 -y
    sudo apt-get install php-pear php7.3-curl php7.3-dev php7.3-gd php7.3-mbstring php7.3-zip php7.3-mysql php7.3-xml

	success "Php installed"
}

install_composer(){
	info "Installing Composer..."
	info "Based on: https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md"

	cd
	EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

	if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
	then
	    >&2 echo 'ERROR: Invalid installer signature'
	    rm composer-setup.php
	    exit 1
	fi

	php composer-setup.php --quiet --install-dir=/usr/local/bin --filename=composer
	rm composer-setup.php

	success "Composer installed."
}

install_docker(){
    info "Installing Docker CE..."
	info "Based on: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/"

	sudo apt remove docker docker-engine docker.io
	sudo apt update
	sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
	curl -sSL https://get.docker.com/ | sh
   	warning "Adding '$(whoami)' user to the docker group..."
   	sudo usermod -aG docker $(whoami)
   	warning "Testing if Docker CE was installed correctly..."
   	docker run hello-world

	success "Docker CE installed"
}

install_docker-compose(){
	info "Installing Docker Compose..."
	info "Based on: https://docs.docker.com/compose/install/#install-compose"

	sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
	docker-compose --version

	success "Docker Compose installed."
}

install_dbeaver(){
	info "Installing DBeaver"
	info "Based on: https://medium.com/@jonas.elan/install-and-configure-dbeaver-on-linux-ubuntu-81db4e38e1f3"

	wget https://dbeaver.io/files/dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
	tar -zxvf dbeaver-ce-latest-linux.gtk.x86_64.tar.gz
	sudo mv dbeaver /usr/share/
	sudo cp /usr/share/dbeaver/dbeaver.desktop /usr/share/applications
	sudo chmod +x -R /usr/share/dbeaver/

	rm dbeaver-ce-latest-linux.gtk.x86_64.tar.gz

	success "DBeaver installed"
}

install_apache2(){
	info "Installing Apache2"
	info "Based on: https://tutorials.ubuntu.com/tutorial/install-and-configure-apache#1"

	update_packages
	sudo apt-get install apache2

	sucess "Apache2 Installed"
}

install_nginx() {
	info "Installing Nginx"
	info "Based on: https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-18-04-quickstart"

	update_packages
	sudo apt-get install nginx

	sucess "Nginx Installed"
}

install_postgresql() {
	info "Installing Posgresql"
	info "Based on: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-18-04"

    update_packages
	sudo apt install postgresql postgresql-contrib

	success "Postgresql installed!"
}

install_mysql() {
	info "Based on: https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-16-04"
	info "Installing Mysql"

    update_packages
	sudo apt-get install mysql-server
	mysql_secure_installation

	success "Mysql installed!"
}


install_postman(){
	info "Installing Postman"
	info "Based on: https://www.bluematador.com/blog/postman-how-to-install-on-ubuntu-1604"

	wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
	sudo tar -xzf postman.tar.gz -C /opt
	rm postman.tar.gz
	sudo ln -s /opt/Postman/Postman /usr/bin/postman
	sudo cat > /usr/share/applications/postman.desktop <<EOL
	[Desktop Entry]
	Encoding=UTF-8
	Name=Postman
	Exec=postman
	Icon=/opt/Postman/app/resources/app/assets/icon.png
	Terminal=false
	Type=Application
	Categories=Development;
	EOL

	sucess "Postman installed"
}
