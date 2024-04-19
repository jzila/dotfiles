vim: ${HOME}/.vimrc ${HOME}/.config/nvim
	ln -s $(CURDIR)/.vim ${HOME}/.config/nvim
	ln -s $(CURDIR)/vimrc ${HOME}/.vimrc

zshell: ${HOME}/.zshrc
	sudo apt install zsh
	ln -s $(CURDIR)/zshrc ${HOME}/.zshrc
	chsh -s /bin/zsh

# Yubikey Manager
# https://github.com/Yubico/yubikey-manager
yubikey-manager:
	sudo apt-add-repository ppa:yubico/stable
	sudo apt update
	sudo apt install yubikey-manager

google-chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
	sudo apt update
	sudo apt install google-chrome-stable
