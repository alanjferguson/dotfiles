if not test -n "$SSH_CLIENT"
  and not test -n "$SSH_TTY"
  and test -S "$HOME/.bitwarden-ssh-agent.sock"
    set -x SSH_AUTH_SOCK "$HOME/.bitwarden-ssh-agent.sock"
end
