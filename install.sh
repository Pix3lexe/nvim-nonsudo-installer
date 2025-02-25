#!/bin/bash

set -e

NVIM_VERSION="stable"
INSTALL_DIR="$HOME/.local/bin"
DOWNLOAD_DIR="$HOME/lib"
CONFIG_DIR="$HOME/.config"
TMP_DIR="$(mktemp -d)"

mkdir -p "$INSTALL_DIR"
mkdir -p "$DOWNLOAD_DIR"

curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"

tar -xzf nvim-linux-x86_64.tar.gz -C "$DOWNLOAD_DIR"
ln -s "$DOWNLOAD_DIR/nvim-linux-x86_64/bin/nvim" "$INSTALL_DIR"


if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$HOME/.bashrc"
    echo "Neovim installed. Restart your shell or run 'source ~/.bashrc' to use it."
else
    echo "Neovim installed successfully in $INSTALL_DIR."
fi

# get my config
mkdir -p "$CONFIG_DIR"
if [ -d "$CONFIG_DIR/nvim" ]; then
    rm -rf "$CONFIG_DIR/nvim"
fi

git clone https://github.com/Pix3lexe/dotfiles.git "$TMP_DIR/dotfiles"
mv "$TMP_DIR/dotfiles/nvim/.config/nvim" "$CONFIG_DIR"
rm -rf "$TMP_DIR/dotfiles"
echo "Neovim config successfully installed. Please run nvim to install all plugins"


# Download and install JetBrains Mono Nerd Font
FONT_ZIP="JetBrainsMono.zip"
curl -L -o "$TMP_DIR/$FONT_ZIP" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
unzip -o "$TMP_DIR/$FONT_ZIP" -d "$FONT_DIR"

# Refresh font cache
fc-cache -f -v

echo "JetBrains Mono Nerd Font installed successfully."

# Cleanup
rm -rf "$TMP_DIR" nvim-linux-x86_64.tar.gz
