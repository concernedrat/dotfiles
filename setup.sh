#!/bin/bash

# Set the GitHub repository URL for the master branch
REPO_URL="https://github.com/concernedrat/dotfiles/archive/refs/heads/master.zip"

# Setup TPM for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Create a temporary directory to download and extract the zip file
TEMP_DIR=$(mktemp -d)
curl -L "$REPO_URL" -o "$TEMP_DIR/dotfiles.zip"

# Unzip the repo into the temporary directory
unzip "$TEMP_DIR/dotfiles.zip" -d "$TEMP_DIR"

# Define the source directory (update this if the folder structure differs)
SOURCE_DIR="$TEMP_DIR/dotfiles-master"

# Copy files to ~/.config, backing up any existing files
for path in "$SOURCE_DIR"/*; do
    filename=$(basename "$path")
    target="$HOME/.config/$filename"

    # Check if the target file or directory already exists
    if [ -e "$target" ]; then
        echo "Backing up existing $filename to $filename.backup"
        mv "$target" "$target.backup"
    fi

    # Move the new file or directory into ~/.config
    mv "$path" "$target"
done

# Backup current ~/.zshrc and create a symlink to ~/.config/zsh/.zshrc
if [ -e "$HOME/.zshrc" ]; then
    echo "Backing up existing ~/.zshrc to ~/.zshrc.bak"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# Create a symlink from ~/.config/zsh/.zshrc to ~/.zshrc
ln -s "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"

# Install vim-plug for Neovim if it’s not already installed
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    echo "Installing vim-plug for Neovim..."
    curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Run PlugInstall to install all plugins specified in init.vim or init.lua
nvim --headless +PlugInstall +qall

# RUn LspInstall to install all language servers
nvim --headless +LspInstall +qall

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

echo "Dotfiles have been set up in ~/.config and ~/.zshrc is linked to ~/.config/zsh/.zshrc!"

