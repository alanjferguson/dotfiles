if status is-interactive
    if type -q keychain
        if type -q fish_greeting
            functions --copy fish_greeting fish_greeting_keychain_cpy
            function fish_greeting
                fish_greeting_keychain_cpy $argv
                keychain --eval ~/.ssh/id_ed25519 | source
            end
        else
            function fish_greeting
                keychain --eval ~/.ssh/id_ed25519 | source
            end
        end
    end
end
