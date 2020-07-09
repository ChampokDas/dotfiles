#/bin/bash

# This file gets some of the things that
# I need, various plugins and QOL stuff
# and includes some software that I use
# very often

# Get Vundle, I know, who even uses Vundle
# for vim anymore, but I'm stupid and I like
# doing things the stupid way
echo "Installing Vundle"
git clone "https://github.com/VundleVim/Vundle.vim" "~/.vim"

echo "Installing clang-format"
sudo apt install clang-format

# More stuff coming soon
