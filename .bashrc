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
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="
  --bind 'ctrl-d:preview-up' \
  --bind 'ctrl-f:preview-down' \
  --ansi \
  --multi \
  --reverse \
  --no-scrollbar \
  --tabstop=2 \
  --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
  --color=selected-bg:#494d64 \
"

eval "$(starship init bash)"
eval "$(zoxide init bash)"
