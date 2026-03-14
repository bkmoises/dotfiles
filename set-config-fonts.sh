#!/usr/bin/env bash
# Este script baixa e instala fontes no diretório de fontes do usuário.
source lib/functions.sh

FONT_DIR="$HOME/.local/share/fonts"
TMP_DIR="$(mktemp -d)"
ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip"
ZIP_FILE="$TMP_DIR/FiraCode.zip"
EXTRACT_DIR="$TMP_DIR/FiraCode"

trap rm -rf "$TMP_DIR" EXIT

mkdir -p "$FONT_DIR"

wget -qO "$ZIP_FILE" "$ZIP_URL"
unzip -q "$ZIP_FILE" -d "$EXTRACT_DIR"

shopt -s nullglob
ttf_files=("$EXTRACT_DIR"/*.ttf)
shopt -u nullglob

if ((${#ttf_files[@]} == 0)); then
  error "Nenhum .ttf encontrado após extrair o zip."
  exit 1
fi

cp -f "${ttf_files[@]}" "$FONT_DIR/"

fc-cache -f "$FONT_DIR" >/dev/null 2>&1 || fc-cache -fv

info "Fonte instalada em: $FONT_DIR"