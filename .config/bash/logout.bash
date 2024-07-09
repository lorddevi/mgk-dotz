#!/usr/bin/env bash
_location=".config/bash/logout.bash"

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

# {{{ === Source Posix Common logout.sh ===
_mordu "Performing logout actions from ~/.config/posix-common/logout.sh."
source "$HOME"/.config/posix-common/logout.sh
_location=".config/bash/logout.bash"
_mordu "Finished sourcing ~/.config/posix-common/logout.sh."
# }}} === Source Posix Common logout.sh ===

# {{{ === Garbage Collection ===
# Remove any stale .bash_history files still sitting around the homedir.
if [ -f "$HOME"/.bash_history ] ; then
	_mordu "Found a stale ~/.bash_history file that shouldn't be there. Deleting it."
	rm "$HOME"/.bash_history
fi
# }}} === Garbage Collection ===

_mordu "Finished script."
