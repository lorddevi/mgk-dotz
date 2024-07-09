#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/04-xcape.sh"
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

# {{{ <install deps>
_install_deps() {
	local __required_packages=(git gcc make pkgconf-pkg-config libX11-devel libXtst-devel libXi-devel)

	for __package in "${__required_packages[@]}" ; do
		if [[ $(rpm -qi "${__package//\"/}") == "package ${__package//\"/} is not installed"  ]] ; then
			_mordu "Could not find ${__package}."
			__not_installed_yet+=( "$__package" )
		else
			_mordu "Found ${__package}."
		fi
	done
	_mordu "Total not installed yet: ${__not_installed_yet[*]}"

	if (( ${#__not_installed_yet[@]} )); then
		sudo dnf -y install "${__not_installed_yet[@]}"
	fi
}
# }}} </install deps>

# {{{ <clone and make install xcape>
_install_xcape() {
	local __repo="git.mgk.one/x11-input/alols.xcape"

	if $_ghq list | grep -q "$__repo" ; then
		_mordu "${__repo} already cloned.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu "Cloning kitty-themes."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
	fi

	cd "${GHQ_ROOT}/git.mgk.one/x11-input/alols.xcape" || exit
	_mordu "Compiling xcape."
	make
	_mordu "Performing make install for xcape."
	make PREFIX="${HOME}/.local" MANDIR="/share/man/man1" install
	cd || exit

	if command -v xcape ; then
		_mordu "Successfully installed xcape."
	else
		_mordu "Problem installing xcape.  Could not find it in path."
		exit 1
	fi
}
# }}} </clone and make install xcape>

# {{{ <main loop>
_main() {
	_mordu_n "Checking for xcape.."
	if command -v xcape > /dev/null ; then
		_mordu_nl "..Found."
	else
		_mordu_nl "Not Found.  Installing."
		_install_deps
	  _install_xcape
	fi
}
_main
# }}} </main loop>

_mordu "Completed script."
