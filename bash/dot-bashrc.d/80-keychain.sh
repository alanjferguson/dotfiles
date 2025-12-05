if command -v keychain > /dev/null 2>&1; then
  eval $(keychain --eval --quiet $HOME/.ssh/id_ed25519)
else
  echo "keychain not installed"
fi
