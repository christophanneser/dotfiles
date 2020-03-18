NY: reset-symlinks
#---------------------------------------------------------------------------
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
#---------------------------------------------------------------------------
CCLS_VERSION := 3865a0944739fff23fdaa53ec287d315f4be6edb
CCLS_REPO_DIR := ~/.ccls/repo
CCLS_BUILD_DIR := ~/.ccls/build
CCLS_INSTALL_PREFIX := ~/.local
LLVM_PREFIX_PATH := /usr/lib/llvm-9/lib/cmake
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
install-ls-cc:
	rm -rf $(CCLS_REPO_DIR) $(CCLS_BUILD_DIR)
	git clone --recursive https://github.com/MaskRay/ccls $(CCLS_REPO_DIR)
	cd $(CCLS_REPO_DIR) && git checkout $(CCLS_VERSION)
	cd $(CCLS_REPO_DIR) && git submodule update --init --recursive
	mkdir -p $(CCLS_BUILD_DIR) $(CCLS_INSTALL_PREFIX)
	cd $(CCLS_BUILD_DIR) && cmake \
		-DCMAKE_BUILD_TYPE=Release \
		-DCMAKE_PREFIX_PATH=$(LLVM_PREFIX_PATH) \
		-DCMAKE_INSTALL_PREFIX=$(CCLS_INSTALL_PREFIX) \
		$(CCLS_REPO_DIR)
	cd $(CCLS_BUILD_DIR) && make -j 32
	cd $(CCLS_BUILD_DIR) && make install
#---------------------------------------------------------------------------
install-ls-py:
	pip3 install python-language-server
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

