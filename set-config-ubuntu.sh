#!/bin/bash
# Script para aplicar as configurações de aplicações não visuais no Ubuntu

info "Aplicando configurações do Gnome Shell..."
mkdir -p ~/.local/share/gnome-shell/extensions
cp -r ./configs/gnome-shell/extensions/* ~/.local/share/gnome-shell/extensions/

info "Configurações aplicadas com sucesso!"