export TERM="xterm-256color"

autoload -U compinit && compinit
autoload -U bashcompinit && bashcompinit

zle -N edit-command-line
bindkey -v
bindkey -M vicmd v edit-command-line

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# Theme Prompt
PROMPT_THEME="$HOME/.config/zsh/themes"
if [ -d $PROMPT_THEME ]; then
  PURE_GIT_PULL=0
  fpath+=("$PROMPT_THEME")
  autoload -U promptinit && promptinit
  prompt pure
fi

# User Configuration
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

export EDITOR="nvim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

USER_ZSH_CONFIG="$HOME/.config/zsh"
USER_ZSH_PLUGIN="$USER_ZSH_CONFIG/plugins"
if [[ -d $USER_ZSH_CONFIG ]]; then
  for file in $USER_ZSH_CONFIG/*; do
    source $file
  done
fi
