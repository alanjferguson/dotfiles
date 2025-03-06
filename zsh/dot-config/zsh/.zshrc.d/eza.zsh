# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# Copyright (c) 2022 Salvydas Lukosius

if [[ $TERM == 'dumb' ]]; then
  return 1
fi

builtin emulate -L zsh ${=${options[xtrace]:#off}:+-o xtrace}
builtin setopt extended_glob warn_create_global typeset_silent

if (( $+commands[eza] )); then
  typeset enable_autocd=0
  typeset -ag eza_params

  eza_params=(
    '--git'
    # '--icons'
    '--group' '--group-directories-first'
    '--time-style=long-iso' '--color-scale=all' '--color-scale-mode=fixed'
  )

  alias ls='eza $eza_params'
  alias l='eza --git-ignore $eza_params'
  alias ll='eza --all --header --long $eza_params'
  alias llm='eza --all --header --long --sort=modified $eza_params'
  alias la='eza -lbhHigUmuSa'
  alias lx='eza -lbhHigUmuSa@'
  alias lt='eza --tree $eza_params'
  alias tree='eza --tree $eza_params'
else
  print "eza not installed!" >&2
  return 1
fi

return 0
