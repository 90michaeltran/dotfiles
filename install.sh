#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
homedir=~/
files="vimrc vim zshrc oh-my-zsh gitconfig"    # list of files/folders to symlink in homedir

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
