#!/bin/bash
# =============================================================================
# set-config.sh — Configuração e atualização do sistema
# =============================================================================

set -euo pipefail

source "$(dirname "$0")/lib/functions.sh"

# ---------------------------------------------------------------------------
# Funções
# ---------------------------------------------------------------------------

limpar_log() {
    : > /tmp/error.log
}

atualizar_sistema() {
    info "Atualizando e fazendo upgrade do sistema..."
    sudo apt update -y       || error "Erro ao executar apt update"
    sudo apt upgrade -y      || error "Erro ao executar apt upgrade"
    sudo apt dist-upgrade -y || error "Erro ao executar apt dist-upgrade"
    sudo apt autoremove -y   || error "Erro ao executar apt autoremove"
    info "Sistema atualizado com sucesso."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
    limpar_log
    atualizar_sistema
}

main "$@"