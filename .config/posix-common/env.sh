#!/usr/bin/env sh
_location=".config/posix-common/env.sh"

# {{{ <mordu debug system>
_debug=y # Comment this out to disable debuging.

_blue="\e[34m"
_magenta="\e[35m"
_green="\e[92m"
_cyan="\e[36m"
_white="\e[97m"
_end_color="\e[0m"

# Mordu with location.
_mordu() {
	[ "$_debug" ] && echo -e "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Mordu with location and no new line.
_mordu_n() {
	[ "$_debug" ] && echo -en "${_blue}>>> ${_magenta}Mordu${_cyan}@${_green}${_location}${_cyan}:${_white} $*${_end_color}"
}

# Echo with new line to add completion messages to _mordu_n
_mordu_nl() {
	[ "$_debug" ] && echo -e "${_white}$*${_end_color}"
}

_mordu "Starting script."
# }}} </mordu debug system>

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
_location=".config/posix-common/env.sh"
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
_location=".config/posix-common/env.sh"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env.d/*.sh."
# }}} === Source Posix Common env.d/*.sh ===

_mordu "Finished script."
