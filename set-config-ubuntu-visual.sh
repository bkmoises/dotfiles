#!/bin/bash
# Script para aplicar as configurações de aplicações visuais no Ubuntu

info "Aplicando configurações do Alacritty..."
mkdir -p ~/.config/alacritty
cp -f ./configs/alacritty.yml ~/.config/alacritty/alacritty.yml

info "Aplicando configurações do Flameshot..."
mkdir -p ~/.config/flameshot
cp -f ./configs/flameshot.ini ~/.config/flameshot/flameshot.ini

info "Aplicando configurações do qBittorrent..."
mkdir -p ~/.config/qBittorrent
cp -f ./configs/qBittorrent/* ~/.config/qBittorrent/

info "Aplicando configurações do Conky..."
mkdir -p ~/.config/conky
cp -r ./configs/conky/* ~/.config/conky/

info "Aplicando configurações do Autostart..."
mkdir -p ~/.config/autostart
cp -r ./configs/conky-everforest.desktop ~/.config/autostart/conky-everforest.desktop

info "Movendo comandos do TriggerCMD..."
mkdir -p ~/.triggers
cp -r ./assets/triggers/* ~/.triggers/

info "Movendo script de controle do monitor..."
sudo cp -f ./assets/monitor-controller /usr/bin/monitor-controller

info "Aplicando Papel de Parede"
mkdir -p ~/Imagens/"Papéis de parede"
cp -r ./resources/images/* ~/Imagens/"Papéis de parede"/

info "Configurações aplicadas com sucesso!"