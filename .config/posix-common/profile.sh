#!/usr/bin/env sh
_location=".config/posix-common/profile.sh"

# Sourced by 'sh', or bash in 'sh' compatability mode.
# WARNING: if you delete .bash_profile, this file becomes part of bash's startup
# sequence, which means this file suddenly has to cater for two different
# shells.

# {{{ <mordu debug system>
# _debug=y # Comment this out to disable debuging.

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

# {{{ === Source env.sh ===
_mordu "Sourcing Env Vars from ~/.config/sh/env.sh."
. "$HOME"/.config/sh/env.sh
_location=".config/posix-common/profile.sh"
_mordu "Finished sourcing Env Vars from ~/.config/sh/env.sh."
# }}} === Source env.sh ===

# {{{ === Source login.sh ===
_mordu "Sourcing Login Shell settings from ~/.config/sh/login.sh."
. "$HOME"/.config/sh/login.sh
_location=".config/posix-common/profile.sh"
_mordu "Finished sourcing Login Shell settings from ~/.config/sh/login.sh."
# }}} === Source login.sh ===

_mordu "Finished script."
