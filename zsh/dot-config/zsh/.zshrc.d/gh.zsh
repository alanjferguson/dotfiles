if (( $+commands[gh] )); then
  source <(gh completion -s zsh)
else
  echo "gh not found"
fi
