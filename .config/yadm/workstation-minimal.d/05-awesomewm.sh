#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/05-awesomewm.sh"
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

# {{{ <clone awesome-copycats>
_clone_awesome_copycats() {
	# Ensure it is already downloaded.
	local __repo="git.mgk.one/x11-wm/lcpz.awesome-copycats"

	_mordu_nl "Checking for awesome copycats.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_n "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_n "..Not found.  Cloning."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
	fi
}
# }}} </clone awesome-copycats>

# {{{ <link to config dir>
_link_to_config() {
	# Link themes to config dir.
	if [ ! -e "${HOME}/.config/awesome/themes" ]; then
		_mordu_nl "Awesome Copycats does not appear to be linked to config dir yet."
		_mordu_nl "Linking theme dir to config dir."
		ln -sr "${GHQ_ROOT}/git.mgk.one/x11-wm/lcpz.awesome-copycats/themes" \
			"${HOME}/.config/awesome/themes"
	else
		_mordu_nl "Awesome Copycats themes already linked to config dir."
	fi
	
	# Link freedesktop to config dir.
	if [ ! -e "${HOME}/.config/awesome/freedesktop" ]; then
		_mordu_nl "Awesome freedesktop does not appear to be linked to config dir yet."
		_mordu_nl "Linking freedesktop dir to config dir."
		ln -sr "${GHQ_ROOT}/git.mgk.one/x11-wm/lcpz.awesome-copycats/freedesktop" \
			"${HOME}/.config/awesome/freedesktop"
	else
		_mordu_nl "Awesome freedesktop already linked to config dir."
	fi
	
	# Link lain to config dir.
	if [ ! -e "${HOME}/.config/awesome/lain" ]; then
		_mordu_nl "Lain does not appear to be linked to config dir yet."
		_mordu_nl "Linking lain dir to config dir."
		ln -sr "${GHQ_ROOT}/git.mgk.one/x11-wm/lcpz.awesome-copycats/lain" \
			"${HOME}/.config/awesome/lain"
	else
		_mordu_nl "Awesome lain already linked to config dir."
	fi
}
# }}} </link to config dir>

# {{{ <main loop>
_main() {
	_clone_awesome_copycats
	_link_to_config
}
_main
# }}} </main loop>

_mordu "Completed script."
