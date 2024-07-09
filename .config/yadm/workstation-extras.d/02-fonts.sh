#!/usr/bin/env bash
_location=".config/yadm/workstation-extras.d/02-fonts.sh"
GHQ_ROOT="${HOME}/.local/opt/git"
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

# {{{ <install nerd fonts>
_install_nerd_fonts() {
	local __repo="git.mgk.one/fonts/ryanoasis.nerd-fonts"

	_mordu_n "Checking for nerd-fonts.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u --shallow "$__repo"
	else
		_mordu_nl "Not Found.  Installing."
		$_ghq get --shallow "$__repo" \
			||	$_ghq get --shallow "$__repo" \
			||	$_ghq get --shallow "$__repo" \
			|| _mordu "Failed to download ${__repo} three times."
	fi
	
	_mordu_nl "Checking to see if Nerd Fonts are already installed to ~/.local/share/fonts/."
	if [ ! -d "${HOME}/.local/share/fonts/NerdFonts" ]; then
		_mordu_nl "Not installed yet: ${HOME}/.local/share/fonts/NerdFonts."
		_mordu_nl "Running the Nerd Fonts install script."
		"${GHQ_ROOT}/${__repo}/install.sh" -l
	else
		_mordu_nl "Nerd Fonts found already linked at ${HOME}/.local/share/fonts/NerdFonts.  Not linking."
	fi
}
# }}} </install nerd fonts>

# {{{ <regen fonts>
_regen_fonts() {
	_mordu_n "Regenerating font cache.."
	fc-cache
	_mordu_nl "..Done."
}
# }}} </regen fonts>

# {{{ <main loop>
_main() {
	_install_nerd_fonts
 _regen_fonts
}
_main
# }}} </main loop>

_mordu "Completed script."
