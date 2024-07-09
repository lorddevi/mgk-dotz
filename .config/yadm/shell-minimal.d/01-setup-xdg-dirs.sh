#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/01-setup-xdg-dirs.sh"

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

# {{{ <xdg environment variables>
_set_xdg_environment() {
	_mordu "Setting XDG Environment Variables."
	XDG_CONFIG_HOME="${HOME}/.config"
	XDG_CACHE_HOME="${HOME}/.cache"
	XDG_DATA_HOME="${HOME}/.local/share"
	# The xdg user-dirs below usually aren't handled as Env Vars.  I
	# find it simplifies things for me right now.
	XDG_DESKTOP_DIR="${HOME}/.local/desktop"
	XDG_DOCUMENTS_DIR="${HOME}/dox"
	XDG_DOWNLOAD_DIR="${HOME}/dl"
	XDG_MUSIC_DIR="${HOME}/mzk"
	XDG_PICTURES_DIR="${HOME}/pix"
	XDG_PROJECTS_DIR="${HOME}/proj"
	XDG_PUBLICSHARE_DIR="${HOME}/pub"
	XDG_TEMPLATES_DIR="${HOME}/.local/templates"
	XDG_VIDEOS_DIR="${HOME}/vidz"
}
# }}} </xdg environment variables>

# {{{ <install xdg-user-dirs>
_install_xdg_user_dirs() {
	# Create ~/.config/user-dirs.dirs based on above.
	if ! command -v xdg-user-dirs-update > /dev/null 2>&1; then
		_mordu "Installing xdg-user-dirs."
		sudo dnf -y install xdg-user-dirs
	fi
}
# }}} </install xdg-user-dirs>

# {{{ <update xdg-user-dirs>
_update_xdg_user_dirs() {
	_mordu "Configuring XDG-USER-DIRS with xdg-user-dirs-update."
	xdg-user-dirs-update --set DOCUMENTS "$XDG_DOCUMENTS_DIR"
	xdg-user-dirs-update --set DESKTOP "$XDG_DESKTOP_DIR"
	xdg-user-dirs-update --set DOWNLOAD "$XDG_DOWNLOAD_DIR"
	xdg-user-dirs-update --set MUSIC "$XDG_MUSIC_DIR"
	xdg-user-dirs-update --set PICTURES "$XDG_PICTURES_DIR"
	xdg-user-dirs-update --set TEMPLATES "$XDG_TEMPLATES_DIR"
	xdg-user-dirs-update --set VIDEOS "$XDG_VIDEOS_DIR"
	xdg-user-dirs-update --set PUBLICSHARE "$XDG_PUBLICSHARE_DIR"
}
# }}} </update xdg-user-dirs>

# {{{ <create xdg user dirs>
# Let's make sure the XDG dirs exist. There is a good argument to
# be made that we keep this mkdir stuff solely in a boostrap
# phase, and not in a login or interactive shell phase of things.
# I will try to see if this helps with my sanity or if it is a bad
# idea later after trying for a while.
_create_xdg_dirs() {
	_mordu "Creating XDD-USER-DIRS that do not already exist."
	for _xdgdir in "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$XDG_DATA_HOME" \
		"$XDG_DESKTOP_DIR" "$XDG_DOCUMENTS_DIR" "$XDG_DOCUMENTS_DIR" \
		"$XDG_DOWNLOAD_DIR" "$XDG_MUSIC_DIR" "$XDG_PICTURES_DIR" \
		"$XDG_PUBLICSHARE_DIR" "$XDG_TEMPLATES_DIR" "$XDG_VIDEOS_DIR" \
		"$XDG_PROJECTS_DIR"
	do
		if [ ! -d "$_xdgdir" ]; then
			_mordu "Creating $_xdgdir."
			mkdir -p "$_xdgdir"
		fi
	done
}
# }}} </create xdg user dirs>

# {{{ <create extra xdg dirs>
# There are some directories I want to be sure exist for future use.  Some of
# the more basic items I will create here.
_create_extra_xdg_dirs() {
	PATH="${HOME}/.local/bin:${PATH}"
	GIT_OPT="${HOME}/.local/opt/git"
	GIT_PROJ="${HOME}/proj/git"

	# Create user's manual page root if it doesn't exist.
	if [ ! -d "${HOME}/.local/share/man" ]; then
		_mordu "Creating ${HOME}/.local/share/man."
		mkdir -pv "${HOME}/.local/share/man"
	fi
	
	# Create user's binary root if it doesn't exist.
	if [ ! -d "${HOME}/.local/bin" ]; then
		_mordu "Creating ${HOME}/.local/bin."
		mkdir -pv "${HOME}/.local/bin"
	fi
	
	# Create user's less cache dir if it doesn't exist.
	if [ ! -d "${HOME}/.cache/less" ]; then
		_mordu "Creating ${HOME}/.cache/less."
		mkdir -pv "${HOME}/.cache/less"
	fi
	
	# Create user's zsh share dir if it doesn't exist.
	if [ ! -d "${HOME}/.local/share/zsh" ]; then
		_mordu "Creating ${HOME}/.local/share/zsh."
		mkdir -p "${HOME}/.local/share/zsh"
	fi
	
	# Create users git repo root under optional software.
	if [ ! -d "$GIT_OPT" ]; then
		_mordu "Creating ${GIT_OPT}."
		mkdir -p "$GIT_OPT" 
	fi
	
	# Create users git repo root under projects.
	if [ ! -d "$GIT_PROJ" ]; then
		_mordu "Creating ${GIT_PROJ}."
		mkdir -p "$GIT_PROJ" 
	fi
}
# }}} </create extra xdg dirs>

# {{{ <main loop>
_main() {
	_set_xdg_environment
	_install_xdg_user_dirs
	_update_xdg_user_dirs
	_create_xdg_dirs
	_create_extra_xdg_dirs
}
_main
# }}} </main loop>

_mordu "Completed script."
