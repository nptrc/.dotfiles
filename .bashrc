source $HOME/.bash_aliases

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL=ignoreboth

shopt -s histappend

export PS1="\e[0;32m\u@\h \e[0min \e[0;33m\w\n\e[0m-> "
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="
    --bind 'ctrl-d:preview-up' \
    --bind 'ctrl-f:preview-down' \
    --ansi \
    --multi \
    --reverse \
    --no-scrollbar \
    --tabstop=2 \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
    --color=selected-bg:#45475a \
"
export MANPAGER="nvim +Man!"
export BAT_THEME="Catppuccin Mocha"
export MENUCONFIG_STYLE="monochrome"

eval "$(zoxide init bash)"

. "$HOME/.cargo/env"
