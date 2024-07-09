#!/usr/bin/env bash
_location=".config/yadm/shell-minimal.d/05-zsh.sh"
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

# {{{ <clone zinit>
_clone_zinit() {
	ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
	local __repo="git.mgk.one/zsh/zdharma-continuum.zinit"
	local _zinit_opt="${GHQ_ROOT}/${__repo}"

	if ! $_ghq list | grep -q "$__repo" ; then
		_mordu "Git cloning zinit."
		$_ghq get "${__repo}" \
			|| $_ghq get "${__repo}" \
			|| $_ghq get "${__repo}" \
			_mordu "Git zinit clone failed 3 times."
	else
		_mordu "Found repo ${__repo}.  Updating."
		$_ghq get -u "${__repo}"
	fi

	if [ ! -d "${HOME}/.local/share/zinit" ]; then
		_mordu "Creating .local/share/zinit."
		mkdir -p "${HOME}/.local/share/zinit"
	fi

	if [ ! -e "$ZINIT_HOME" ]; then
		_mordu "Linking the zinit repo to ${ZINIT_HOME}."
		ln -sr "$_zinit_opt" "$ZINIT_HOME"
	fi
}
# }}} </clone zinit>

# {{{ <define zsh plugins>
_define_zsh_plugins() {
	_zsh_plugins=(\
		zdharma-continuum.zinit-annex-meta-plugins \
		zdharma-continuum.zinit-annex-bin-gem-node \
		zdharma-continuum.zinit-annex-patch-dl \
		zdharma-continuum.zinit-annex-rust \
		zdharma-continuum.fast-syntax-highlighting \
		zdharma-continuum.history-search-multi-word \
		zsh-users.zsh-completions \
		zsh-users.zsh-autosuggestions \
		aloxaf.fzf-tab \
		joshskidmore.zsh-fzf-history-search \
		romkatv.powerlevel10k-media \
		romkatv.powerlevel10k)
}
# }}} </define zsh plugins>

# {{{ <clone zsh plugins>
_clone_zsh_plugins() {
	for _plugin in "${_zsh_plugins[@]}" ; do
		local __repo="git.mgk.one/zsh/${_plugin}"

		if $_ghq list | grep -q "$__repo" ; then
		  _mordu "Found existing clone of ${__repo}.  Updating."
			$_ghq get -u "$__repo"
		else
			_mordu "Could not find ${__repo}.  Installing."
			$_ghq get "$__repo"
		fi
	done
}
# }}} </clone zsh plugins>

# {{{ <zsh interactive once>
_zsh_interactive_once() {
	zsh -i -c 'exit'
}
# }}} </zsh interactive once>

# {{{ <main loop>
_main() {
	_clone_zinit
	_define_zsh_plugins
	_clone_zsh_plugins
	_zsh_interactive_once
}
_main
# }}} </main loop>

_mordu "Completed script."
