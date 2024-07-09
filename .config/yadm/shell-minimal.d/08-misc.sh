#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/08-misc.sh"
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

# {{{ <git functions>
# Function for testing if a repo was just updated or not.
_was_repo_updated() {
	__repo_path="$1"

	cd "$__repo_path" || exit

	__fetch_head_time=$(stat -c %Y .git/ORIG_HEAD)
	__current_time=$(date +%s)
	__time_diff=$((__current_time - __fetch_head_time))

	_mordu "Fetch Head Time: $__fetch_head_time"
	_mordu "Current Time: $__current_time"
	_mordu "Time Diff: $__time_diff"

	if [ "$__time_diff" -le 60 ]; then
		return 0 # True
	else
		return 1 # False
	fi
}
# }}} </git functions>

# {{{ <install bat extras>
_install_bat_extras() {
	local __repo="git.mgk.one/utils-shell/eth-p.bat-extras"

	# Check if the repo already exists or not.
	_mordu_n "Checking for ${__repo}.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_nl "Not Found.  Installing."
		$_ghq get "$__repo"
	fi

	# Check if the repo needs to be rebuilt or not.
	if _was_repo_updated "${GHQ_ROOT}/${__repo}" ; then
		_mordu "The repo ${__repo} was updated recently."
		cd "${GHQ_ROOT}/${__repo}" || exit
		./build.sh --install --prefix="${HOME}/.local/" --minify=none
		cd || exit
	else
		_mordu "The repo ${__repo} was not updated recently."
	fi
}
# }}} </install bat extras>

# {{{ <install and update ls_colors>
_install_and_update_ls_colors() {
	local __repo="git.mgk.one/utils-shell/trapd00r.LS_COLORS"

	_mordu "Checking for ${__repo}.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "${__repo}" 
	else
		_mordu "Not Found.  Installing."
		$_ghq get "${__repo}" 
	fi
	
	# Check if the repo needs to be rebuilt or not.
	if _was_repo_updated "${GHQ_ROOT}/${__repo}" ; then
		_mordu "The repo ${__repo} was updated recently."
	
		# Generate the LS_COLORS script I use for my shell init.
		_mordu "Generating lscolors.sh from LS_COLORS."
		dircolors -b "${HOME}/.config/posix-common/LS_COLORS" \
			> "${HOME}/.config/posix-common/lscolors.sh"
		
		# Search and replace the blue used for directories with my preference.
		sed -i 's/di=38;5;30/di=01;34/' "${HOME}/.config/posix-common/lscolors.sh"
		sed -i 's/ln=target/ln=01;36/' "${HOME}/.config/posix-common/lscolors.sh"

		# Ensure the lscolors.sh script is executable.
		_mordu "Ensuring lscolors.sh is executable."
		chmod +x "${HOME}/.config/posix-common/lscolors.sh"
		cd || exit
	else
		_mordu "The repo ${__repo} was not updated recently."
	fi
}
# }}} </install and update ls_colors>

# {{{ <install ugit>
_install_ugit() {
	local __repo="git.mgk.one/utils-code/bhupesh-v.ugit"

	_mordu_n "Checking for ${__repo}.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_nl "Not Found.  Installing."
		$_ghq get "$__repo"
	fi

	_mordu_n "Checking for ugit binary link.."
	if [ -L "${HOME}/.local/bin/ugit" ]; then
		_mordu_nl "..Found.  Not linking."
	else
		_mordu_nl "..Not Found.  Linking."
		ln -sr "${GHQ_ROOT}/${__repo}/ugit" \
			"${HOME}/.local/bin/ugit"
	fi
}
# }}} </install ugit>

# {{{ <main loop>
_main() {
	_install_bat_extras
	_install_and_update_ls_colors
	_install_ugit
}
_main
# }}} </main loop>

_mordu "Completed script."
