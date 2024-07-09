# ~/.config/bash/login.bash
LOCATION="bash/login.bash"

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

# {{{ === Source Posix Common login.sh ===
_mordu "Sourcing Login Shell settings from ~/.config/posix-common/login.sh."
source "$HOME"/.config/posix-common/login.sh
LOCATION="bash/login.bash"
_mordu "Finished sourcing Login Shell settings from ~/.config/posix-common/login.sh."
# }}} === Source Posix Common login.sh ===
    
_mordu "Finished processing $LOCATION."
