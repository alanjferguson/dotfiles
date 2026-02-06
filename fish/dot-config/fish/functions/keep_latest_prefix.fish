#!/usr/bin/env fish
# Usage:
#   source keep_latest_prefix.fish
#   keep_latest_prefix tio_serial-a
#   keep_latest_prefix tio_serial-b /path/to/logs

function keep_latest_prefix
    if test (count $argv) -lt 1
        echo "Usage: keep_latest_prefix <prefix> [directory]"
        echo "Example: keep_latest_prefix tio_serial-a /path/to/logs"
        return 1
    end

    set -l prefix $argv[1]
    set -l dir (set -q argv[2]; and echo $argv[2]; or echo '.')

    set -l files (ls -1 $dir/{$prefix}_*.log 2>/dev/null | sort)

    if test (count $files) -eq 0
        echo "No files found matching '{$prefix}_*.log' in '$dir'."
        return 1
    end

    if test (count $files) -eq 1
        echo "Only one file found — nothing to do:"
        echo "  $files[1]"
        return 0
    end

    set -l latest $files[-1]

    # --- Preview ---
    echo "Would keep:"
    echo "  $latest"
    echo
    echo "Would delete:"
    for file in $files[1..-2]
        echo "  $file"
    end
    echo

    # --- Confirm ---
    read -P "Proceed? [y/N] " -l confirm
    if not string match -qi 'y' -- $confirm
        echo "Aborted."
        return 0
    end

    # --- Delete ---
    for file in $files[1..-2]
        rm -- $file
        echo "Removed: $file"
    end

    echo
    echo "Done. Kept: $latest"
end
