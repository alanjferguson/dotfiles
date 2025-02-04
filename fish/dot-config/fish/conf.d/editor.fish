if test "$TERM_PROGRAM" = "vscode"
    set -gx EDITOR code --wait
    set -gx VISUAL code --wait
else if type -q nvim
    set -gx EDITOR nvim
    set -gx VISUAL nvim
else
    echo "Could not set editor!"
end