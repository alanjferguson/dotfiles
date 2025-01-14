function fish_greeting
  if type -q pfetch
    PF_INFO="ascii title os host kernel uptime memory" pfetch
  end
end
