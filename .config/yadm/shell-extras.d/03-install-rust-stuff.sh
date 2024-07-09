#!/usr/bin/env bash
_location=".config/yadm/shell-extras.d/03-install-rust-stuff.sh"
export CARGO_HOME="${HOME}/.local/opt/cargo"

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

# {{{ <install rust and cargo>
_install_rust_and_cargo() {
	_mordu "Installing rust and cargo."
	sudo dnf install -y rust cargo
}
# }}} </install rust and cargo>

# {{{ <install cargo packages>
## Make sure the binary directory exists already.
_install_cargo_packages() {
	if [ ! -d "${CARGO_HOME}/bin" ]; then
		_mordu "Did not find ${CARGO_HOME}/bin.  Creating."
		mkdir -p "${CARGO_HOME}/bin"
	fi
	
	## Install ddh
	if [ -x "${CARGO_HOME}/bin/ddh" ]; then
		_mordu "Ddh already installed."
	else
		_mordu "Installing ddh."
		cargo install --git https://git.mgk.one/utils-system/darakian.ddh
	fi
	
	## Install suckit 
	if [ -x "${CARGO_HOME}/bin/suckit" ]; then
		_mordu "Suckit already installed."
	else
		_mordu "Installing suckit."
		cargo install --git https://git.mgk.one/scraping/skallwar.suckit
	fi
	
	## Install skim
	if [ -x "${CARGO_HOME}/bin/sk" ]; then
		_mordu "Skim already installed."
	else
		_mordu "Installing skim."
		cargo install --git https://git.mgk.one/utils-shell/lotabout.skim
	fi
}
# }}} </install cargo packages>

# {{{ <main loop>
_main() {
	_install_rust_and_cargo
	_install_cargo_packages
}
_main
# }}} </main loop>

_mordu "Completed script."
