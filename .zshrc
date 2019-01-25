export TERM="xterm-256color"

# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_TITLE="true"
ZSH_THEME=""
plugins=(
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

zle -N edit-command-line
bindkey -v
bindkey -M vicmd v edit-command-line

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

  source $USER_ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
