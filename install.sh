#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
homedir=~/
files="vimrc vim zshrc gitconfig"    # list of files/folders to symlink in homedir
OS=$(uname)

##########

# Ask the user if they have installed the dependencies
while true; do
    read -p "Have you installed the required dependencies, defined in the README? [y/n] " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "Please install the required dependencies, and run ./install.sh again"; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# If OS is Darwin, install vim with Python bindings from Brew and install Cmake
if [ $OS = "Darwin" ]; then
    echo "Identified system as $OS"
    echo "Checking for Homebrew"
    BREW_INSTALLED=$(brew -v | sed 's/\(Homebrew*\).*/\1/')
    if [[ "${BREW_INSTALLED}" = *"Homebrew"* ]]; then \
        echo -e "Homebrew is installed, will proceed with updating it\n"
        brew update
    else
        echo "Homebrew is missing, will proceed with the installation\n"
        ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    echo -e "\nInstalling Cmake with Homebrew\n"
    brew install cmake
    echo -e "\nInstalling vim with Python 2 through Homebrew\n"
    # brew vim —-with-python@2
    brew install vim
elif [ $OS = "Linux" ]; then
    echo "Identified system as $OS"
    echo -e "\nInstalling Cmake\n"
    sudo apt-get install build-essential cmake
    echo -e "\nInstalling the correct Python headers\n"
    sudo apt-get install python-dev python3-dev
fi

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
echo -e "\nNow source the moved zshrc by running 'source ~/.zshrc'"
echo -e "\nUsing vim, open ~/.vim/plugged/autoload/plug.vim and run the command :PlugInstall"
echo -e "\nThen, compile YCM with semantic support for C-family languages by running:\n"
echo -e "   cd ~/.vim/plugged/YouCompleteMe"
echo -e "   ./install.py --clang-completer\n"
