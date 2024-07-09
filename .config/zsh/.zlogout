# ~/.config/zsh/logout.zsh
LOCATION="zsh/logout.zsh"

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
_mordu "Sourcing logout actions from ~/.config/posix-common/logout.sh."
source "$HOME"/.config/posix-common/logout.sh
LOCATION="zsh/logout.zsh"
_mordu "Completed sourcing ~/.config/posix-common/logout.sh."
}
# }}} === Source Posix Common logout.sh ===

_mordu "Finished processing $LOCATION."
