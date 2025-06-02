if (($+commands[brew])); then
    eval $(brew shellenv)
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
