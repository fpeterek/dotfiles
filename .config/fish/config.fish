if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_config theme choose "ayu Mirage"

    abbr -a cp cp -i
    abbr -a ls lsd
    abbr -a cat bat

    function fish_greeting
        nerdfetch
    end
end
