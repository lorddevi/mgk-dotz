#!/usr/bin/env bash
_location=".config/yadm/shell-extras.d/04-neovim.sh"
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

# {{{ <create autoload directories>
_create_autoload_directories() {
	# Make sure the autoload directories exist for vim and nvim.
	_mordu "Creating autoload directories."
	if [ -d "${HOME}/.config/nvim/autoload" ] ; then
		_mordu "Neovim autoload dir already exists."
	else
		_mordu "Creating neovim autoload dir."
		mkdir -p "${HOME}/.config/nvim/autoload"
	fi
	_mordu "Finished creating autoload directories."
}
# }}} </create autoload directories>

# {{{ <link vim-plug to autoloads>
_link_vim_plug_to_autoloads() {
	local __opt_plug_vim="${HOME}/.local/opt/git/git.mgk.one/vim/junegunn.vim-plug/plug.vim"

	# Add Vim-Plug to neovim's autoload dir if it isn't already.
	_mordu_n "Checking for neovim's vim-plug link.."
	if [ -f "${HOME}/.config/nvim/autoload/plug.vim" ] ; then
		_mordu_nl "..Found."
	else
		_mordu_nl "..Not found.  Linking."
		ln -sr "$__opt_plug_vim" "${HOME}/.config/nvim/autoload/plug.vim"
	fi
}
# }}} </link vim-plug to autoloads>

# {{{ <define neovim plugins>
_define_neovim_plugins() {
	_mordu "Defining neovim plugin list."
	_neovim_plugins=(\
		git.mgk.one/nvim/norcalli.nvim-colorizer.lua \
		git.mgk.one/nvim/maxmx03.dracula.nvim \
		git.mgk.one/nvim/ishan9299.modus-theme-vim)
}
# }}} </define neovim plugins>

# {{{ <clone neovim plugins>
_clone_neovim_plugins() {
	_mordu "Cloning neovim plugins."
	for __neovim_plugin in "${_neovim_plugins[@]}" ; do
		local __repo="$__neovim_plugin"

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
# }}} </clone neovim plugins>

# {{{ <running vim plug install>
_run_vim_plug_install() {
	_mordu "Calling PlugInstall for nvim."
	nvim +PlugInstall +qall
}
# }}} </running vim plug install>

# {{{ <main loop>
_main() {
	_create_autoload_directories
	_link_vim_plug_to_autoloads
	_define_neovim_plugins
	_clone_neovim_plugins
	#_run_vim_plug_install
}
_main
# }}} </main loop>

_mordu "Completed script."
