# ~/.config/bash/prompt.bash
LOCATION="bash/prompt.bash"

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

# {{{ === Configure Starship (with fallback) ===
# Check if starship prompt is available and use it if it is.
if command -v starship >/dev/null ; then
	_mordu "Starship found.  Setting as shell prompt."
	eval "$(starship init bash)"
else
	_mordu "Starship not found.  Falling back to plain prompt."
	# Basic plain prompt.
	HOST=$(uname -n)
	export HOST
	PS1='[$USER@$HOST:$PWD]\n(bash) $ '
	export PS1
fi
# }}} === Configure Starship (with fallback) ===

_mordu "Finished processing $LOCATION."
