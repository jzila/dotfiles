#!/usr/bin/env bash
DOTFILES="$HOME/repos/dotfiles"

ln -s $DOTFILES/.vim $HOME/.config/nvim
ln -s $DOTFILES/vimrc $HOME/.vimrc

# alacritty
mkdir -p ~/.config/alacritty
ln -s $DOTFILES/alacritty.yml ~/.config/alacritty

# tmux
ln -s $DOTFILES/tmux.conf ~/.tmux.conf
