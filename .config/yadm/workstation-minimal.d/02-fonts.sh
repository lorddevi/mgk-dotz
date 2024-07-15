#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/02-fonts.sh"
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

# {{{ <make font dir if needed>
_make_font_dir_if_needed() {
if [ ! -d "${HOME}/.local/share/fonts" ]; then
	_mordu "Not linked yet: ${HOME}/.local/share/fonts.  Linking."
	mkdir -p "${HOME}/.local/share/fonts"
fi
}
# }}} </make font dir if needed>

# {{{ <install iosevka comfy>
_install_iosevka_comfy() {
	local __repo="git.mgk.one/fonts/protesilaos.iosevka-comfy"

	_mordu_n "Checking for iosevka-comfy.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_nl "Not Found.  Installing."
		$_ghq get --shallow "$__repo" \
		|| $_ghq get --shallow "$__repo" \
		|| $_ghq get --shallow "$__repo" \
		|| _mordu "Failed to download ${__repo} 3 times."
	fi
	
	_mordu "Linking font directories from git to share."
	for __font_dir in "${GHQ_ROOT}/${__repo}/"*/ ; do
		# Remove trailing slash from dir.
		__font_dir=${__font_dir%/}
		__font=$(basename "$__font_dir")
		_mordu_nl "Processing font_dir: ${__font_dir}."
		_mordu_nl "Processing font: $__font."
		if [ ! -d "${HOME}/.local/share/fonts/${__font}" ]; then
			_mordu_nl "Could not find ${HOME}/.local/share/fonts/${__font}."
			_mordu_nl "Linking ${__font_dir} to ${HOME}/.local/share/fonts/"
			ln -sr "$__font_dir" "${HOME}/.local/share/fonts/$__font"
		else
			_mordu_nl "Located ${HOME}/.local/share/fonts/${__font_dir}.  Not linking."
		fi
	done
}
# }}} </install iosevka comfy>

# {{{ <install lexend>
_install_lexend() {
	local __repo="git.mgk.one/fonts/mgk.lexend"

	_mordu "Checking for ${__repo}.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu "Found it.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu "Not Found.  Installing."
		$_ghq get --shallow "$__repo" \
		|| $_ghq get --shallow "$__repo" \
		|| $_ghq get --shallow "$__repo" \
		|| _mordu "Failed to download ${__repo} 3 times."
	fi
	
	_mordu "Linking font directories from git to share."
	if [ ! -d "${HOME}/.local/share/fonts/lexend" ]; then
		ln -sr "${GHQ_ROOT}/${__repo}/fonts" \
			"${HOME}/.local/share/fonts/lexend"
	fi
}
# }}} </install lexend>

# {{{ <install powerlevel10k meslo font>
_install_meslo() {
	local __repo="git.mgk.one/zsh/romkatv.powerlevel10k-media"

	_mordu_n "Checking for powerlevel10k-media.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_nl "Not Found.  Installing."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} 3 times."
	fi
	
	for __font_loc in "${GHQ_ROOT}/${__repo}/"*.ttf ; do
		__font_ttf=$(basename "$__font_loc")

		_mordu_nl "Processing font located at: $__font_loc."
		_mordu_nl "Processing font: $__font_ttf."
		_mordu_nl "Checking if ${__font_ttf} exists in ${HOME}/.local/share/fonts/."

		if [ ! -e "${HOME}/.local/share/fonts/${__font_ttf}" ] ; then
			_mordu_nl "Could not find ${HOME}/.local/share/fonts/${__font_ttf}."
			_mordu_nl "Linking ${__font_loc} to ${HOME}/.local/share/fonts/${__font_ttf}."
			ln -sr "$__font_loc" "${HOME}/.local/share/fonts/${__font_ttf}"
		else
			_mordu_nl "Found ${HOME}/.local/share/fonts/${__font_ttf}.  Not linking."
		fi
	done
}
# }}} <install powerlevel10k meslo font>

# {{{ <regen fonts>
_regen_fonts() {
	_mordu_n "Regenerating font cache.."
	fc-cache
	_mordu_nl "..Done."
}
# }}} </regen fonts>

# {{{ <main loop>
_main() {
	_make_font_dir_if_needed
	_install_iosevka_comfy
	_install_lexend
	_install_meslo
	_regen_fonts
}
_main
# }}} </main loop>

_mordu "Completed script."
