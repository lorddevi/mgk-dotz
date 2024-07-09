#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/06-stumpwm.sh"
export GHQ_ROOT="${HOME}/.local/opt/git"
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

# {{{ <clone stumpwm>
_clone_stumpwm() {
	# Ensure it is already downloaded.
	local __repo="git.mgk.one/x11-wm/stumpwm.stumpwm"

	_mordu_n "Checking for StumpWM.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_n "..Not found.  Cloning."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
	fi
}
# }}} </clone stumpwm>

# {{{ <compile and install stumpwm>
_compile_and_install_stumpwm() {
	if ! command -v stumpwm > /dev/null 2>&1; then
		_mordu "StumpWM binary not found.  Compiling and installing."
		cd "${GHQ_ROOT}/git.mgk.one/x11-wm/stumpwm.stumpwm" || exit
		./autogen || exit
		./configure || exit
		make || exit
		sudo make install || exit
		_mordu "StumpWM compiled and installed."
	else
		_mordu "StumpWM binary found in path.  Not compiling and installing."
	fi
}
# }}} </compile and install stumpwm>

# {{{ <main loop>
_main() {
	_clone_stumpwm
	_compile_and_install_stumpwm
}
_main
# }}} </main loop>

_mordu "Completed script."
