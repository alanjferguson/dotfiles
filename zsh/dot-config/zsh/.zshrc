#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#
#

[[ "$TERM" = "dumb" ]] && unsetopt zle && PS1='$ ' && return

# HACK: to get round the unterminated line character printing a % in emacs vterm
unsetopt PROMPT_SP

# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=${ZDOTDIR:-$HOME}/.zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)

# Set any zstyles you might use for configuration.
[[ ! -f ${ZDOTDIR:-$HOME}/.zstyles ]] || source ${ZDOTDIR:-$HOME}/.zstyles

# Clone antidote if necessary.
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Create an amazing Zsh config using antidote plugins.
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load

# Source anything in .zshrc.d.
for _rc in ${ZDOTDIR:-$HOME}/.zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

if (($+commands[starship])); then
  setopt LOCAL_OPTIONS NO_WARN_CREATE_GLOBAL
  eval "$(starship init zsh)"
fi

# HACK: to get round the unterminated line character printing a % in emacs vterm
setopt PROMPT_SP

# Display pfetch at start
greeting
