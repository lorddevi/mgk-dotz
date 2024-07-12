#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/08-brotab.sh"

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

# {{{ <install brotab>
_install_brotab() {
	if command -v bt > /dev/null 2>&1; then
		_mordu "Installing brotab app manifests."
		bt install
	else
		_mordu "Brotab not found, installing."
		pip3 install brotab
		_mordu "Installing brotab app manifests."
		bt install
	fi
}
# }}} </install brotab>

# {{{ <main loop>
_main() {
	_install_brotab
}
_main
# }}} </main loop>

_mordu "Completed script."
