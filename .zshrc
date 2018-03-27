export TERM="xterm-256color"

# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_TITLE="true"
POWERLEVEL9K_MODE='awesome-fontconfig'
ZSH_THEME="powerlevel9k/powerlevel9k"
plugins=(
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\e[1D"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❯ "
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_package_name"
POWERLEVEL9K_OS_ICON_BACKGROUND="blue"
POWERLEVEL9K_OS_ICON_FOREGROUND="black"

# User configuration

export EDITOR="nvim"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d ~/.config/zsh ]]; then
  for file in ~/.config/zsh/*; do
    source $file
  done
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 
