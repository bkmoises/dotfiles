#!/bin/bash
# Esse script é usado para aplicar as configurações do Pop!_OS.
source assets/functions.sh

if dconf load / < configs/popos-setup.conf; then
  info "Configurações do Pop!_OS aplicadas com sucesso!"
else
  error "Ocorreu um erro ao aplicar as configurações do Pop!_OS."
fi