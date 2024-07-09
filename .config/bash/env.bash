# ~/.config/bash/env.bash
LOCATION="bash/env.bash"

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

# {{{ === Sanity Proof Interactive Env with BASH_ENV ===
# We need to set BASH_ENV, for *non-interactive* shells.
# (unlike $ENV, which is for interactive shells)
_mordu "Setting BASH_ENV to pass Env Vars to non-interactive shells we might start."
export BASH_ENV=~/.config/bash/env.bash
# }}} === Sanity Proof Interactive Env with BASH_ENV ===

# {{{ === Configure HISTFILE Home ===
_mordu "Configuring HISTFILE Home."
if [ ! -d "$HOME"/.local/share/bash/ ] ; then
	_mordu "Could not fine ~/.local/share/bash/.  Creating."
	mkdir -p "$HOME"/.local/share/bash
fi

HISTFILE="$HOME"/.local/share/bash/${HOST//\./_}_bash_history
export HISTFILE
# }}} === Configure HISTFILE Home ===

# {{{ === Source Posix-Common Env Vars ===
_mordu "Sourcing Env Vars from ~/.config/posix-common/env.sh."
source "$HOME"/.config/posix-common/env.sh
LOCATION="bash/env.bash"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env.sh."
# }}} === Source Posix-Common Env Vars ===

_mordu "Finished processing $LOCATION."
