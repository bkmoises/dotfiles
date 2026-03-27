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
# set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64

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
# fish_add_path $HOME/.local/bin
# fish_add_path $HOME/.cargo/bin
# fish_add_path /usr/bin/lua
# fish_add_path /usr/bin/luarocks
# fish_add_path $JAVA_HOME/bin

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

# ---------------------------------------------------------------------------
# Aliases — gerais
# ---------------------------------------------------------------------------
alias vi  nvim
alias ai  aichat
alias py  python
alias cls clear
alias cat bat
alias ls  'eza --color=always --long --git --icons=always --no-time --no-user --no-filesize --no-permissions'

# ---------------------------------------------------------------------------
# Aliases — Windows (WSL)
# ---------------------------------------------------------------------------
# alias ws 'cmd.exe /c start'

# ---------------------------------------------------------------------------
# Aliases — macOS
# ---------------------------------------------------------------------------
alias ag 'open -a Antigravity .'

# ---------------------------------------------------------------------------
# Inicialização de aplicativos
# ---------------------------------------------------------------------------
starship init fish | source
zoxide init fish | source
fzf --fish | source

# ---------------------------------------------------------------------------
# Variáveis temporárias / projeto (descomente conforme necessário)
# ---------------------------------------------------------------------------
# set -x src         /home/moisesreis/Work/unimedfesp-datalake/src/unimedfesp_datalake_apps/pipelines/datalake/
# set -x ddl         /home/moisesreis/Work/unimedfesp-datalake/ddl/datalake/table/
# set -x bronze      /home/moisesreis/Work/unimedfesp-datalake/src/unimedfesp_datalake_apps/pipelines/datalake/staged
# set -x silver      /home/moisesreis/Work/unimedfesp-datalake/src/unimedfesp_datalake_apps/pipelines/datalake/curated/cur_progress_pub/
# set -x gold        /home/moisesreis/Work/unimedfesp-datalake/src/unimedfesp_datalake_apps/pipelines/datalake/trusted/tru_datalake_fesp_pub/
# set -x download    /mnt/c/Users/brandm10/Downloads
# set -x screenshots '/mnt/c/Users/brandm10/OneDrive - Ingram Micro/Pictures/Screenshots'