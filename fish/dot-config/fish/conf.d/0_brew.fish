set -l brew_path "/opt/homebrew/bin/brew"
if test -x $brew_path
    eval "$($brew_path shellenv)"
end
