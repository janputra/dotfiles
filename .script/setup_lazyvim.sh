#!/usr/bin/env bash
# LazyVim setup for Arch / CachyOS
# Languages: C, C++, QML, Rust, Python
set -e

# Core: neovim + what LazyVim expects
sudo pacman -S --needed \
  neovim git lazygit ripgrep fd fzf curl unzip \
  gcc make tree-sitter-cli nodejs npm \
  wl-clipboard xclip \
  ttf-jetbrains-mono-nerd

# Languages
sudo pacman -S --needed \
  clang lldb cmake bear \
  rustup \
  python python-pip ruff \
  qt6-declarative qt6-languageserver

# Optional: STM32 / ARM embedded toolchain (uncomment if needed)
# sudo pacman -S --needed arm-none-eabi-gcc arm-none-eabi-newlib arm-none-eabi-gdb openocd

# Rust toolchain + rust-analyzer
rustup default stable
rustup component add rust-analyzer

# Back up any existing config, then install the starter
for d in ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim; do
  [ -e "$d" ] && mv "$d" "$d.bak.$(date +%s)"
done
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

echo "Done. Run: nvim"
echo "Then :LazyExtras -> enable lang.clangd, lang.cmake, lang.rust, lang.python, dap.core"
