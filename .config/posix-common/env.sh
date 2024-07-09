# ~/.config/posix-common/env.sh
LOCATION="posix-common/env.sh"

# {{{ === Script Debug Settings ===
#DEBUG=y # Comment this out to disable DEBUGing.
_mordu() {
	[ "$DEBUG" ] && echo ">>> Mordu@$LOCATION: $*"
}
_mordu "Beginning processing $LOCATION."
# }}} === Script Debug Settings ===

# {{{ === Set ENV Variable for Sanity Proofing Init ===
# We need to set $ENV so that if you use shell X as your login shell,
# and then start "sh" as a non-login interactive shell the startup scripts will
# correctly run.
_mordu "Protecting Interactive functionality by setting ENV."
ENV="$HOME"/.config/sh/interactive.sh
export ENV
# }}} === Set ENV Variable for Sanity Proofing Init ===

# {{{ === Configure UMASK ===
# 0022 is more common with its g+rw.  But 0077's strict o+rw only is good enough likely.
_mordu "Setting umask to g-rw from g+rw on new files."
umask 0077
# }}} === Configure UMASK ===

# {{{ === Source Posix Common env_local.sh ===
# env_local is a useful place to put high priority Env Vars that could be
# expected to be used in both interactive and non-interactive shells. (I think.
# lol)
_mordu "Sourcing Env Vars from ~/.config/posix-common/env_local.sh."
. "$HOME"/.config/posix-common/env_local.sh
LOCATION="posix-common/env.sh"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env_local.sh."
# }}} === Source Posix Common env_local.sh ===

# {{{ === Source Posix Common env.d/*.sh ===
_mordu "Sourcing Env Vars from ~/.config/posix-common/env.d/*.sh."
for env_file in "$HOME"/.config/posix-common/env.d/*.sh; do
	_mordu "Sourcing $env_file."
	# shellcheck source=/dev/null
	. "$env_file"
done
unset -v env_file
LOCATION="posix-common/env.sh"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env.d/*.sh."
# }}} === Source Posix Common env.d/*.sh ===

_mordu "Finished processing $LOCATION."
