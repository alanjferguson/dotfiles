if [ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [ -d "$HOME/.cargo/bin/" ]; then
	export PATH="$HOME/.cargo/bin":$PATH
fi
