source $HOME/.bash_aliases

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s autocd

stty -ixon

export PS1="\e[0;32m\u@\h \e[0min \e[0;33m\w\e[0m\n$ "
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="
    --bind "ctrl-u:preview-up" \
    --bind "ctrl-d:preview-down" \
    --ansi \
    --multi \
    --reverse \
    --no-scrollbar \
    --tabstop=2 \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4
"
export MANPAGER="nvim +Man!"
export MENUCONFIG_STYLE="monochrome"

eval "$(zoxide init bash)"

. "$HOME/.cargo/env"
