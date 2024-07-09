#!/usr/bin/env sh
_location=".config/sh/env.sh"

# WARNING: this will not be run for non-login, non-env.shells.

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
    
# {{{ === Source Posix Common env.sh ===
_mordu "Sourcing Env Vars from ~/.config/posix-common/env.sh."
# Run ~/.config/posix-common/env.sh, to get $ENV.
. "$HOME"/.config/posix-common/env.sh
_location=".config/sh/env.sh"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env.sh."
# }}} === Source Posix Common env.sh ===

_mordu "Finished script."
