# GIT ♥ FZF
# ---------

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gh() {
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

# -- ADD -----------------------------------------------------------------------

alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gau='git add --update'

# -- BRANCH --------------------------------------------------------------------

gcb() {
  git checkout -b "$1" 2> /dev/null || git checkout "$1"
}

gco() {
  result=$(git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf-down --ansi --multi --tac --preview-window right:70% \
      --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##')

  if [[ $result != "" ]]; then
    git checkout "$result"
  fi
}

# -- COMMIT --------------------------------------------------------------------

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcs='git commit -v -s'
alias gcs!'git commit -v -s --amend'

# -- CHERRY-PICK ---------------------------------------------------------------

alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# -- DIFF ----------------------------------------------------------------------

alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'

# -- REMOTE --------------------------------------------------------------------

gr() {
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

alias gra='git remote add'

# -- REBASE --------------------------------------------------------------------

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'

# -- RESET ---------------------------------------------------------------------

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

# -- STASH ---------------------------------------------------------------------

gstl() {
  local out sha q k
  while out=$(
    git stash list --pretty="%C(yellow)%h | %C(green)%cr %C(blue)%gs" |
    fzf-down --ansi --no-sort --query="$q" --print-query \
      --expect=ctrl-a,ctrl-b
  );
  do
    IFS=$'\n'; set -f
    res=($(<<< "$out"))
    unset IFS; set +f

    q="${res[0]}"
    k="${res[1]}"
    sha="${res[-1]}"
    sha="${sha%% *}"

    [[ -z "$sha" ]] && continue

    if [[ "$k" == 'ctrl-a' ]]; then
      git stash apply $sha
      break;
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git diff $sha
    fi
  done
}

alias gsts='git stash save'
alias gsta='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstp='git stash pop'
alias gsts='git stash show --text'

# -- TAG -----------------------------------------------------------------------

alias gts='git tag -s'
gtv() {
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}
