#!/usr/bin/env bash
# Este script instala os aplicativos extras necessários para projetos de desenvolvimento.
source lib/functions.sh

LOG_FILE="/tmp/error.log"

failed_packages=()

packages=(
  nodejs
  python3-pip
  python3-venv
  conky-all
  playerctl
  chafa
  ffmpegthumbnailer
  zoxide
  libxcb1-dev
  libxcb-image0-dev
  libxcb-res0-dev
  libopencv-dev
)

install_pkg() {
  local pkg="$1"

  info "Instalando: $pkg"
  if ! sudo apt-get install -y "$pkg" 2>>"$LOG_FILE"; then
    failed_packages+=("$pkg")
    error "Falhou: $pkg (continuando...)"
    return 1
  fi
}

info "Atualizando lista de pacotes..."
sudo apt-get update -y 2>>"$LOG_FILE" || error "Falhou apt-get update (continuando...)"

info "Removendo libnode-dev para evitar conflitos..."
sudo apt-get remove -y libnode-dev 2>>"$LOG_FILE" || error "Erro ao remover libnode-dev (continuando...)"

info "Adicionando repositório de Nodejs..."
curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash - 2>>"$LOG_FILE" \
  || error "Erro ao adicionar repositório do NodeJs (continuando...)"

info "Atualizando lista de pacotes (após repositórios)..."
sudo apt-get update -y 2>>"$LOG_FILE" || error "Falhou apt-get update (continuando...)"

info "Instalando extras..."
for pkg in "${packages[@]}"; do
  install_pkg "$pkg" || true
done

info "Instalando a versão mais recente do NVIM..."
if wget -qO /tmp/nvim.appimage \
  https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage 2>>"$LOG_FILE"; then
  chmod u+x /tmp/nvim.appimage 2>>"$LOG_FILE" || true
  sudo install -m 0755 /tmp/nvim.appimage /usr/local/bin/nvim 2>>"$LOG_FILE" \
    || error "Erro ao instalar NVIM (continuando...)"
else
  error "Erro ao baixar NVIM (continuando...)"
fi

info "Instalando/atualizando o FZF..."
if [ -d "$HOME/.fzf" ]; then
  git -C "$HOME/.fzf" pull 2>>"$LOG_FILE" || error "Erro ao atualizar FZF (continuando...)"
else
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" 2>>"$LOG_FILE" \
    || error "Erro ao clonar FZF (continuando...)"
fi

if [ -x "$HOME/.fzf/install" ]; then
  "$HOME/.fzf/install" --key-bindings --completion --no-update-rc 2>>"$LOG_FILE" \
    || error "Erro ao instalar FZF (continuando...)"
fi

info "Instalando Rust + Yazi..."
if [ ! -x "$HOME/.cargo/bin/rustup" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 2>>"$LOG_FILE" \
    || error "Erro ao instalar Rust (continuando...)"
fi

export PATH="$HOME/.cargo/bin:$PATH"

# "$HOME/.cargo/bin/rustup" update 2>>"$LOG_FILE" || error "Erro ao atualizar Rust (continuando...)"
# cargo install --locked yazi-fm yazi-cli 2>>"$LOG_FILE" || error "Erro ao instalar Yazi (continuando...)"

if ((${#failed_packages[@]})); then
  error "Alguns pacotes falharam: ${failed_packages[*]}"
  error "Veja detalhes em: $LOG_FILE"
else
  info "Extras instalados com sucesso!"
fi