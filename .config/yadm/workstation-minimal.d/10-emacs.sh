#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/10-emacs.sh"
export GHQ_ROOT="${HOME}/.local/opt/git"
_ghq="${HOME}/.local/opt/go/bin/ghq"
_emacs_branch="master"

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

# {{{ <install emacs using dnf>
_dnf_install_emacs() {
	local __required_packages=(emacs-gtk+x11)

	for __package in "${__required_packages[@]}" ; do
		if [[ $(rpm -qi "${__package//\"/}") == "package ${__package//\"/} is not installed"  ]] ; then
			_mordu "Not installed yet: $__package."
			local __not_installed_yet+=( "$__package" )
		else
			_mordu "Found $__package."
		fi
	done

	_mordu "Total not installed yet: ${__not_installed_yet[*]}"

	if (( ${#__not_installed_yet[@]} )); then
		sudo dnf -y install --allowerasing "${__not_installed_yet[@]}"
	fi

	_mordu "Completing dependancy install with remaining packages."
	sudo dnf -y builddep emacs
}
# }}} </install emacs using dnf>

# {{{ <configure alternates>
_configure_alternates()  {
	_mordu "Setting default version of emacs to /usr/bin/emacs-gtk+11."
	sudo alternatives --install /usr/bin/emacs emacs /usr/bin/emacs-gtk+x11 90
	sudo alternatives --auto emacs
	_mordu "Changed default version of emacs."
}
# }}} </configure alternates>

# {{{ <clone chemacs>
_clone_chemacs() {
	local __repo="git.mgk.one/emacs/plexus.chemacs2"

	if $_ghq list | grep -q "$__repo" ; then
		_mordu "Repository ${__repo} already cloned.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu "Repository ${__repo} not cloned yet.  Cloning"
		$_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| $_ghq get "$__repo" \
		|| _mordu "Failed to download ${__repo} three times."
	fi
}
# }}} </clone chemacs>

# {{{ <move and backup old configs>
_move_and_backup_old_configs() {
	_mordu "Checking for existing emacs configs to backup."
	if [ -f "${HOME}/.emacs" ]; then
		_mordu "Found ${HOME}/.emacs, moving to .bak version."
		mv "${HOME}.emacs" "${HOME}/.emacs.bak"
	fi
	
	if [ -d "${HOME}/.emacs.d" ]; then
		_mordu "Found ${HOME}/.emacs.d, moving to .bak version."
		mv "${HOME}/.emacs.d" "${HOME}/.emacs.d.bak"
	fi

	if [ -d "${HOME}/.config/emacs" ]; then
		_mordu "Found ${HOME}/.config/emacs, moving to .bak version."
		mv "${HOME}/.config/emacs" "${HOME}/.config/emacs.bak"
	fi
}
# }}} </move and backup old configs>

# {{{ <link chemacs to .config/emacs>
_link_chemacs_to_config() {
	local __repo="git.mgk.one/emacs/plexus.chemacs2"

	_mordu "Linking chemacs to .config/emacs."
	ln -sr "${GHQ_ROOT}/${__repo}" \
		"${HOME}/.config/emacs"

	# To avoid an annoying error message about org-id-locations not being found
	# during tangle, we will just create this file here.  It werks. :P
	if [ ! -f "${HOME}/.config/emacs/.org-id-locations" ]; then
		_mordu "Could not find ${HOME}/.config/emacs/.org-id-locations file.  Creating."
		touch "${HOME}/.config/emacs/.org-id-locations"
	fi
}
# }}} </link chemacs to .config/emacs>

# {{{ <tangle emacs config>
_tangle_emacs_config() {
	_mordu "Changing to directory ${HOME}/.config/chemacs/profiles/default."
	cd "${HOME}/.config/chemacs/profiles/default" || exit
	_mordu "Performing tangle by running retangle.sh."
	bash re-tangle.sh
}
# }}} </tangle emacs config>

# {{{ <run emacs to bootstrap>
_run_emacs_to_bootstrap() {
	_mordu "Bootstrapping emacs with an initial dry run."
	emacs --batch --load ~/.config/emacs/early-init.el --load ~/.config/emacs/init.el --eval '(kill-emacs)'
	_mordu "Completed initial run of emacs."
}
# }}} </run emacs to bootstrap>

# {{{ <main loop>
_main() {
	_dnf_install_emacs
	_configure_alternates
	_clone_chemacs
	_move_and_backup_old_configs
	_link_chemacs_to_config
	_tangle_emacs_config
	_run_emacs_to_bootstrap
}
_main
# }}} </main loop>

_mordu "Completed script."
