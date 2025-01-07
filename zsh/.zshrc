autoload -U compinit; compinit

autoload -U colors; colors
export CLICOLOR=1

alias la='ls -lah'
alias ll='ls -lh'

# Temp workaround to disable punycode deprecation logging to stderr
# https://github.com/bitwarden/clients/issues/6689
alias bw='NODE_OPTIONS="--no-deprecation" bw'

eval "$(starship init zsh)"
