# setup ls abbreviations
abbr -a ll ls -lh
abbr -a la ls -lah

# swap ls with eza if available
if type -q eza
  abbr -a ls eza
  abbr -a ll eza -lh
  abbr -a la eza -lah
  abbr -a tree eza -T
end
