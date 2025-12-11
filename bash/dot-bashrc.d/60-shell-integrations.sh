if command -v bat > /dev/null 2>&1; then
  export BAT_THEME="Catppuccin Latte"
fi

if command -v fzf > /dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

if command -v starship > /dev/null 2>&1; then
  eval -- "$(starship init bash --print-full-init)"
fi

