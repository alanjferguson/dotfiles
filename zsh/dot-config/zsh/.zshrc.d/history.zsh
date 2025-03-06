#
# Requirements
#

# Ensure the data directory exists
_data_dir=${XDG_DATA_HOME:-$HOME/.local/share}/zsh
[[ -d "$_data_dir"  ]] || mkdir -p "$_data_dir"

_zhistfile=$_data_dir/${ZHISTFILE:-history}

#
# Options
#

setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing non-existent history.

#
# Variables
#

HISTFILE="$_zhistfile"
HISTSIZE=10000  # The maximum number of events to save in the internal history.
SAVEHIST=10000  # The maximum number of events to save in the history file.

unset _data_dir _zhistfile
