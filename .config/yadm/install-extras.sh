#!/usr/bin/env bash
_location=".config/yadm/install-extras.sh"

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

# {{{ <installer functions>
# The scripts for setting up a minimal shell.
_shell_extras() {
	_mordu "Sourcing shell extra install scripts."
	for __app in "${HOME}/.config/yadm/shell-extras.d/"*.sh ; do
		_mordu "Processing ${__app}."
		bash "$__app"
	done
}

# The scripts for setting up a minimal workstation.
_workstation_extras() {
	_mordu "Sourcing workstation extra install scripts."
	for __app in "${HOME}/.config/yadm/workstation-extras.d/"*.sh ; do
		_mordu "Processing ${__app}."
		bash "${__app}"
	done
}
# }}} </installer functions>

# {{{ <source install scripts>
_source_install_scripts() {
	# Check if we are a workstation or server/shell only.
	if type Xorg > /dev/null 2>&1 ; then
		_mordu "Xorg found.  Installing extras for a graphical user environment."
		_shell_extras
		_workstation_extras
	else
		_mordu "Xorg not found.  Installing extras for a shell only environment."
		_shell_extras
	fi
}
# }}} </source install scripts>

# {{{ <main loop>
_main() {
	_source_install_scripts
	_mordu "Finished installing extras."
}
_main
# }}} </main loop>

_mordu "Completed script."
