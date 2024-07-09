# ~/.config/posix-common/profile.sh
LOCATION="posix-common/profile.sh"

# Sourced by 'sh', or bash in 'sh' compatability mode.
# WARNING: if you delete .bash_profile, this file becomes part of bash's startup
# sequence, which means this file suddenly has to cater for two different
# shells.

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
function _mordu {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Source env.sh ===
_mordu "Sourcing Env Vars from ~/.config/sh/env.sh."
. "$HOME"/.config/sh/env.sh
LOCATION="posix-common/profile.sh"
_mordu "Finished sourcing Env Vars from ~/.config/sh/env.sh."
# }}} === Source env.sh ===

# {{{ === Source login.sh ===
_mordu "Sourcing Login Shell settings from ~/.config/sh/login.sh."
. "$HOME"/.config/sh/login.sh
LOCATION="posix-common/profile.sh"
_mordu "Finished sourcing Login Shell settings from ~/.config/sh/login.sh."
# }}} === Source login.sh ===

_mordu "Finished processing $LOCATION."
