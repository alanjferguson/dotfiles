if command -v nvim > /dev/null; then
  cmd="nvim"
elif command -v vim > /dev/null; then
  cmd="vim"
fi

if [ -z $cmd ]; then
  echo "WARN: no preferred editor found!"
else
  export EDITOR=$cmd
  export VISUAL=$cmd
fi
