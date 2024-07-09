#!/usr/bin/env bash
_location=".config/yadm/shell-extras.d/02-install-go-stuff.sh"
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

# {{{ <install go packages>
## Make sure the binary directory exists already.
_install_go_packages() {
	## Install Lazygit
	if [ -x "${GOPATH}/bin/lazygit" ]; then
		_mordu "Lazygit already installed."
	else
		_mordu "Installing lazygit."
		go install github.com/jesseduffield/lazygit@latest
	fi
	
	## Install Tea
	if [ -x "${GOPATH}/bin/tea" ]; then
		_mordu "Tea already installed."
	else
		_mordu "Installing tea."
		go install code.gitea.io/tea@latest
	fi
	
	## Install Gitmux
	if [ -x "${GOPATH}/bin/gitmux" ]; then
		_mordu "Gitmux already installed."
	else
		_mordu "Installing Gitmux."
		go install github.com/arl/gitmux@latest
	fi
	
	## Install Shfmt
	if [ -f "${GOPATH}/bin/shfmt" ]; then
		_mordu "Shfmt already installed."
	else
		_mordu "Installing shfmt."
		go install mvdan.cc/sh/v3/cmd/shfmt@latest
	fi
}
# }}} </install go packages>

# {{{ <main loop>
_main() {
	_install_go_packages
}
_main
# }}} </main loop>

_mordu "Completed script."
