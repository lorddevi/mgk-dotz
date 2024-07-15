#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/09-gsu.sh"
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
	# This is a list of packages required to compile the tool with.
	local __required_packages=(libXext libXext-devel libXrender libXrender-devel)

	for __package in "${__required_packages[@]}" ; do
		if [[ $(rpm -qi "${__package//\"/}") == "package ${__package//\"/} is not installed"  ]] ; then
			_mordu "Could not find $__package."
			local __not_installed_yet+=( "$__package" )
		else
			_mordu "Found $__package."
		fi
	done

	_mordu "Total not installed yet: ${__not_installed_yet[*]}"

	if (( ${#__not_installed_yet[@]} )); then
		sudo dnf -y install --allowerasing "${__not_installed_yet[@]}"
	fi
}
# }}} </install deps>

# {{{ <install xwinwrap>
_install_xwinwrap() {
    local __repo="git.mgk.one/x11-misc/mmhobi7.xwinwrap"
    local __repo_loc="${GHQ_ROOT}/${__repo}"

    # Check if the repo is already downloaded or not.
    if $_ghq list | grep -q "$__repo" ; then
	_mordu "Found $__repo.  Updating."
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
# }}} </install xwinwrap>

# {{{ <compile xwinwrap>
_compile_and_install_xwinwrap() {
	local __repo="git.mgk.one/x11-misc/mmhobi7.xwinwrap"
	local __repo_loc="${GHQ_ROOT}/${__repo}"

	if command -v "xwinwrap" > /dev/null 2>&1; then
		_mordu "Binary already installed, not compiling or installing."
	else
		# Compile the source code.
		cd "$__repo_loc" || exit
		_mordu "Compiling $__repo."
		make
		_mordu "Installing $__repo."
		sudo make install
		make clean
		_mordu "Compiled and installed $__repo."
	fi
}
# {{{ <compile xwinwrap>

# {{{ <main loop>
_main() {
	_install_deps
	_install_xwinwrap
	_compile_and_install_xwinwrap
}
_main
# }}} </main loop>

_mordu "Completed script."
