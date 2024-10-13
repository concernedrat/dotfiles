# Dotfiles

This repository contains my personal dotfiles, configured specifically for my development environment. Feel free to use them, but please note that they are tailored to my needs and may not suit other setups.

## Installation

To install these dotfiles, you can run the following command in your terminal:

```bash
curl -L https://raw.githubusercontent.com/concernedrat/dotfiles/master/setup.sh | sh
```

This command will download and execute the setup script, which will:

1. Download and copy the configuration files to `~/.config`.
2. Backup any existing files that conflict with these dotfiles by appending `.backup` to the original filename.
3. Create a symlink from `~/.config/zsh/.zshrc` to `~/.zshrc`, allowing `zsh` to use the version-controlled `.zshrc`.

**Note:** This script is meant to be run on Unix-like systems with `curl`, `unzip`, and `git` installed. Ensure you have these prerequisites installed before proceeding.

## Structure

The main configuration files in this repository include:

- **nvim**: Neovim configuration files. (do a PlugInstall and LSPIntall afterwards)
- **alacritty**: Alacritty terminal configuration.
- **tmux**: Tmux configuration files.
- **zsh**: Zsh configuration, including `.zshrc` symlinked to `~/.config/zsh/.zshrc`.

Each directory inside `~/.config` represents a separate application configuration that’s part of my development environment.

## Disclaimer

These dotfiles are customized for my personal needs and system setup. I am not responsible for any misconfigurations, file overwrites, or other issues that may arise from using this script or these configuration files. **Please review the script and backup any critical data** before running the installation.

### Warning

**This setup script will back up files that conflict with these configurations by renaming them with a `.backup` extension. However, it is still highly recommended that you manually back up your configurations before running this script.**

