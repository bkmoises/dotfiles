#!/bin/bash

# Verifica se um parâmetro foi passado
if [ -z "$1" ]; then
  echo "Uso: $0 <nome_do_video>"
  exit 1
fi

# Define o diretório de busca
DIR="/home/moises/Downloads/Movies"

# Busca pelas subpastas que correspondem ao parâmetro
SUBDIR=$(find "$DIR" -mindepth 1 -maxdepth 1 -type d | grep -i "$1")

# Verifica se encontrou alguma subpasta
if [ -z "$SUBDIR" ]; then
  echo "Nenhuma subpasta encontrada com o nome: $1"
  exit 1
fi

# Busca pelos arquivos de vídeo dentro da subpasta encontrada
VIDEO=$(find "$SUBDIR" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" \))

# Verifica se encontrou algum vídeo
if [ -z "$VIDEO" ]; then
  echo "Nenhum vídeo encontrado na subpasta: $SUBDIR"
  exit 1
fi

# Inicializa o vídeo com o VLC
nohup vlc --fullscreen "$VIDEO" >> /tmp/alexa.log 2>&1 & 
