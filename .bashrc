source $HOME/.bash_aliases

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL=ignoreboth

shopt -s histappend

export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fdfind --type f --strip-cwd-prefix --hidden --follow --exclude .git'
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
"

source "$HOME/.cargo/env"
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(fnm env --shell bash)"
