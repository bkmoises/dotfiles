#!/bin/bash
# Esse script é usado para configurar o sistema.
source lib/functions.sh

# Zerando o arquivo de log de erros
: > /tmp/error.log

# Atualização e upgrade do sistema
info "Atualizando e fazendo upgrade do sistema..."
sudo apt update -y || error "Erro ao executar apt update"
sudo apt upgrade -y || error "Erro ao executar apt upgrade"
sudo apt dist-upgrade -y || error "Erro ao executar apt dist-upgrade"
sudo apt autoremove -y || error "Erro ao executar apt autoremove"