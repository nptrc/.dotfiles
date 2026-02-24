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
"
export MANPAGER="nvim +Man!"
export MENUCONFIG_STYLE="monochrome"

eval "$(zoxide init bash)"

. "$HOME/.cargo/env"

vterm_printf() {
    if [ -n "$TMUX" ] \
        && { [ "${TERM%%-*}" = "tmux" ] \
            || [ "${TERM%%-*}" = "screen" ]; }; then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}
