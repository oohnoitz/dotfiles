export TERM="xterm-256color"

# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_TITLE="true"
ZSH_THEME=""
plugins=(
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Theme Prompt
PROMPT_THEME="$HOME/.config/zsh/themes/pure"
PROMPT_SETUP_SRC="$PROMPT_THEME/pure.zsh"
PROMPT_SETUP_DST="$PROMPT_THEME/prompt_pure_setup"
PROMPT_ASYNC_SRC="$PROMPT_THEME/async.zsh"
PROMPT_ASYNC_DST="$PROMPT_THEME/async"

if [ -d $PROMPT_THEME ]; then
  if [ ! -f $PROMPT_SETUP_DST ]; then
    cp -v "$PROMPT_SETUP_SRC" "$PROMPT_SETUP_DST"
  fi
  if [ ! -f $PROMPT_ASYNC_DST ]; then
    cp -v "$PROMPT_ASYNC_SRC" "$PROMPT_ASYNC_DST"
  fi

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

  source $USER_ZSH_PLUGIN/zsh-autosuggestions/zsh-autosuggestions.zsh
  source $USER_ZSH_PLUGIN/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
