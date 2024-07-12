#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/08-vim.sh"
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

# {{{ <clone vim plug>
_clone_vim_plug() {
	# Download Vim-Plug if it isn't already.
	local __repo="git.mgk.one/vim/junegunn.vim-plug"

	_mordu_n "Checking ro cloned ${__repo}.."
	if $_ghq list | grep -q "$__repo" ; then
		_mordu_nl "..Found.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu_n "Not found.  Cloning."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
	fi
}
# }}} </clone vim plug>

# {{{ <create autoload directories>
_create_autoload_directories() {
	# Make sure the autoload directories exist for vim and nvim.
	_mordu "Creating autoload directories."
	if [ -d "${HOME}/.config/vim/autoload" ] ; then
		_mordu "Vim autoload dir already exists."
	else
		_mordu "Creating vim autoload dir."
		mkdir -p "${HOME}/.config/vim/autoload"
	fi
	_mordu "Finished creating autoload directories."
}
# }}} </create autoload directories>

# {{{ <link vim-plug to autoloads>
_link_vim_plug_to_autoloads() {
	local __opt_plug_vim="${HOME}/.local/opt/git/git.mgk.one/vim/junegunn.vim-plug/plug.vim"

	# Add Vim-Plug to vim's autoload dir if it isn't already.
	_mordu_n "Checking for vim's vim-plug link.."
	if [ -f "${HOME}/.config/vim/autoload/plug.vim" ] ; then
		_mordu_nl "..Found."
	else
		_mordu_nl "..Not found.  Linking."
		ln -sr "$__opt_plug_vim" "${HOME}/.config/vim/autoload/plug.vim"
	fi
}
# }}} </link vim-plug to autoloads>

# {{{ <define vim plugins>
_define_vim_plugins() {
	_mordu "Defining vim plugin list."
	_vim_plugins=(\
		git.mgk.one/vim/bourgeoisbear.clrzr \
		git.mgk.one/vim/khaveesh.vim-fish-syntax \
		git.mgk.one/vim/tpope.vim-surround \
		git.mgk.one/vim/tpope.vim-repeat)
}
# }}} </define vim plugins>

# {{{ <clone vim plugins>
_clone_vim_plugins() {
	_mordu "Cloning vim plugins."
	for __vim_plugin in "${_vim_plugins[@]}" ; do
		local __repo="$__vim_plugin"

		_mordu_n "Checking for ${__repo}.."
		if [ -d "${HOME}/.local/opt/git/${__repo}" ]; then
			_mordu_nl "..Found.  Updating."
			$_ghq get -u "$__repo"
		else
			_mordu_nl "..Not found.  Cloning."
			$_ghq get "$__repo" \
				|| $_ghq get "$__repo" \
				|| $_ghq get "$__repo" \
				|| _mordu "Failed to download ${__repo} three times."
		fi
	done
}
# }}} <clone vim plugins>

# {{{ <main loop>
_main() {
	_clone_vim_plug
	_create_autoload_directories
	_link_vim_plug_to_autoloads
	_define_vim_plugins
	_clone_vim_plugins
}
_main
# }}} </main loop>

_mordu "Completed script."
