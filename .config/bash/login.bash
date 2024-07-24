#!/usr/bin/env bash
_location=".config/bash/login.bash"

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

# {{{ === Source Posix Common login.sh ===
_mordu "Sourcing Login Shell settings from ~/.config/posix-common/login.sh."
source "$HOME"/.config/posix-common/login.sh
_location=".config/bash/login.bash"
_mordu "Finished sourcing Login Shell settings from ~/.config/posix-common/login.sh."
# }}} === Source Posix Common login.sh ===
    
_mordu "Finished script."
