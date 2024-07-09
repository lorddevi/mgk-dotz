# ~/.config/bash/logout.bash
LOCATION="bash/logout.bash"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
function _mordu {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}

function _mordu_n {
	[ "$DEBUG" ] && echo -n ">>> Mordu@$LOCATION: $*"
}

function _mordu_nl {
	[ "$DEBUG" ] && echo "$*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Source Posix Common logout.sh ===
_mordu "Performing logout actions from ~/.config/posix-common/logout.sh."
source "$HOME"/.config/posix-common/logout.sh
LOCATION="bash/logout.bash"
_mordu "Finished sourcing ~/.config/posix-common/logout.sh."
# }}} === Source Posix Common logout.sh ===

# {{{ === Garbage Collection ===
# Remove any stale .bash_history files still sitting around the homedir.
if [ -f "$HOME"/.bash_history ] ; then
	_mordu "Found a stale ~/.bash_history file that shouldn't be there. Deleting it."
	rm "$HOME"/.bash_history
fi
# }}} === Garbage Collection ===

_mordu "Finished processing $LOCATION."
