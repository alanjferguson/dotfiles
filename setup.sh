#!/usr/bin/env bash

# Define ANSI colour codes
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m'  # No Colour

# Function to print a banner message
print_banner() {
    local message="$1"
    local border=$(printf '%*s' "${#message}" '' | tr ' ' '=')
    echo -e "\n${CYAN}${border}${NC}"
    echo -e "${YELLOW}${message}${NC}"
    echo -e "${CYAN}${border}${NC}\n"
}

# What directories should be installable by all users including the root user
base=(
  zsh
  starship
  nvim
  bin
  fish
)

# Folders that should, or only need to be installed for a local user
useronly=(
  git
  wezterm
  ssh
)

# Run the stow command for the passed in directory ($2) in location $1
stowit() {
  usr=$1
  app=$2
  echo -e "${BOLD}${YELLOW}Stowing ${app}${NC}"
  # -v verbose
  # --adopt so we can pull in existing changes
  # --dotfiles convert dot-foo to .foo
  # -R recursive
  # -t target
  stow -v --adopt --dotfiles -R -t "${usr}" "${app}"
  echo ""
}

print_banner "Stowing apps for user: $(whoami)"
print_banner "Stowing base apps"

# Install apps available to local users and root
for app in "${base[@]}"; do
  stowit "${HOME}" "$app"
done

# Install only user space folders (only if not root)
if [[ "$(whoami)" != "root" ]]; then
  print_banner "Stowing user only apps"
  for app in "${useronly[@]}"; do
    stowit "${HOME}" "$app"
  done
fi

print_banner "Stowing complete"
