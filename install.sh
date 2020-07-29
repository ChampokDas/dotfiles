#!/bin/bash

# This file gets some of the things that
# I need, various plugins and QOL stuff
# and includes some software that I use
# very often

# Exit on any error
set -e

# Setup our stuff
cd $HOME
mkdir local
mkdir tmp_files
MY_TMP_DIR_HOMIE=$HOME/tmp_files

# My favorite tool of all time, the legendary TMUX
# sorry screen
cd $MY_TMP_DIR_HOMIE
TMUX_VERSION=2.6
wget -O tmux-${TMUX_VERSION}.tar.gz http://sourceforge.net/projects/tmux/files/tmux/tmux-${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz/download
wget https://github.com/downloads/libevent/libevent/libevent-2.0.19-stable.tar.gz
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz

# Dependency 1/3 for TMUX, LIBEVENT
tar xvzf libevent-2.0.19-stable.tar.gz
cd libevent-2.0.19-stable
./configure --prefix=$HOME/local --disable-shared
make
make install
cd ..

# Dependency 2/3 for TMUX, NCURSES
tar xvzf ncurses-5.9.tar.gz
cd ncurses-5.9
./configure --prefix=$HOME/local
make
make install
cd ..

# Dependency 3/3 for TMUX, TMUX
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
cp tmux $HOME/local/bin
cd ..

# Some utils
cd $MY_TMP_DIR_HOMIE
wget http://prdownloads.sourceforge.net/tcl/tcl8.5.15-src.tar.gz
wget http://downloads.sourceforge.net/project/expect/Expect/5.45/expect5.45.tar.gz

tar xvzf tcl8.5.15-src.tar.gz
tar xvzf expect5.45.tar.gz

cd tcl8.5.15/unix
./configure --prefix=$HOME/local
make
make install

cd ../../expect5.45/
./configure --prefix=$HOME/local
make
make install

# Vim stuff
# Yes, I know, who even uses Vundle
# I do, stop looking at me like that
cd $HOME
git clone "https://github.com/VundleVim/Vundle.vim" "~/.vim"

# A legendary tool, this one is an absolute requirement
# everyone should have this along with many other LLVM tools
# You should also have Valgrind, you'd be stupid to not have it
# Harsh, yes, but necessary
# Also is the main reason why I'm installing it as sudo, because if
# I don't see it, I'm gonna go right up and complain about it
echo "Installing clang-format"
sudo apt install clang-format

cd $HOME
rm -rf $MY_TMP_DIR_HOMIE
