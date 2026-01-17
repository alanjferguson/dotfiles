if status is-interactive
    # # Detect terminal background color using OSC11 and set light/dark mode
    # function __detect_terminal_theme
    #     # Save terminal settings and set raw mode for reading response
    #     set -l old_stty (stty -g 2>/dev/null)
    #
    #     # Query terminal background color with OSC11
    #     # Format: ESC ] 11 ; ? BEL
    #     printf '\e]11;?\a'
    #
    #     # Read response with timeout (format: ESC ] 11 ; rgb:RRRR/GGGG/BBBB ESC \)
    #     set -l response ""
    #     stty raw -echo 2>/dev/null
    #     set response (dd bs=1 count=50 2>/dev/null | string collect)
    #     stty $old_stty 2>/dev/null
    #
    #     # Parse RGB values from response
    #     # Response format: ^[]11;rgb:RRRR/GGGG/BBBB^[\
    #     if string match -qr 'rgb:([0-9a-fA-F]+)/([0-9a-fA-F]+)/([0-9a-fA-F]+)' -- $response
    #         set -l rgb (string match -r 'rgb:([0-9a-fA-F]+)/([0-9a-fA-F]+)/([0-9a-fA-F]+)' -- $response)
    #
    #         # Convert hex to decimal (take first 2 chars if 4-digit hex)
    #         set -l r (string sub -l 2 -- $rgb[2])
    #         set -l g (string sub -l 2 -- $rgb[3])
    #         set -l b (string sub -l 2 -- $rgb[4])
    #
    #         set r (printf '%d' 0x$r)
    #         set g (printf '%d' 0x$g)
    #         set b (printf '%d' 0x$b)
    #
    #         # Calculate relative luminance using sRGB formula
    #         # L = 0.2126*R + 0.7152*G + 0.0722*B
    #         set -l luminance (math "0.2126 * $r + 0.7152 * $g + 0.0722 * $b")
    #
    #         # Threshold at 128 (middle of 0-255 range)
    #         if test (math "$luminance > 128") -eq 1
    #             echo light
    #         else
    #             echo dark
    #         end
    #     else
    #         # Default to dark if detection fails
    #         echo dark
    #     end
    # end
    #
    # # Detect and set theme
    # set -l detected_theme (__detect_terminal_theme)
    # set -gx TERM_THEME $detected_theme
    #
    # # Apply appropriate theme
    # if test "$detected_theme" = light
    #     # Light theme settings
    #     set -gx TERM_BACKGROUND light
    #     # Add your light theme commands here, e.g.:
    #     # fish_config theme choose "Catppuccin Latte"
    # else
    #     # Dark theme settings
    #     set -gx TERM_BACKGROUND dark
    #     # Add your dark theme commands here, e.g.:
    #     # fish_config theme choose "Catppuccin Mocha"
    # end
    #
    # # Clean up the detection function
    # functions -e __detect_terminal_theme
end
