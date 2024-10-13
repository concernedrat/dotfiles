#!/bin/bash

# Set the GitHub repository URL for the master branch
REPO_URL="https://github.com/concernedrat/dotfiles/archive/refs/heads/master.zip"

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

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

echo "Dotfiles have been set up in ~/.config and ~/.zshrc is linked to ~/.config/zsh/.zshrc!"

