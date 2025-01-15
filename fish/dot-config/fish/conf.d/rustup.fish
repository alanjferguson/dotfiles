if test -d "$HOME/.cargo/bin"
  source "$HOME/.cargo/env.fish"
end

if type -q rustup
  rustup completions fish > ~/.config/fish/completions/rustup.fish
end
