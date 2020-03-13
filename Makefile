NY: reset-symlinks
#---------------------------------------------------------------------------
MAKEFILE_PATH := $(abspath $(lastword ${MAKEFILE_LIST}))
MAKEFILE_DIR := $(dir ${MAKEFILE_PATH})
#---------------------------------------------------------------------------
create-directories:
	@mkdir -p ~/.config
	@mkdir -p ~/.local
#---------------------------------------------------------------------------
reset-symlinks: create-directories
#	@sh -c "[ ! -L ~/.bashrc ] || rm ~/.bashrc;"
	@sh -c "[ ! -L ~/.config/nvim ] || rm -r ~/.config/nvim;"
	@sh -c "[ ! -L ~/.gitconfig ] || rm ~/.gitconfig;"
	@sh -c "[ ! -L ~/.vim ] || rm -r ~/.vim;"
	@sh -c "[ ! -L ~/.vimrc ] || rm ~/.vimrc;"
#---------------------------------------------------------------------------
install-symlinks: reset-symlinks
	# @ln -sf ${MAKEFILE_DIR}/shell/config.sh ~/.bashrc
	@ln -sf ${MAKEFILE_DIR}/git/gitconfig.conf ~/.gitconfig
	# @ln -sf ${MAKEFILE_DIR}/tmux ~/.tmux
	# @ln -sf ${MAKEFILE_DIR}/tmux/tmux.conf ~/.tmux.conf
	@ln -sf ${MAKEFILE_DIR}/vim ~/.config/nvim
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

