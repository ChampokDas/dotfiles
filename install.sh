#!/usr/bin/env bash

set -euxo pipefail

# This file gets some of the things that
# I need, various plugins and QOL stuff
# and includes some software that I use
# very often

# Setup our stuff
cd $HOME
mkdir -p local
mkdir -p tmp_files
MY_TMP_DIR_HOMIE=$HOME/tmp_files

# Fish stuff
FISH_VERSION="3.1.2"
cd $MY_TMP_DIR_HOMIE
wget https://github.com/fish-shell/fish-shell/releases/download/${FISH_VERSION}/fish-${FISH_VERSION}.tar.gz -O fish.tar.gz
mkdir -p fish
tar xvzf fish.tar.gz -C fish/ --strip-components=1
cd fish/
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/local ..
make -j 12
make install

# My favorite tool of all time, the legendary TMUX
# sorry screen
cd $MY_TMP_DIR_HOMIE
TMUX_VERSION=3.1b
wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz -O tmux.tar.gz
wget https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz -O libevent.tar.gz
wget https://invisible-mirror.net/archives/ncurses/ncurses-6.2.tar.gz -O ncurses.tar.gz

# Dependency 1/3 for TMUX, LIBEVENT
mkdir -p libevent
tar xvzf libevent.tar.gz -C libevent/ --strip-components=1
cd libevent/
./configure --prefix=$HOME/local --disable-shared
make -j 12
make install
cd ..

# Dependency 2/3 for TMUX, NCURSES
mkdir -p ncurses
tar xvzf ncurses.tar.gz -C ncurses/ --strip-components=1
cd ncurses/
./configure --prefix=$HOME/local
make -j 12
make install
cd ..

# Dependency 3/3 for TMUX, TMUX
mkdir -p tmux
tar xvzf tmux.tar.gz -C tmux/ --strip-components=1
cd tmux/
./configure --prefix=$HOME/local CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib"
make -j 12
make install
cd ..

# Vim stuff
# Yes, I know, who even uses Vundle
# I do, stop looking at me like that
cd $HOME
if [ ! -d "$HOME/.vim/" ]; then
  git clone "https://github.com/VundleVim/Vundle.vim" $HOME/.vim/
fi

cd $HOME
rm -rf $MY_TMP_DIR_HOMIE
