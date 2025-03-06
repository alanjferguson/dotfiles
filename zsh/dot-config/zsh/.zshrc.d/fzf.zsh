if (( $+commands[fzf] )); then
  source <(fzf --zsh)
else
  echo "fzf not found"
fi
