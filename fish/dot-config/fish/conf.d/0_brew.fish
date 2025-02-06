# This script sets up brew for fish shell
# I've tried to do it for both linux and macos

# get right path for brew
switch (uname)
case Darwin
  if test -x "/usr/local/bin/brew"
    set brew_path "/usr/local/bin/brew"
  else if test -x "/opt/homebrew/bin/brew"
    set brew_path "/opt/homebrew/bin/brew"
  end
case Linux
  set brew_path "/home/linuxbrew/.linuxbrew/bin/brew"
end

# check brew executable exists
if not test -x $brew_path
  echo "brew not found"
  exit 1
end

# add brew to path
if not $brew_path shellenv | source
  echo "brew shellenv failed"
  exit 1
end

# set up compleitions
if test -d (brew --prefix)"/share/fish/completions"
  set -p fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
  set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end
