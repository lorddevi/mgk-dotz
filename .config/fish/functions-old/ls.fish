# Look for ls's cooler brother 'lsd' and default to it if found.

if type -qf lsd
    function ls
	command lsd \
	    -F \
	    --color=always \
	    --icon=always \
	    --date relative \
	    --size short \
	    $argv
    end
else if type -qf colorls
    function ls
	command colorls -FG $argv
    end
else
    function ls
	command ls -F $argv
    end
end

alias ll="ls -l"
alias la="ls -A"
alias lla="ls -lA"
