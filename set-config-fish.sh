#!/usr/bin/env bash
# Este script configura o shell fish, instalando Oh My Fish, Fisher e plugins relacionados.
source lib/functions.sh

fisher_plugins=(
  jethrokuan/z
  PatrickF1/fzf.fish
  rstacruz/fish-asdf
  gazorby/fish-abbreviation-tips
  jorgebucaran/autopair.fish
  nickeb96/puffer-fish
  patrickf1/colored_man_pages.fish
  ankitsumitg/docker-fish-completions
)

command -v fish >/dev/null 2>&1 || {
  error "fish não encontrado. Instale com: sudo apt-get install -y fish"
  exit 1
}

info "Instalando Oh My Fish..."
curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

info "Instalando Fisher..."
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

info "Atualizando OMF e instalando tema/plugin..."
fish -c "omf update"
fish -c "omf install mars"

info "Instalando plugins do Fisher..."
for plugin in "${fisher_plugins[@]}"; do
  fish -c "fisher install $plugin"
done

info "Aplicando configurações do fish..."
mkdir -p "$HOME/.config/fish"

SRC_CONFIG="configs/config.fish"
DST_CONFIG="$HOME/.config/fish/config.fish"

if [ -f "$SRC_CONFIG" ]; then
  ln -sf "$(realpath "$SRC_CONFIG")" "$DST_CONFIG"
  fish -c "source \"$DST_CONFIG\""
  info "Configuração aplicada: $DST_CONFIG"
else
  error "Arquivo não encontrado: $SRC_CONFIG"
fi

info "Definindo fish como shell padrão..."
FISH_PATH=$(which fish)
sudo chsh -s $FISH_PATH $USER

info "Configuração do fish concluída!"