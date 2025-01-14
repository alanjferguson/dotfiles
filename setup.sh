#!/usr/bin/env bash

# what directories should be installable by all users including the root user
base=(
  bash
  zsh
  starship
  nvim
  bin
  fish
)

# folders that should, or only need to be installed for a local user
useronly=(
  git
  wezterm
  ssh
)

# run the stow command for the passed in directory ($2) in location $1
stowit() {
  usr=$1
  app=$2
  # -v verbose
  # --adopt so we can pull in existing changes
  # --dotfiles convert dot-foo to .foo
  # -R recursive
  # -t target
  echo "#### Stowing ${app}"
  stow -v --adopt --dotfiles -R -t "${usr}" "${app}"
  echo ""
}

echo ""
echo "#### Stowing apps for user: $(whoami)"

# install apps available to local users and root
for app in "${base[@]}"; do
  stowit "${HOME}" "$app"
done

# install only user space folders
for app in "${useronly[@]}"; do
  if [[ ! "$(whoami)" = *"root"* ]]; then
    stowit "${HOME}" "$app"
  fi
done

echo "##### ALL DONE"
