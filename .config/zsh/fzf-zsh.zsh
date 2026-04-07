nuke() {
  local pid
  pid=$(ps -ef | grep -v ^root | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

cdw() {
  local dir
  dir=$(ls -D ~/src/work | fzf)

  if [[ $dir ]]; then
    cd ~/src/work/$dir
  fi
}

cdp() {
  local dir
  dir=$(ls -D ~/src/personal | fzf)

  if [[ $dir ]]; then
    cd ~/src/personal/$dir
  fi
}
