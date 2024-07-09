# ~/.config/fish/config.fish
set LOCATION "fish/config.fish"

# Fish specific configuration file.  Generally speaking, try to
# prioritize POSIX compatability for any added functionality.  If
# possible, try to add any desired function, alias, or the like to
# ~/.config/posix-common/[..] where possible.

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

# {{{ === Primary Fish Configuration Section ===
set fish_greeting   # Disable fish greeting.

# Prepend hostname tocommand history file if possible

set -x fish_history (echo "$HOST"|sed 's/\./_/g')_fish
# }}} === Primary Fish Configuration Section ===

_mordu "Finished processing $LOCATION."
