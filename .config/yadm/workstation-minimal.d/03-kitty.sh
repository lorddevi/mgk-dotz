#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/03-kitty.sh"
_ghq="${HOME}/.local/opt/go/bin/ghq"

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

# {{{ <clone kitty themes>
_clone_kitty_themes() {
	local __repo="git.mgk.one/x11-term/dexpota.kitty-themes"

	if $_ghq list | grep -q "$__repo" ; then
		_mordu "Kitty themes already found."
	else
		_mordu "Cloning kitty-themes."
		$_ghq get "$__repo" 
	fi
}
# }}} </clone kitty themes>

# {{{ <main loop>
_main() {
	_clone_kitty_themes
}
_main
# }}} </main loop>

_mordu "Completed script."
