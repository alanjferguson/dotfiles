(( $+commands[lesspipe.sh] )) || return 1
export LESSOPEN="|lesspipe.sh %s"
export LESS_ADVANCED_PREPROCESSOR=1D
