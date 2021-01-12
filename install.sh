#!/usr/bin/env bash

# This file gets some of the things that
# I need, various plugins and QOL stuff
# and includes some software that I use
# very often
set -eu
FISH_VERSION="3.1.2"
TMUX_VERSION="3.1b"
LIBEVENT_VERSION="2.1.12-stable"
NCURSES_VERSION="6.2"
NCURSES_LONG_VERSION="6.2.20200212"
HTOP_VERSION="3.0.2"

# Setup our stuff
cd $HOME
mkdir -p local
mkdir -p tmp_files
MY_TMP_DIR_HOMIE=$HOME/tmp_files

install_fish() {
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
  cd $MY_TMP_DIR_HOMIE
}

install_ncurses_and_libevent() {
  cd $MY_TMP_DIR_HOMIE
  wget https://github.com/libevent/libevent/releases/download/release-${LIBEVENT_VERSION}/libevent-${LIBEVENT_VERSION}.tar.gz -O libevent.tar.gz
  wget https://invisible-mirror.net/archives/ncurses/ncurses-${NCURSES_VERSION}.tar.gz -O ncurses.tar.gz

  mkdir -p libevent
  tar xvzf libevent.tar.gz -C libevent/ --strip-components=1
  cd libevent/
  ./configure --prefix=$HOME/local --disable-shared
  make -j 12
  make install
  cd $MY_TMP_DIR_HOMIE

  mkdir -p ncurses
  tar xvzf ncurses.tar.gz -C ncurses/ --strip-components=1
  cd ncurses/
  ./configure --prefix=$HOME/local
  make -j 12
  make install
  cd $MY_TMP_DIR_HOMIE
}

install_tmux() {
  cd $MY_TMP_DIR_HOMIE
  wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz -O tmux.tar.gz
  # Dependency 1/3 for TMUX, libevent
  # Dependency 2/3 for TMUX, ncurses
  install_ncurses_and_libevent

  # Dependency 3/3 for TMUX, TMUX
  mkdir -p tmux
  tar xvzf tmux.tar.gz -C tmux/ --strip-components=1
  cd tmux/
  ./configure --prefix=$HOME/local CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include" \
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib"
  make -j 12
  make install
}

install_htop() {
  cd $MY_TMP_DIR_HOMIE
  #wget https://github.com/htop-dev/htop/archive/${HTOP_VERSION}.tar.gz -O htop.tar.gz
  wget https://bintray.com/htop/source/download_file?file_path=htop-${HTOP_VERSION}.tar.gz -O htop.tar.gz
  # Dependency 1/2 for HTOP, libncursesw6
  if ! [ -x "$(command -v ncurses6-config)" ]; then
    install_ncurses_and_libevent
  elif [ "`ncurses6-config --version`" != "${NCURSES_LONG_VERSION}" ]; then
    install_ncurses_and_libevent
  fi

  # Dependency 2/2 for HTOP, HTOP
  mkdir -p htop
  tar xvzf htop.tar.gz -C htop/ --strip-components=1
  cd htop/
  ./configure --prefix=$HOME/local CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include" \
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib"
  make -j 12
  make install
}

if ! [ -x "$(command -v fish)" ]; then
  echo "Installing Fish Shell!"
  install_fish
else
  echo "Fish Shell is already installed at: `which fish`"
fi


if ! [ -x "$(command -v tmux)" ]; then
  echo "Installing tmux!"
  install_tmux
elif [ "`tmux -V`" != "tmux ${TMUX_VERSION}" ]; then
  echo "tmux exists, installing newer version!"
  install_tmux
else
  echo "tmux already installed at: `which tmux`"
fi

if ! [ -x "$(command -v htop)" ]; then
  echo "Installing htop!"
  install_htop
else
  echo "htop is already installed at: `which htop`"
fi

# Vim stuff
# Yes, I know, who even uses Vundle
# I do, stop looking at me like that
cd $HOME
if [ ! -d "$HOME/.vim/" ]; then
  git clone "https://github.com/VundleVim/Vundle.vim" $HOME/.vim/
fi

cd $HOME
rm -rf $MY_TMP_DIR_HOMIE
