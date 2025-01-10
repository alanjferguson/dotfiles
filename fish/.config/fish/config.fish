eval "$(/opt/homebrew/bin/brew shellenv)"

fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path "~/bin/"

if status is-interactive
  # Commands to run in interactive sessions can go here
  starship init fish | source
end

