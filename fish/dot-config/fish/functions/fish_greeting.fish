function fish_greeting
  if type -q pfetch
    PF_INFO='ascii os host kernel uptime cpu memory shell editor palette' pfetch
    echo -ne "\033[F" # used to hide extra space at end
  else
    echo "Welcome to fish, the friendly interactive shell"
  end
end
