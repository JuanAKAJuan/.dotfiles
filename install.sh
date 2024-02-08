#!/usr/bin/env zsh

echo "Setting up your computer..."

# Zsh
sudo rm -rf ~/.zshrc > /dev/null 2>&1
ln -s ~/.dotfiles/.zshrc ~/.zshrc
# ln -s ~/.dotfiles/.zprofile ~/.zprofile

# Git
sudo rm -rf ~/.gitconfig > /dev/null 2>&1
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# Neovim
sudo rm -rf ~/.config/nvim/lua/custom > /dev/null 2>&1
ln -s ~/.dotfiles/nvchad-config/custom ~/.config/nvim/lua/custom

# Tmux
sudo rm -rf ~/.config/tmux > /dev/null 2>&1
ln -s ~/.dotfiles/tmux ~/.config/tmux

# Scripts
sudo rm -rf /usr/local/bin/tmux-sessionizer.sh > /dev/null 2>&1
sudo ln -s ~/.dotfiles/scripts/tmux-sessionizer.sh /usr/local/bin/tmux-sessionizer.sh

# i3
# ln -s ~/.dotfiles/i3 ~/.config/i3
# ln -s ~/.dotfiles/i3status ~/.config/i3status

# X
# ln -s ~/.dotfiles/.Xresources ~/.Xresources

