#!/usr/bin/env sh
_location=".config/posix-common/env.d/common_envs.sh"

# Not just for exporting Environment Variables, but also useful for
# running conditional tests, creating directories, moving files, etc.
#
# There is some cross over between this file and
# ~/.config/posix-common/env_local.sh.  Both are intended for
# environment variables which are going to be needed frequently.  And
# both will be polled for non-login as well as login shells.  As well
# as interactive shells.

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

# {{{ === Source env_functions.sh ===
_mordu "Sourcing env_functions.sh."
. "$HOME"/.config/posix-common/env_functions.sh
_location=".config/posix-common/env.d/common_envs.sh"
_mordu "Finished sourcing env_functions.sh."
# }}} === Source env_functions.sh ===

# {{{ === Configure Cargo's Environment ===
_mordu "Configuring CARGO_HOME and adding to PATH."
export CARGO_HOME="$HOME"/.local/opt/cargo
pathprepend "$HOME"/.local/opt/cargo/bin PATH

if [ ! -d "$HOME"/.local/opt/cargo/bin ]; then
	_mordu "Did not find ~/.local/opt/cargo/bin.  Creating."
	mkdir -p "$HOME"/.local/opt/cargo/bin
fi
# }}} === Configure Cargo's Environment ===

# {{{ === Configure Go's Environment ===
_mordu "Configuring GO_HOME and adding to PATH."
export GOPATH="$HOME"/.local/opt/go
pathprepend "$HOME"/.local/opt/go/bin PATH

if [ ! -d "$HOME"/.local/opt/go/bin ]; then
	_mordu "Did not find ~/.local/opt/go/bin.  Creating."
	mkdir -p "$HOME"/.local/opt/go/bin
fi
# }}} === Configure GO's Environment ===

# {{{ === Configure GUIX's Environment ===
## GUIX bin and Profile can be set if it looks like it exists.
#if [ -d "$HOME"/.config/guix/current/bin ]; then
#	_mordu "Found GUIX installed.  Setting up PATH and GUIX_PROFILE."
#	pathprepend "$HOME"/.config/guix/current/bin
#	GUIX_PROFILE="$HOME/.config/guix/current"
#	export GUIX_PROFILE
#fi
# }}} === Configure GUIX's Environment ===

# {{{ === Manage ~/.local/bin ===
## Add ~/.local/bin to PATH, make it if it doesn't exist.
if [ ! -d "$HOME"/.local/bin ]; then
	_mordu "Did not find ~/.local/bin.  Creating."
	mkdir -p "$HOME"/.local/bin
fi
_mordu "Adding ~/.local/bin to PATH"
pathprepend "$HOME"/.local/bin PATH
# }}} === Manage ~/.local/bin ===

# {{{ === PATH Sanity Checking ===
# The current directory ( . ) should never be in $PATH
_mordu "Trimming current dir from PATH."
pathremove . PATH
pathremove "" PATH
# }}} === PATH Sanity Checking ===

# {{{ === Manage ~/.local/share/man ===
if [ ! -d "$HOME"/.local/share/man ]; then
	_mordu "Did not find ~/.local/share/man.  Creating."
	mkdir -p "$HOME"/.local/share/man
fi

_mordu "Adding ~/.local/share/man to MANPATH."
MANPATH=":$HOME/.local/share/man"
export MANPATH
# }}} === Manage ~/.local/share/man ===

# {{{ === Editor Related: Emacs, NeoVim, Vim, etc. ===
_mordu "Configuring EDITOR."
if command -v emacs > /dev/null ; then
	_mordu "Setting EDITOR to: emacs"
	EDITOR='emacs'
elif command -v nvim > /dev/null ; then
	_mordu "Setting EDITOR to: nvim"
	EDITOR='nvim'
elif command -v vim > /dev/null ; then
	_mordu "Setting EDITOR to: vim"
	EDITOR='vim'
elif command -v vi > /dev/null ; then
	_mordu "Setting EDITOR to: vi"
	EDITOR='vi'
elif command -v nano > /dev/null ; then
	_mordu "Setting EDITOR to: nano"
	EDITOR='nano'
fi

VISUAL=$EDITOR 
export EDITOR VISUAL
# }}} === Editor Related: Emacs, NeoVim, Vim, etc. ===

# {{{ === Shell Related ===
# Set FZF's appearance.
export FZF_DEFAULT_OPTS="--color=dark --border=rounded"
# }}} === Shell Related ===

# {{{ === Xorg Related Environment ===
GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc"
export GTK2_RC_FILES

# For QT Theme management via qt5ct
QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORMTHEME

#GDK_SCALE=2
#GDK_DPI_SCALE=0.5
# }}} === Xorg Related Environment ===

_mordu "Finished script."
