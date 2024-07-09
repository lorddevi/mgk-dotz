# ~/.config/sh/login.sh
LOCATION="sh/login.sh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Sourcing Posix Common login.sh ===
_mordu "Sourcing Login Shell settings from ~/.config/posix-common/login.sh."
. "$HOME"/.config/posix-common/login.sh
LOCATION="sh/login.sh"
_mordu "Finished sourcing Login Shell settings from ~/.config/posix-common/login.sh."
# }}} === Sourcing Posix Common login.sh ===

_mordu "Finished processing $LOCATION."
