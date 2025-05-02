# Git Configuration

This directory contains Git configuration files that will be symlinked to the appropriate locations when using the bootstrap script.

## Configuration Structure

- `dot-config/git/config`: Main Git configuration (symlinked to `~/.config/git/config`)

## How Git Configuration Loading Works

Git loads configuration in the following order (later files override earlier ones):

1. System config (`/etc/gitconfig`)
2. XDG config (`~/.config/git/config`) - our main config is here
3. User config (`~/.gitconfig`) - use this for machine-specific overrides
4. Repository config (`some_repo/.git/config`) - use this for repository-specific settings

## Usage Recommendations

### Main Configuration

The main Git configuration is stored in `dot-config/git/config` and contains settings that should be consistent across all your machines:

- User identity
- Signing keys
- Default branch settings
- Aliases
- Common behaviors

### Machine-Specific Configuration

For machine-specific or user-specific settings, use `~/.gitconfig` directly (not tracked in this repo).
You can create this file manually on each machine as needed. Settings here will override those in the main config.

Examples of machine-specific settings:
- Different email address for work vs. personal
- Work-specific proxy settings
- Different SSH key paths

## Installation

Run the bootstrap script to symlink these configurations:

```bash
./bootstrap stow git
```