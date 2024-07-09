#!/usr/bin/env bash
_location=".config/yadm/workstation-minimal.d/09-emacs.sh"
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

# {{{ <clone tree-sitter>
_clone_tree-sitter() {
	local __repo="git.mgk.one/libs-code/tree-sitter.tree-sitter"

	if $_ghq list | grep -q "$__repo" ; then
		_mordu "Repository ${__repo} already cloned.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu "Repository ${__repo} not cloned yet.  Cloning"
		$_ghq get "$__repo"
	fi
}
# }}} </clone tree-sitter>

# {{{ <install tree-sitter>
_install_tree-sitter() {
	local __repo="git.mgk.one/libs-code/tree-sitter.tree-sitter"

	cd "${GHQ_ROOT}/${__repo}"

	_mordu "Compiling ${__repo}."
	make
	_mordu "Completed compiling ${__repo}."

	_mordu "Installing ${__repo}."
	sudo make install
	_mordu "Completed installing ${__repo}"
}
# }}} </install tree-sitter>

# {{{ <clone emacs>
_clone_emacs() {
	local __repo="git.mgk.one/emacs/gnu.emacs"

	if $_ghq list | grep -q "$__repo" ; then
		_mordu "Repository ${__repo} already cloned.  Updating."
		$_ghq get -u "$__repo"
	else
		_mordu "Repository ${__repo} not cloned yet.  Cloning"
		$_ghq get "$__repo"
	fi
}
# }}} </clone emacs>

# {{{ <install deps for emacs>
_install_deps() {
	local __required_packages=(wxBase-devel wxGTK-devel libwebp-devel jansson jansson-devel ImageMagick ImageMagick-devel libtree-sitter-devel libtree-sitter tree-sitter-cli)

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
# }}} </install deps for emacs>

# {{{ <prepare repo>
_prepare_emacs_repo() {
	local __repo="git.mgk.one/emacs/gnu.emacs"

	cd "${GHQ_ROOT}/${__repo}"
	_mordu "Performing make distclean."
	make distclean
	_mordu "Performing make uninstall."
	make uninstall
	_mordu "Performing git checkout on branch ${_emacs_branch}."
	git checkout "$_emacs_branch"
	_mordu "Pulling most recent changes."
	git pull
	_mordu "Ensuring current head is set correctly."
	git reset --hard HEAD
}
# }}} </prepare repo>

# {{{ <configure emacs>
_configure_emacs_repo() {
	CC='CFLAGS=-DMAIL_USE_LOCKF -O2 -flto=auto -ffat-lto-objects -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64  -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer'
	LDFLAGS='-Wl,-z,relro gcc'
	PKG_CONFIG_PATH=:/usr/lib64/pkgconfig:/usr/share/pkgconfig

	local __repo="git.mgk.one/emacs/gnu.emacs"

	cd "${GHQ_ROOT}/${__repo}"

	_mordu "Performing autogen."
	./autogen.sh
	_mordu "Performing configure."
	./configure \
	  --prefix="${HOME}/.local" \
	  --with-mailutils \
	  --with-x-toolkit=lucid \
	  --with-native-compilation \
		--with-tree-sitter \
		--with-imagemagick \
		--without-compress-install \
	  build_alias=x86_64-redhat-linux-gnu \
	  host_alias=x86_64-redhat-linux-gnu
	_mordu "Completed configure."
}
# }}} </configure emacs>

# {{{ <compile repo>
_compile_emacs_repo() {
	local __repo="git.mgk.one/emacs/gnu.emacs"

	cd "${GHQ_ROOT}/${__repo}"
	_mordu "Performing compilation process."
	make -j8
	_mordu "Complete compile process."
}
# }}} </compile repo>

# {{{ <install repo>
_install_emacs_repo() {
	local __repo="git.mgk.one/emacs/gnu.emacs"

	cd "${GHQ_ROOT}/${__repo}"
	_mordu "Performing installation process."
	make install
	_mordu "Completed installation process."
}
# }}} </install repo>

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
		$_ghq get "$__repo"
	fi
}
# }}} </clone chemacs>

# {{{ <move and backup old configs>
_move_and_backup_old_configs() {
	_mordu "Checking for existing emacs configs to backup."
	if [ -f "${HOME}/.emacs" ]; then
		_mordu "Found ${HOME}/.emacs, moving to .bak version."
		mv "${HOME}/.emacs.bak"
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
}
# }}} </link chemacs to .config/emacs>

# {{{ <run emacs to bootstrap>
_run_emacs_to_bootstrap() {
	_mordu "Bootstrapping emacs with an initial dry run."
	emacs --batch --load ~/.config/emacs/early-init.el --load ~/.config/emacs/init.el --eval '(kill-emacs)'
	_mordu "Completed initial run of emacs."
}
# }}} </run emacs to bootstrap>

# {{{ <main loop>
_main() {
	_clone_tree-sitter
	_install_tree-sitter
	_clone_emacs
	_install_deps
	_prepare_emacs_repo
	_configure_emacs_repo
	_compile_emacs_repo
	_install_emacs_repo
	_dnf_install_emacs
	_configure_alternates
	_clone_chemacs
	_move_and_backup_old_configs
	_link_chemacs_to_config
	_run_emacs_to_bootstrap
}
_main
# }}} </main loop>

_mordu "Completed script."
