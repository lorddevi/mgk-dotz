# ~/.config/fish/logout.fish
set LOCATION "fish/logout.fish"

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

# {{{ === Sourcing Posix Common Logout ===
#_mordu "Sourcing POSIX logout from ~/.config/posix-common/logout.sh"
#replay "source ~/.config/posix-common/logout.sh"
#set -l LOCATION "fish/logout.fish"
#_mordu "Finished sourcing POSIX logout from ~/.config/posix-common/logout.sh"
# }}} === Sourcing Posix Common Logout ===

_mordu "Finished processing $LOCATION."
