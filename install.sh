#!/bin/bash

set -e

NVIM_VERSION="stable"
INSTALL_DIR="$HOME/.local/bin"
CONFIG_DIR="$HOME/.config/nvim"
TMP_DIR="$(mktemp -d)"

mkdir -p "$INSTALL_DIR"

curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"

tar -xzf nvim-linux64.tar.gz -C "$TMP_DIR"

mv "$TMP_DIR/nvim-linux64/bin/nvim" "$INSTALL_DIR/nvim"

rm -rf "$TMP_DIR" nvim-linux64.tar.gz

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.bashrc"
    echo "Neovim installed. Restart your shell or run 'source ~/.bashrc' to use it."
else
    echo "Neovim installed successfully in $INSTALL_DIR."
fi

# get my config
mkdir -p "$CONFIG_DIR"
git clone https://github.com/Pix3lexe/dotfiles.git "$TMP_DIR/dotfiles"
mv "$TMP_DIR/dotfiles/nvim/.config/nvim" "$CONFIG_DIR"
rm -rf "$TMP_DIR/dotfiles"
echo "Neovim config successfully installed. Please run nvim to install all plugins"

# cleanup
rm -rf "$TMP_DIR" nvim-linux64.tar.gz
