# =============================================================================
# config.fish — Configuração do Fish Shell
# =============================================================================

# ---------------------------------------------------------------------------
# Sessão interativa — guards para não rodar em scripts não-interativos
# ---------------------------------------------------------------------------
if not status is-interactive
    exit
end

# ---------------------------------------------------------------------------
# Variáveis de ambiente
# ---------------------------------------------------------------------------
set -x EDITOR nvim
set -x SSH_AGENT_PID (ssh-agent -c)
set -x JAVA /usr/lib/jvm/java-17-openjdk-amd64
set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths
set -Ux ZED_ALLOW_EMULATED_GPU 1

# ---------------------------------------------------------------------------
# FZF
# ---------------------------------------------------------------------------
set -x FZF_CTRL_T_OPTS "
    --style full
    --walker-skip .git,node_modules,target,.env,.venv
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden)'"

# ---------------------------------------------------------------------------
# SSH Agent
# ---------------------------------------------------------------------------
# if not set -q SSH_AGENT_PID
#     eval (ssh-agent -s) | source
# end

# ---------------------------------------------------------------------------
# PATH
# ---------------------------------------------------------------------------
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.profile
fish_add_path $HOME/anaconda3/bin
fish_add_path $HOME/.local/bin/claude
fish_add_path $HOME/.local/bin/copilot
fish_add_path $JAVA
fish_add_path $JAVA_HOME/bin
fish_add_path /usr/bin/lua
fish_add_path /usr/bin/luarocks

# ---------------------------------------------------------------------------
# Funções
# ---------------------------------------------------------------------------

# Abre yazi e muda para o diretório selecionado ao sair
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Abre o explorador de arquivos no diretório atual
function gohere
    xdg-open .
end

# Inicializar serviço SSH
set -q SSH_AUTH_SOCK; or begin
    set agentInfo (ssh-agent -c)
    eval (echo $agentInfo | grep SSH_AUTH_SOCK)
    eval (echo $agentInfo | grep SSH_AGENT_PID)
    ssh-add ~/.ssh/id_rsa_glpg > /dev/null ^ /dev/null
end

# ---------------------------------------------------------------------------
# Aliases — gerais
# ---------------------------------------------------------------------------
alias cat bat
alias vi  nvim
alias cls clear
alias ai  aichat
alias py  python
alias ag  antigravity
alias ls 'eza --color=always --long --git --icons=always --no-time --no-user --no-filesize --no-permissions'

# ---------------------------------------------------------------------------
# Aliases — Windows (WSL)
# ---------------------------------------------------------------------------
alias ws    'cmd.exe /c start'
alias excel '/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/EXCEL.EXE'

# ---------------------------------------------------------------------------
# Aliases — macOS
# ---------------------------------------------------------------------------
# alias ag 'open -a Antigravity .'

# ---------------------------------------------------------------------------
# Inicialização de aplicativos
# ---------------------------------------------------------------------------
pyenv init - | source
pyenv init --path | source
zoxide init fish | source
starship init fish | source
fzf --fish | source

# ---------------------------------------------------------------------------
# Variáveis temporárias / Windows
# ---------------------------------------------------------------------------
set -x download /mnt/c/Users/MoisesAndrade/Downloads
