if status is-interactive
  if type -q keychain
      keychain --eval ~/.ssh/id_ed25519 | source
  end
end
