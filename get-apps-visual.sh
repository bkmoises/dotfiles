#!/bin/bash
# Esse script é usado para instalar os aplicativos visuais do sistema.
source lib/functions.sh

LOG_FILE="/tmp/error.log"

packages=(
  alacritty
  discord
  flameshot
  qbittorrent
  vlc
  gnome-tweaks
)

failed_packages=()

for pkg in "${packages[@]}"; do
  info "Instalando: ${pkg}"
  if ! sudo apt install -y "$pkg" 2>>"$LOG_FILE"; then
    failed_packages+=("$pkg")
    error "Falhou: ${pkg} (continuando...)"
  fi
done

info "Instalando Spotify"
if ! sudo snap install spotify 2>>"$LOG_FILE"; then
  failed_packages+=("spotify")
  error "Falhou: spotify (continuando...)"
fi

if ((${#failed_packages[@]})); then
  error "Alguns pacotes falharam e foram ignorados: ${failed_packages[*]}"
  error "Veja detalhes em $LOG_FILE"
else
  info "Todos os pacotes foram instalados com sucesso!"
fi