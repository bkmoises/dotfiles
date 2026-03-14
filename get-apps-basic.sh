#!/bin/bash
# Esse script é usado para instalar os aplicativos básicos do sistema.
source lib/functions.sh

LOG_FILE="/tmp/error.log"

packages=(
  build-essential
  cargo
  npm
  python3
  python3-pip
  curl
  make
  neovim
  ssh
  tig
  tmux
  tree
  unrar
  unzip
  wget
  bpytop
  diodon
  fzf
  fish
  bat
  eza
  snapd
  unar
  jq
  ripgrep
  fd-find
  xclip
  gnome-shell-extensions
  cmake
  git
)

failed_packages=()

for pkg in "${packages[@]}"; do
  info "Instalando: ${pkg}"
  if ! sudo apt install -y "$pkg" 2>>"$LOG_FILE"; then
    failed_packages+=("$pkg")
    error "Falhou: ${pkg} (continuando...)"
  fi
done

if ((${#failed_packages[@]})); then
  error "Alguns pacotes falharam e foram ignorados: ${failed_packages[*]}"
  error "Veja detalhes em $LOG_FILE"
else
  info "Todos os pacotes foram instalados com sucesso!"
fi