#!/bin/bash
# Esse script é usado para instalar o LazyVim e suas dependências.
source lib/functions.sh

LOG_FILE="/tmp/error.log"
NVIM_DIR="$HOME/.config/nvim"
REPO_STARTER="https://github.com/LazyVim/starter"

failed_packages=()
packages=(
    php 
    php-cli
    ruby 
    ruby-full
    julia
    golang
    liblua5.1-0-dev
    xclip
    luarocks
    yarn
)

info "Instalando o LazyVim..."
git clone "$REPO_STARTER" "$NVIM_DIR"
rm -rf "$NVIM_DIR/.git"

info "Aplicando configurações pessoais ao LazyVim"
rm -rf "$NVIM_DIR/lua/config" "$NVIM_DIR/lua/plugins"
cp -rf configs/nvim/* "$NVIM_DIR/lua/"

info "Instalando dependências via apt..."
sudo apt-get update -y

for pkg in "${packages[@]}"; do
  info "Instalando: ${pkg}"
  if ! sudo apt-get install -y "$pkg" 2>>"$LOG_FILE"; then
    failed_packages+=("$pkg")
    error "Falhou: ${pkg} (continuando...)"
  fi
done

info "Instalando dependências via npm..."
sudo npm install -g \
  tree-sitter-cli \
  yarn \
  neovim \
  markdown-toc \
  markdownlint-cli2 \
  prettier

info "Instalando dependências via pip..."
pip3 install --user -U pynvim black sqlfluff hererocks

info "Instalando dependências via hererocks..."
"$HOME/.local/bin/hererocks" "$HOME/.local/share/nvim/lazy-rocks" --lua=5.1 -r latest

info "Instalando dependências via gem..."
sudo gem install neovim

info "Instalando dependências via luarocks..."
sudo luarocks install jsregexp

info "Instalando dependências via cargo..."
cargo install viu

info "Instalando Lazygit..."
LAZYGIT_VERSION="$(
  curl -fsSL "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
    | grep -Po '"tag_name": "v\K[^"]*'
)"
curl -fsSL -o /tmp/lazygit.tar.gz \
  "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -C /tmp -xf /tmp/lazygit.tar.gz lazygit
sudo install /tmp/lazygit /usr/local/bin/lazygit

info "Instalando composer..."
curl -fsSL https://getcomposer.org/installer -o /tmp/composer-setup.php
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

info "Instalando composer"
curl -sS https://getcomposer.org/installer -o composer-setup.php
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

info "LazyVim e dependências instalados com sucesso!"