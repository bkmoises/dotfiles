#!/bin/bash
# Esse script é usado para configurar o GitHub.
source assets/functions.sh

# Variáveis de configuração do GitHub
USERNAME="Moises Andrade"
EMAIL="bk_moises@hotmail.com"

# Configurando o Git
git config --global user.name "$USERNAME"
git config --global user.email "$EMAIL"

# Verificando a configuração
info "Configuração do GitHub:"
git config --global --list

# Gerando chave SSH para o GitHub
info "Gerando chave SSH para o GitHub..."
ssh-keygen -t ed25519 -C "$EMAIL" -f ~/.ssh/id_ed25519 -N ""
alert "Gerada em ~/.ssh/id_ed25519"

# Adicionando chave SSH ao ssh-agent
info "Adicionando chave SSH ao ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

alert "Teste sua conexão com o GitHub usando: ssh -T git@github.com"