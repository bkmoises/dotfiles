#!/usr/bin/env bash
# Este script é responsável por executar os scripts de instalação pós-configuração
source lib/functions.sh

set -euo pipefail

SYSTEM="${1:-}"

if [ -z "$SYSTEM" ]; then
  echo "Uso: $0 <wsl|popos>" >&2
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$ROOT_DIR"

run_script() {
  local script="$1"
  local path="$SCRIPTS_DIR/$script"

  if [ ! -f "$path" ]; then
    info "ERRO: script não encontrado: $path" >&2
    exit 1
  fi

  info "==> Executando: $script"
  bash "$path"
}

# Liste aqui a ordem de execução por sistema
case "$SYSTEM" in
  popos)
    steps=(
      "install-extras.sh"
      "install-oh-my-fish.sh"
      "install-lazyvim.sh"
      "install-firacode-font.sh"
    )
    ;;

  wsl)
    steps=(
      "set-config.sh"
      "get-apps-basic.sh"
      "get-apps-extra.sh"
      "get-apps-lazyvim.sh"
      "set-config-github.sh"
      "set-config-fish.sh"
      "set-config-fonts.sh"
      "set-config-ubuntu.sh"
    )
    ;;

  *)
    info "ERRO: sistema inválido: '$SYSTEM'. Use: wsl ou popos" >&2
    exit 1
    ;;
esac

info "Sistema selecionado: $SYSTEM"
info "Diretório de scripts: $SCRIPTS_DIR"

for step in "${steps[@]}"; do
  run_script "$step"
done

info "Concluído: instalação para '$SYSTEM' finalizada com sucesso."