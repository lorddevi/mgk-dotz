#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/11-papez.sh"
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

# {{{ <clone papez>
_clone_papez() {
    local __repo="git.mgk.one/pub/papez"
    local __repo_loc="${GHQ_ROOT}/${__repo}"

    # Check if the repo is already downloaded or not.
    if $_ghq list | grep -q "$__repo"; then
	_mordu "Found ${__repo}.  Updating."
	$_ghq get -u "$__repo"
    else
	# Clone the repo.
	_mordu "Cloning $__repo."
	$_ghq get "$__repo" \
	    || $_ghq get "$__repo" \
	    || $_ghq get "$__repo" \
	    || _mordu "Failed to download ${__repo} three times."
    fi
}
# }}} </clone papez>

# {{{ <link papez>
_link_papez() {
	local __repo="git.mgk.one/pub/papez"
	local __repo_loc="${GHQ_ROOT}/${__repo}"

	if [ -L "${HOME}/pix/papez" ]; then
		_mordu "Found a papez link in pix already.  Replacing."
		rm "${HOME}/pix/papez"
	fi

	_mordu "Linking ${__repo_loc} to ${HOME}/pix/papez."
	ln -sr "$__repo_loc" "${HOME}/pix/papez"
}
# }}} </link papez>

# {{{ <sort papez>
_sort_papez() {
	_mordu "Sorting the papez out according to theme in mgk-bg.conf."
	"${HOME}/.local/bin/sort-papez"
}
# }}} </sort papez>

# {{{ <main loop>
_main() {
    _clone_papez
		_link_papez
		_sort_papez
}
_main
# }}} </main loop>

_mordu "Completed script."
