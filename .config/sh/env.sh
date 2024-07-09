# ~/.config/sh/env.sh
LOCATION="sh/env.sh"

# WARNING: this will not be run for non-login, non-env.shells.

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===
    
# {{{ === Source Posix Common env.sh ===
_mordu "Sourcing Env Vars from ~/.config/posix-common/env.sh."
# Run ~/.config/posix-common/env.sh, to get $ENV.
. "$HOME"/.config/posix-common/env.sh
LOCATION="sh/env.sh"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env.sh."
# }}} === Source Posix Common env.sh ===

_mordu "Finished processing $LOCATION."
