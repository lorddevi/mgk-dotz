#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/04-install-go-stuff.sh"
export GOPATH="${HOME}/.local/opt/go"

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

# {{{ <install golang>
_install_golang() {
	_mordu_n "Checking for go.."
	if command -v go > /dev/null 2>&1 ; then
		_mordu_nl "..Found.  Not installing."
	else
		_mordu "..Not found.  Installing go."
		sudo dnf install -y golang
	fi
}
# }}} </install golang>

# {{{ <install go packages>
## Make sure the binary directory exists already.
_install_go_packages() {
	if [ ! -d "${GOPATH}/bin" ]; then
		_mordu "Did not find ${GOPATH}/bin.  Creating."
		mkdir -p "$GOPATH"/bin
	fi
	
	## Install Ghq
	if [ -f "${GOPATH}/bin/ghq" ]; then
		_mordu "Ghq already installed."
	else
		_mordu "Installing Ghq."
		go install github.com/x-motemen/ghq@latest
	fi
}
# }}} </install go packages>

# {{{ <main loop>
_main() {
	_install_golang
	_install_go_packages
}
_main
# }}} </main loop>

_mordu "Completed script."
