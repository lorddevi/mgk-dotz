#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/07-tmux.sh"
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

# {{{ <define tmux plugins>
_define_tmux_plugins() {
	_tmux_plugins=(\
		tmux-plugins.tpm \
		tmux-plugins.tmux-sensible \
		o0th.tmux-nova \
		tmux-plugins.tmux-battery \
		imomaliev.tmux-keyboard-layout \
		tmux-plugins.tmux-yank \
		tmux-plugins.tmux-cpu \
		tmux-plugins.tmux-resurrect \
		tmux-plugins.tmux-continuum \
		crispyconductor.tmux-copy-toolkit \
		roosta.tmux-fuzzback \
		jaclu.tmux-power-zoom \
		jabirali.tmux-tilish \
		sunaku.tmux-navigate \
		tmux-plugins.tmux-logging
		thewtex.tmux-mem-cpu-load)
}
# }}} </define tmux plugins>

# {{{ <clone tmux plugins>
_clone_tmux_plugins() {
	_mordu "Cloning tmux plugins."
	if [ ! -d "${HOME}/.config/tmux/plugins" ] ; then
		_mordu "Did not find a tmux plugins directory.  Creating."
		mkdir -p "${HOME}/.config/tmux/plugins"
	fi
	
	for _plugin in "${_tmux_plugins[@]}" ; do
		local __repo="git.mgk.one/tmux/${_plugin}"

		_mordu "Checking for plugin ${__repo}."
		if $_ghq list | grep -q "$__repo" ; then
			_mordu "Found existing clone of ${__repo}.  Updating."
			$_ghq get -u "$__repo"
		else
			_mordu "Could not find ${_plugin}."
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
		fi

		_mordu "Checking for ${_plugin} link."
		if [ -e ~/.config/tmux/plugins/"${_plugin}" ] ; then
			_mordu "Found ${_plugin} link."
		else
			_mordu "Could not find ${_plugin} link."
			ln -sr "${HOME}/.local/opt/git/${__repo}" \
				"${HOME}/.config/tmux/plugins/${_plugin}"
		fi
	done
}
# }}} </clone tmux plugins>

# {{{ <install tmux plugins>
_install_tmux_plugins() {
	export TMUX_PLUGIN_MANAGER_PATH="${HOME}/.config/tmux/plugins/"
	_mordu "Calling 'install_plugins' to install tmux plugins."
	"${HOME}/.config/tmux/plugins/tmux-plugins.tpm/bin/install_plugins"
}
# }}} </install tmux plugins>

# {{{ <main loop>
_main() {
	_define_tmux_plugins
	_clone_tmux_plugins
	_install_tmux_plugins
}
_main
# }}} </main loop>

_mordu "Completed script."
