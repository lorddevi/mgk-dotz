# ~/.config/fish/prompt.fish
set LOCATION "fish/prompt.fish"

# {{{ === Script Debug Settings ===
#set -l DEBUG y # Comment this out to disable DEBUGing.
function _mordu
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $argv"
end

function _mordu_n
	[ "$DEBUG" ] && echo -n ">>> Mordu@$LOCATION: $argv"
end

function _mordu_nl
	[ "$DEBUG" ] && echo "$argv"
end
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Run Starfish Init ===
if type -qf starship
    _mordu "Starship found.  Setting as shell prompt."
    starship init fish | source
end
# }}} === Run Starfish Init ===

_mordu "Finished processing $LOCATION."
