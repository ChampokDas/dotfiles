all: install-bash install-tcsh install-fish install-zsh \
     install-ctags install-clang install-tmux install-screen install-gdb \
     install-colors install-vim install-docker install-python install-other

install-bash:
	ln -fs `pwd`/bash/bashrc ~/.bashrc
	ln -fs `pwd`/bash/bash_profile ~/.bash_profile
	ln -fs `pwd`/bash/bash_aliases ~/.bash_aliases
	ln -fs `pwd`/bash/inputrc ~/.inputrc

install-tcsh:
	ln -fs `pwd`/tcsh/tcshrc ~/.tcshrc
	ln -fs `pwd`/tcsh/cshrc ~/.cshrc

install-fish:
	@echo "Nothing here for now since fish isn't used all that much"

install-zsh:
	ln -fs `pwd`/zsh/zshrc ~/.zshrc

install-ctags:
	ln -fs `pwd`/ctags/ctags ~/.ctags

install-clang:
	ln -fs `pwd`/clang/clang-format ~/.clang-format

install-tmux:
	ln -fs `pwd`/tmux/tmux.conf ~/.tmux.conf

install-screen:
	ln -fs `pwd`/screen/screenrc ~/.screenrc

install-gdb:
	ln -fs `pwd`/gdb/gdbinit ~/.gdbinit

install-colors:
	ln -fs `pwd`/colors/dir_colors ~/.dir_colors

install-vim:
	ln -fs `pwd`/vim/vimrc ~/.vimrc

install-python:
	ln -fs `pwd`/python/pythonrc.py ~/.pythonrc.py

install-other:
	ln -fs `pwd`/other/profile ~/.profile

install-docker:
	ln -fs `pwd`/docker ~/.docker


