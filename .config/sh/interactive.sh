#!/usr/bin/env sh
_location=".config/sh/interactive.sh"

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

# {{{ === Source Posix Common interactive.sh ===
_mordu "Sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh."
. "$HOME"/.config/posix-common/interactive.sh
_location=".config/sh/interactive.sh"
_mordu "Finished sourcing Interactive Shell settings from ~/.config/posix-common/interactive.sh."
# }}} === Source Posix Common interactive.sh ===

# {{{ === FreeBSD Tweaks ===
# Some FreeBSD related sh(1) nicities.
# Let sh(1) know it's at home, despite /home being a symlink.
# shellcheck disable=SC3000-SC4000
if [ "$PWD" != "$HOME" ] && [ "$PWD" -ef "$HOME" ] ; then cd || exit ; fi

# Query terminal size; useful for serial lines.
if [ -x /usr/bin/resizewin ] ; then /usr/bin/resizewin -z ; fi 
# }}} === FreeBSD Tweaks ===

# {{{ === Configure the HISTFILE for sh ===
# Set HISTFILE.  Normally I put this in env.sh or similar, but
# ~/.config/sh/env.sh doesn't get called by interactive sh shells,
# and I want it to be.
_mordu "Setting HISTFILE to avoid homedir spam."
if [ -d "$HOME"/.local/share/sh/ ] ; then
	_mordu "$HOME/.local/share/sh/ not found.  Creating."
	mkdir -p "$HOME"/.local/share/sh
fi
HISTFILE="$HOME/.local/share/sh/$(echo "$HOST"|sed 's/\./_/g')_sh_history"
export HISTFILE
# }}} === Configure the HISTFILE for sh ===

# {{{ === Sourcing prompt.sh ===
_mordu "Sourcing sh prompt from ~/.config/sh/prompt.sh."
. "$HOME"/.config/sh/prompt.sh
_location=".config/sh/interactive.sh"
_mordu "Finished sourcing sh prompt from ~/.config/sh/prompt.sh."
# }}} === Sourcing prompt.sh ===

# {{{ === Enable vi mode for 'sh' ===
# This had a surprise for me when bash's sh emulation mode is
# being used for 'sh'.  Bash (sh) disables TAB completion when set
# to vi mode.  So we have to rebind completion to TAB.  But 'bind'
# is not available on Ksh, which also uses our 'sh' scripts for
# this level of init.  So we need to have a conditional testing
# for bind first.  Then if it is available, we can go ahead and
# tell it to ensure TAB is properly calling the completion
# framework for bash.
# Update: Can't actually get 'bind TAB:complete" to work!  It works
# fine in a live shell, but when that same shell calls this from an
# init script: no go.
_mordu "Enabling Vi mode for command line."
set -o vi
# }}} === Enable vi mode for 'sh' ===

_mordu "Finished script."
