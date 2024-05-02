#!/usr/bin/env bash
DOTFILES="$HOME/repos/dotfiles"

# nvim & lvim
mkdir -p ~/.config/lvim || rm -rf ~/.config/lvim
ln -s $DOTFILES/.vim $HOME/.config/nvim
ln -s $DOTFILES/vimrc $HOME/.vimrc
ln -s $DOTFILES/lvim $HOME/.config/lvim

# alacritty & kitty
mkdir -p ~/.config/{alacritty,kitty}
ln -s $DOTFILES/alacritty.yml ~/.config/alacritty
ln -s $DOTFILES/kitty.conf ~/.config/kitty
ln -s $DOTFILES/kitty-current-theme.conf ~/.config/kitty/current-theme.conf

# tmux
ln -s $DOTFILES/tmux.conf ~/.tmux.conf
