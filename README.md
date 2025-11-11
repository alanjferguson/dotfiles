# Dotfiles

My personal dotfiles repository, managed with GNU Stow. This repository contains configuration files for various tools and applications I use daily.

## Prerequisites

- GNU Stow (install via package manager)
- Git
- Bash (for running the setup script)
- macOS or Linux system

## Installation and Management

The `bootstrap` script handles both initial setup and ongoing management of your dotfiles:

1. Clone this repository:

   ```bash
   git clone https://github.com/alanjferguson/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Initial setup and ongoing management:

   ```bash
   # Create symlinks for all configurations
   ./bootstrap stow

   # Remove all symlinks (useful for reverting changes)
   ./bootstrap unstow
   ```

The `./bootstrap` script uses GNU Stow to create and manage symlinks in your home directory. Each subdirectory in this repository is stowed relative to your home directory, and files with a `dot-` prefix (e.g., `dot-zshrc`) are automatically converted to their proper hidden file names (e.g., `.zshrc`).

## Repository Structure

The repository is organised into separate directories for each tool's configuration:

```text
.
├── bin/           # custom scripts and utilities
├── git/           # git configuration and aliases
├── nvim/          # neovim configuration
├── ssh/           # ssh configuration
├── wezterm/       # WezTerm terminal configuration
├── zed/           # Zed editor configuration
├── zsh/           # zsh shell configuration
└── bootstrap      # configuration management script
```

## Customisation

To customise your configurations:

1. Edit the relevant files in their respective directories
2. Run `./bootstrap stow` to apply changes if you have:
   - Added new files or directories
   - Renamed files or directories
   - Changed the structure of a configuration directory

   You don't need to run `./bootstrap stow` if you've only:
   - Modified existing file contents
   - Used directory folding (e.g., `~/.config/nvim` → `nvim/.config/nvim`)

## Contributing

Feel free to fork this repository and adapt it to your needs. If you find any issues or have suggestions, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.
