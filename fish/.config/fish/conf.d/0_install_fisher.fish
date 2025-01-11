if status --is-interactive; and not type -q fisher
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
else
  # echo "fisher is already installed"
end
