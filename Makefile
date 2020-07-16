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
install-ls-cc:
	@sudo apt install ccls # alternatively build from sources: https://github.com/MaskRay/ccls
#---------------------------------------------------------------------------
install-ls-py:
	pip3 install python-language-server
#---------------------------------------------------------------------------
install-ls-tex:
	cargo install --git https://github.com/latex-lsp/texlab.git
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
install-file-listener:
	@sudo cp listener.py /bin/listener
	@sudo chmod +x /bin/listener
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
#---------------------------------------------------------------------------
repair: reset-symlinks
	@sudo update-alternatives --install /usr/bin/vi vi /usr/bin/vim.basic 200
	@sudo update-alternatives --install /usr/bin/vim vim /usr/bin/vim.basic 200
	@sudo update-alternatives --install /usr/bin/editor editor /usr/bin/vim.basic 200
#---------------------------------------------------------------------------
install: install-symlinks
#---------------------------------------------------------------------------
