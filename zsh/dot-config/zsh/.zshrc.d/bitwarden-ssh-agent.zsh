if [[ -z "$SSH_CLIENT" && -z "$SSH_TTY" && -S "$HOME/.bitwarden-ssh-agent.sock" ]]; then
    export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
fi
