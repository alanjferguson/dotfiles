if [ -S "$SSH_AUTH_SOCK" ]; then
  echo "Have SSH_AUTH_SOCK, skipping keychain"
elif command -v keychain > /dev/null 2>&1; then
  # Source existing keychain env if available (fast, won't hang)
  [ -f "$HOME/.keychain/$HOSTNAME-sh" ] && source "$HOME/.keychain/$HOSTNAME-sh"

  # Now check if agent is actually running with keys
  if [ -z "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
    echo "No SSH agent running. Run: eval \$(keychain --eval ~/.ssh/id_ed25519)"
  elif ! ssh-add -l &>/dev/null; then
    echo "SSH agent has no keys. Run: eval \$(keychain --eval ~/.ssh/id_ed25519)"
  fi
else
  echo "keychain not installed"
fi
