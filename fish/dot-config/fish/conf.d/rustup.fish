if test -d "$HOME/.cargo/bin"
  and test -x "$HOME/.cargo/env.fish"
  source "$HOME/.cargo/env.fish"
end

if type -q rustup
  rustup completions fish > ~/.config/fish/completions/rustup.fish
end
