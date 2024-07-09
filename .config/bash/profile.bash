# ~/.config/bash/profile.bash
LOCATION="bash/profile.bash"

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

# {{{ === Source env.bash ===
# 1. Ensure ~/.config/bash/env.bash gets run first
_mordu "Sourcing Env Vars from ~/.config/bash/env.bash."
source "$HOME"/.config/bash/env.bash
LOCATION="bash/profile.bash"
_mordu "Finished sourcing Env Vars from ~/.config/bash/env.bash."
# }}} === Source env.bash ===

# {{{ === Sanity Proof BASH_ENV. ===
# 2. Prevent BASH_ENV from being sourced later, since we need to use $BASH_ENV
# for non-login non-interactive shells.  We don't export it, as we may have a
# non-login non-interactive shell as a child.
_mordu "Sanity proofing BASH_ENV by setting it to nothing."
BASH_ENV=
# }}} === Sanity Proof BASH_ENV. ===

# {{{ === Source login.bash ===
_mordu "Sourcing Login Shell settings from ~/.config/bash/login.bash."
source "$HOME"/.config/bash/login.bash
LOCATION="bash/profile.bash"
_mordu "Finished sourcing Login Shell settings from ~/.config/bash/login.bash."
# }}} === Source login.bash ===

# {{{ === Source interactive.bash ===
# 4. Run ~/.config/etc/bash/interactive.bash if this is an interactive shell.
if [ "$PS1" ]; then
	_mordu "Sourcing Interactive Shell settings from ~/.config/bash/interactive.bash."
	source "$HOME"/.config/bash/interactive.bash
	LOCATION="bash/profile.bash"
	_mordu "Finished sourcing Interactive Shell settings from ~/.config/bash/interactive.bash."
fi
# }}} === Source interactive.bash ===

_mordu "Finished processing $LOCATION."
