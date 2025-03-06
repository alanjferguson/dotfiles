# Function to set terminal tab title to current directory
function set_tab_title() {
  # Get the current directory, replacing $HOME with ~
  local directory=$(shrink-path -l -T)
  # Set the tab title
  echo -ne "\e]1;${directory}\a"
}

# Call this function before each prompt
precmd_functions+=(set_tab_title)
