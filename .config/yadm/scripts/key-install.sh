#!/usr/bin/env bash
_location=".config/yadm/scripts/install-key.sh"
export GHQ_ROOT="${HOME}/.local/opt/git"
_ghq="${HOME}/.local/opt/go/bin/ghq"
export GNUPGHOME="${HOME}/.config/gnupg"

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

# {{{ <clone keys>
_clone_keys() {
	local __repo="git.mgk.one/ld/keys"

	_mordu_n "Checking for ${__repo}.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_nl "Not Found.  Installing."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
	fi
}
# }}} </clone keys>

# {{{ <install deps if needed>
_install_deps_if_needed() {
	local __required_packages=(gnupg pinentry)

	for __package in "${__required_packages[@]}" ; do
		if [[ $(rpm -qi "${__package//\"/}") == "package ${__package//\"/} is not installed"  ]] ; then
			_mordu "Not installed yet: ${__package}."
			__not_installed_yet+=( "$__package" )
		else
			_mordu "Already installed: ${__package}."
		fi
	done
	_mordu "Total not installed yet: ${__not_installed_yet[*]}"

	if (( ${#__not_installed_yet[@]} )); then
		sudo dnf -y install "${__not_installed_yet[@]}"
	fi
}
# }}} </install deps if needed>

# {{{ <use ncurses pinentry>
_use_ncurses_pinentry() {
	echo "pinentry-program /usr/bin/pinentry-curses" | sudo tee /etc/gnupg/gpg-agent.conf
}
# }}} </use ncurses pinentry>

# {{{ <check for home gnupg>
_check_for_home_gnupg() {
	if [ -d "${HOME}/.gnupg" ]; then
		if [ -z "$(ls -A "${HOME}/.gnupg")" ]; then
			_mordu "${HOME}/.gnupg exists and is empty.  Deleting."
			rmdir "${HOME}/.gnupg"
		else
			_mordu "${HOME}/.gnupg exists and is not empty."
		fi
	else
			_mordu "${HOME}/.gnupg does not exist."
	fi
}
# }}} </check for home gnupg>

# {{{ <check for xdg gnupg>
_check_for_xdg_gnupg() {
	if [ -d "${HOME}/.config/gnupg" ]; then
		if [ -z "$(ls -A "${HOME}/.config/gnupg")" ]; then
			_mordu "${HOME}/.config/gnupg exists and is empty."
		else
			_mordu "${HOME}/.config/gnupg exists and is not empty."
		fi
	else
			_mordu "${HOME}/.config/gnupg does not exist.  Creating."
			mkdir -p "${HOME}/.config/gnupg"
	fi
}
# }}} </check for xdg gnupg>

# {{{ <decrypt and import>
_decrypt_and_import() {
	local __repo="git.mgk.one/ld/keys"
	export GPG_TTY="$(tty)"

	_mordu "Preforming decrypt and secret key import."
	_mordu "You will be asked for a passphrase."
	_mordu "If there are problems, ensure the environment variable GPG_TTY is set to \$\(tty\)."
	GPG_TTY="$(tty)" gpg --decrypt "${GHQ_ROOT}/${__repo}"/keys/secret-key.gpg.enc | gpg --import
	_mordu "Finished running import."
}
# }}} </decrypt and import>

# {{{ <list keys>
_list_keys() {
	_mordu "The installed keys:"
	gpg --list-keys
	_mordu "The installed secret keys:"
	gpg --list-secret-keys
}
# }}} </list keys>

# {{{ <main loop>
_main() {
	_clone_keys
	_install_deps_if_needed
	_check_for_home_gnupg
	_check_for_xdg_gnupg
	_decrypt_and_import
	_list_keys
}
_main
# }}} </main loop>

_mordu "Completed script."
