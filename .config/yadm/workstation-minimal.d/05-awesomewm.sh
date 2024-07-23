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

# {{{ <clone vicious widgets>
_clone_and_link_vicious() {
	# Ensure it is already downloaded.
	local __repo="git.mgk.one/x11-wm/vicious-widgets.vicious"
	local __link_target="${HOME}/.config/awesome/vicious"

	_mordu_nl "Checking for ${__repo}.."
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

	if [ ! -L "${__link_target}" ]; then
		_mordu "Linking to ${__link_target}."
		ln -sr "${GHQ_ROOT}/${__repo}" "${__link_target}"
	fi
}
# }}} </clone vicious widgets>

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

# {{{ <link copycats to config dir>
_link_copycats_to_config() {
	# Link individual theme subdirectories to config dir.
	source_themes_dir="${GHQ_ROOT}/git.mgk.one/x11-wm/lcpz.awesome-copycats/themes"
	target_themes_dir="${HOME}/.config/awesome/themes"

	if [ ! -d "$target_themes_dir" ]; then
		mkdir -p "$target_themes_dir"
	fi

	theme_count=0
	for theme_dir in "$source_themes_dir"/*; do
		if [ -d "$theme_dir" ]; then
			theme_name=$(basename "$theme_dir")
			if [ ! -e "${target_themes_dir}/${theme_name}" ]; then
				ln -sr "$theme_dir" "${target_themes_dir}/${theme_name}"
				_mordu_nl "Linked theme: $theme_name"
				((theme_count++))
			else
				_mordu_nl "Theme already linked: $theme_name"
			fi
		fi
	done

	if [ $theme_count -gt 0 ]; then
		_mordu_nl "Linked $theme_count new theme(s) to config dir."
	else
		_mordu_nl "No new themes to link. All themes may already be linked."
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
# }}} </link copycats to config dir>

# {{{ <clone and link relz theme>
_clone_and_link_relz-theme() {
	# Ensure it is already downloaded.
	local __repo="git.mgk.one/x11-wm/relz.awesome-wm-theme"
	local __awesome_config="${HOME}/.config/awesome"

	_mordu_nl "Checking for ${__repo}.."
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

	if [ ! -L "${__awesome_config}"/utils.lua ]; then
		_mordu "Linking ${__repo} to ${__awesome_config}."
		ln -sr "${GHQ_ROOT}/${__repo}"/utils.lua \
			"${__awesome_config}"/utils.lua
	fi

	if [ ! -L "${__awesome_config}"/modules ]; then
		_mordu "Linking ${__repo} to ${__awesome_config}."
		ln -sr "${GHQ_ROOT}/${__repo}"/modules \
			"${__awesome_config}"/modules
	fi

	if [ ! -L "${__awesome_config}"/themes/relz ]; then
		_mordu "Linking ${__repo} to ${__awesome_config}."
		ln -sr "${GHQ_ROOT}/${__repo}"/themes/relz \
			"${__awesome_config}"/themes/relz
	fi
}
# }}} </clone and link relz theme>

# {{{ <main loop>
_main() {
	_clone_and_link_vicious
	_clone_awesome_copycats
	_link_copycats_to_config
	_clone_and_link_relz-theme
}
_main
# }}} </main loop>

_mordu "Completed script."
