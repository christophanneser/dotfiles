NY: reset-symlinks
#---------------------------------------------------------------------------
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
#---------------------------------------------------------------------------
CCLS_VERSION := 99f0b402a7584f92de12f0af164ad7e0c772fcd2
CCLS_REPO_DIR := ~/.ccls/repo
CCLS_BUILD_DIR := ~/.ccls/build
CCLS_INSTALL_PREFIX := ~/.local
LLVM_PREFIX_PATH := /usr/lib/llvm-9/lib/cmake
#---------------------------------------------------------------------------
install-nerd-fonts:
	# nerd fonts are used for displaying icons in NeoMutt
	@curl https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/\
	patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf \
	-o ~/.local/share/fonts/nerd-fonts.ttf
	@fc-cache -fv # manually rebuilt font cache
	# manually set terminal using "Hack Regular Nerd Font"
#---------------------------------------------------------------------------
encrypt-mail-configs:
	@cp ~/.config/msmtp/msmtprc ${MAKEFILE_DIR}/mails/msmtprc
	@rm -f mails/mail-configs.tar.gz
	@tar --exclude='*gpg' --exclude='*.gitignore' -czvf  mail-configs.tar.gz -C ${MAKEFILE_DIR}/mails/ .
	@mv mail-configs.tar.gz ${MAKEFILE_DIR}/mails/
	@gpg --symmetric --cipher-algo AES256 ${MAKEFILE_DIR}/mails/mail-configs.tar.gz
#---------------------------------------------------------------------------
install-mails-programs:
	@sudo apt-get install msmtp  # for sending mails via SMTP
	@sudo apt-get install isync  # executable mbsync, for IMAP
	@sudo apt-get install neomutt  # highly configurable mail client
	@sudo apt-get install abook  # contact manager for NeoMutt
	@sudo apt-get install notmuch  # allows for querying the mail databases
	@sudo apt-get install libsecret-tools  # allows to store passwords in keyring
#---------------------------------------------------------------------------
configure-mails:
	# decrypt mail configs
	@gpg -o mails/mail-configs.tar.gz -d mails/mail-configs.tar.gz.gpg
	@tar -zxvf ${MAKEFILE_DIR}/mails/mail-configs.tar.gz -C ${MAKEFILE_DIR}/mails/
	# @rm ${MAKEFILE_DIR}/mails/mail-configs.tar.gz

	# soft-link decrypted config files
	# @mkdir -p ~/.config/msmtp/ && cp mails/msmtprc ~/.config/msmtp/msmtprc
	# @ln -sf ~/.config/msmtp/msmtprc ~/.msmtprc
	# @mkdir -p ~/.abook && ln -sf ${MAKEFILE_DIR}/mails/addressbook ~/.abook/addressbook
	# @ln -sf ${MAKEFILE_DIR}/mails/mbsyncrc ~/.mbsyncrc
	# @ln -sf ${MAKEFILE_DIR}/mails/neomutt/ ~/.neomutt
#---------------------------------------------------------------------------
encrypt-remotes:
	@gpg --symmetric --cipher-algo AES256 shell/remotes.sh
#---------------------------------------------------------------------------
decrypt-remotes:
	@gpg -o shell/remotes.sh -d shell/remotes.sh.gpg
#---------------------------------------------------------------------------
key-switches:
	gsettings set org.gnome.desktop.input-sources xkb-options "['caps:swapescape']"
#---------------------------------------------------------------------------
create-directories:
	@mkdir -p ~/.config
	@mkdir -p ~/.local
#---------------------------------------------------------------------------
install-zsh:
	@sudo apt-get install zsh
#---------------------------------------------------------------------------
install-oh-my-zsh:
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	@sudo apt-get install fonts-powerline
#---------------------------------------------------------------------------
install-lldebugger:
	# needs python2 neovim
	@sudo apt-get -y install python-pip
	@pip2 install pynvim
	@sudo apt-get -y install lldb-8
	@sudo ln -s /usr/bin/lldb-server-8 /usr/bin/lldb-server-8.0.0
#---------------------------------------------------------------------------
# Language Servers
#---------------------------------------------------------------------------
install-ls-cc: # C++
	@sudo apt install ccls # alternatively build from sources: https://github.com/MaskRay/ccls
#---------------------------------------------------------------------------
install-ls-py: # Python
	@pip3 install 'python-language-server[all]'
	# @pip3 install python-language-server
#---------------------------------------------------------------------------
install-ls-tex: # TeX
	cargo install --git https://github.com/latex-lsp/texlab.git
#---------------------------------------------------------------------------
install-shell-translator: # Shell translator using Google Translate CLI
	@cd ~/Documents; \
		git clone https://github.com/soimort/translate-shell; \
		cd translate-shell; make; \
		sudo ln -s ~/Documents/translate-shell/build/trans /usr/local/bin/trans;
#---------------------------------------------------------------------------
install-clang-tools:
	@sudo apt-get install clang-tools
#---------------------------------------------------------------------------
reset-symlinks: create-directories
	@sh -c "[ ! -L ~/.bashrc ] || rm ~/.bashrc;"
	@sh -c "[ ! -L ~/.config/nvim ] || rm -r ~/.config/nvim;"
	@sh -c "[ ! -L ~/.gitconfig ] || rm ~/.gitconfig;"
	@sh -c "[ ! -L ~/.vim ] || rm -r ~/.vim;"
	@sh -c "[ ! -L ~/.vimrc ] || rm ~/.vimrc;"
#---------------------------------------------------------------------------
install-utils:
	@sudo cp utils/listener.py /bin/listener
	@sudo chmod +x /bin/listener
	@sudo cp utils/format_json.py /bin/format_json
	@sudo chmod +x /bin/format_json
#---------------------------------------------------------------------------
install-symlinks: reset-symlinks
	@ln -sf ${MAKEFILE_DIR}/shell/bashrc ~/.bashrc
	@ln -sf ${MAKEFILE_DIR}/shell/zshrc ~/.zshrc
	@ln -sf ${MAKEFILE_DIR}/git/gitconfig.conf ~/.gitconfig
	@ln -sf ${MAKEFILE_DIR}/tmux ~/.tmux
	@ln -sf ${MAKEFILE_DIR}/tmux/tmux.conf ~/.tmux.conf
	@ln -sf ${MAKEFILE_DIR}/vim ~/.config/nvim
#	@ln -sf ${MAKEFILE_DIR}/vim/init.vim ~/.config/nvim
	@ln -sf ${MAKEFILE_DIR}/vim ~/.vim
	@ln -sf ${MAKEFILE_DIR}/vim/init.vim ~/.vimrc
	@ln -sf ${MAKEFILE_DIR}/vim/idea.vim ~/.ideavimrc
#---------------------------------------------------------------------------
repair: reset-symlinks
	@sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim.basic 200
	@sudo update-alternatives --install /usr/bin/vim vim /usr/bin/vim.basic 200
	@sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim.basic 200
#---------------------------------------------------------------------------
install: install-symlinks
#---------------------------------------------------------------------------
