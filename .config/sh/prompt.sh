# ~/.config/sh/prompt.sh
LOCATION="sh/prompt.sh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Setup Starship as Prompt (with fallback) ===
if command -v starship >/dev/null ; then
	_mordu "Starship found. Setting as shell prompt."
	STATUS=$?
	NUM_JOBS=$(jobs -p | wc -l)
	PS1="$(starship prompt --status="$STATUS" --jobs="$NUM_JOBS")"
else
	_mordu "Starship not found.  Falling back to plain prompt."
	# Basic plain prompt.
	HOST=$(uname -n)
	export HOST
	PS1='[$USER@$HOST:$PWD]\n(sh) $ '
	export PS1
fi
# }}} === Setup Starship as Prompt (with fallback) ===

_mordu "Finished processing $LOCATION."
