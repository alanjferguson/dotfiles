if [[ "$TERM_PROGRAM" = "vscode" ]]; then
    export EDITOR="code --wait"
    export VISUAL="code --wait"
elif command -v nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
    export VISUAL="nvim"
else
    echo "Could not set editor!"
fi
