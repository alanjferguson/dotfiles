eval "$(/opt/homebrew/bin/brew shellenv)"

fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path "~/bin/"

set -Ux EDITOR "nvim"
set -Ux VISUAL "nvim"

if status is-interactive
  # Configure prompt
  set -U tide_context_always_display true
end

