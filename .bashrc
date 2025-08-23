source $HOME/.bash_aliases

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL=ignoreboth

shopt -s histappend

export PS1="\e[0;32m\u@\h \e[0min \e[0;33m\w\e[0m\n$ "
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_OPTS="
    --bind 'ctrl-u:preview-up' \
    --bind 'ctrl-d:preview-down' \
    --ansi \
    --multi \
    --reverse \
    --no-scrollbar \
    --tabstop=2 \
"
export MANPAGER="nvim +Man!"

eval "$(zoxide init bash)"

. "$HOME/.cargo/env"
