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
RUST_ANALYZER_VERSION := 2021-04-26
#---------------------------------------------------------------------------
install-window-manager: # awesome window manager
	@sudo apt-get install -y i3
	@sudo apt-get install -y polybar
	@sudo apt-get install -y rofi
	@pip3 install pywal
#---------------------------------------------------------------------------
install-diff-so-fancy:
	@curl -fSL https://github.com/so-fancy/diff-so-fancy/releases/download/v1.4.4/diff-so-fancy -o third-party/diff-so-fancy
	@chmod +x third-party/diff-so-fancy
	@ln -s ${MAKEFILE_DIR}/third-party/diff-so-fancy ~/.local/bin/
#---------------------------------------------------------------------------
install-nerd-fonts:
	# nerd fonts are used for displaying fancy icons in the terminal
	@mkdir -p ~/.local/share/fonts/
	@curl -fSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/0xProto.zip -o ~/.local/share/fonts/0xProto.zip
	@cd ~/.local/share/fonts && unzip -o 0xProto.zip && rm 0xProto.zip;
	@fc-cache -fv # manually rebuilt font cache
	@echo Now go to terminal and manually set the nerd font
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
install-ls-rs:
	rustup component add rust-src rustfmt && \
	mkdir -p ~/.local/bin/ && \
	curl -L -o ~/.local/bin/rust-analyzer https://github.com/rust-analyzer/rust-analyzer/releases/download/${RUST_ANALYZER_VERSION}/rust-analyzer-linux && \
	chmod +x ~/.local/bin/rust-analyzer
#---------------------------------------------------------------------------
install-ls-cc: # C++
	@sudo apt install ccls # alternatively build from sources: https://github.com/MaskRay/ccls
#---------------------------------------------------------------------------
install-ls-py: # Python
	@pip3 install 'python-language-server[all]'
	# @pip3 install python-language-server
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
install-keyboard-layout:
	@sudo cp xkb/us_de /usr/share/X11/xkb/symbols
#---------------------------------------------------------------------------
reset-symlinks: create-directories
	@sh -c "[ ! -L ~/.bashrc ] || rm ~/.bashrc;"
	@sh -c "[ ! -L ~/.config/nvim ] || rm -r ~/.config/nvim;"
	@sh -c "[ ! -L ~/.gitconfig ] || rm ~/.gitconfig;"
	@sh -c "[ ! -L ~/.vim ] || rm -r ~/.vim;"
	@sh -c "[ ! -L ~/.vimrc ] || rm ~/.vimrc;"
#---------------------------------------------------------------------------
install-modern-bash-commands:
	# https://zaiste.net/posts/shell-commands-rust/
	@sudo apt install -y eza
	@sudo apt install -y bat
	@sudo ln -s /usr/bin/batcat ~/.local/bin/bat
	@sudo apt install fd-find
	@sudo ln -s /usr/bin/fdfind ~/.local/bin/fd
#---------------------------------------------------------------------------
install-fzf:
	@sudo apt install fzf
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
	@ln -sf ${MAKEFILE_DIR}/i3/config ~/.config/i3/config
	@ln -sf ${MAKEFILE_DIR}/i3/setup_screens_home_office.sh ~/setup_screens.sh
	@ln -sf ${MAKEFILE_DIR}/polybar/config ~/.config/polybar/config
	@ln -sf ${MAKEFILE_DIR}/polybar/launch.sh ~/.config/polybar/launch.sh
	@rm -rf ~/Templates && ln -sf ${MAKEFILE_DIR}/templates ~/Templates
#---------------------------------------------------------------------------
repair: reset-symlinks
	@sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim.basic 200
	@sudo update-alternatives --install /usr/bin/vim vim /usr/bin/vim.basic 200
	@sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim.basic 200
#---------------------------------------------------------------------------
install: install-symlinks
#---------------------------------------------------------------------------
