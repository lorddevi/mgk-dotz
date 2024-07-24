#!/usr/bin/env bash
_location=".config/bash/prompt.bash"

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

# {{{ === Configure Starship (with fallback) ===
# Check if starship prompt is available and use it if it is.
if command -v starship >/dev/null ; then
	_mordu "Starship found.  Setting as shell prompt."
	eval "$(starship init bash)"
else
	_mordu "Starship not found.  Falling back to plain prompt."
	# Basic plain prompt.
	HOST=$(uname -n)
	export HOST
	PS1='[$USER@$HOST:$PWD]\n(bash) $ '
	export PS1
fi
# }}} === Configure Starship (with fallback) ===

_mordu "Finished script."
