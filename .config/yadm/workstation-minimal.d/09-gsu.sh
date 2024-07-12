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

# {{{ <install deps for gsu>
_install_deps() {
	# This is a list of packages required to compile the tool with.
	local __required_packages=(jq curl xdotool maim slop ffmpeg)

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
# }}} </install deps for gsu>

# {{{ <git clone gsu and install>
_install_gsu() {
	# Check if the repo is already downloaded or not.
	if $_ghq list | grep -q "winneon.gsu" ; then
		_mordu "Found gsu.  Not cloning."
	else
		local __repo="git.mgk.one/x11-misc/winneon.gsu"
		local __repo_loc="${GHQ_ROOT}/${__repo}"

		# Clone the repo.
		_mordu "Cloning $__repo."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."

		# Change to the repo directory, as we need to compile it.
		cd "$__repo_loc" || exit

		# Compile the source code.
		_mordu "Compiling gsu."
		PREFIX="${HOME}/.local" SYSCONFDIR="$HOME/.config" make install
		_mordu "Compiled and installed gsu."
	fi
}
# }}} </git clone gsu and install>

# {{{ <main loop>
_main() {
	_install_deps
	_install_gsu
}
_main
# }}} </main loop>

_mordu "Completed script."
