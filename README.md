# Dotfiles

My personal dotfiles repository, managed with GNU Stow. This repository contains configuration files for various tools and applications I use daily.

## Prerequisites

- GNU Stow (install via package manager)
- Git
- Bash (for running the setup script)

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

The script uses GNU Stow to:
- Create symlinks for all configuration files
- Handle both base and user-specific configurations
- Preserve existing configurations by adopting them into the repository
- Remove symlinks when needed

## Configuration Components

### Base Configurations (Available to all users)
- `zsh/` - Zsh shell configuration
- `nvim/` - Neovim configuration
- `bin/` - Custom scripts and utilities

### User-Specific Configurations
- `git/` - Git configuration and aliases
- `wezterm/` - WezTerm terminal configuration
- `ssh/` - SSH configuration
- `zed/` - Zed editor configuration

## Structure

```
.
├── bin/           # Custom scripts and utilities
├── bootstrap      # Configuration management script
├── git/           # Git configuration
├── nvim/          # Neovim configuration
├── ssh/           # SSH configuration
├── wezterm/       # WezTerm configuration
├── zed/           # Zed editor configuration
└── zsh/           # Zsh configuration
```

## Features

- **Modular Organization**: Each tool's configuration is isolated in its own directory
- **Easy Installation**: Single script setup with GNU Stow
- **Version Controlled**: All configurations are tracked in Git
- **Cross-Platform**: Works on macOS and Linux systems

## Customization

To customize any configuration:
1. Edit the relevant files in their respective directories
2. Run `./bootstrap` again to apply changes

## Contributing

Feel free to fork this repository and adapt it to your needs. If you find any issues or have suggestions, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details. 
