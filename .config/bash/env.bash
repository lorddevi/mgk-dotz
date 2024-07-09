#!/usr/bin/env bash
_location=".config/bash/env.bash"

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

# {{{ === Sanity Proof Interactive Env with BASH_ENV ===
# We need to set BASH_ENV, for *non-interactive* shells.
# (unlike $ENV, which is for interactive shells)
_mordu "Setting BASH_ENV to pass Env Vars to non-interactive shells we might start."
export BASH_ENV=~/.config/bash/env.bash
# }}} === Sanity Proof Interactive Env with BASH_ENV ===

# {{{ === Configure HISTFILE Home ===
_mordu "Configuring HISTFILE Home."
if [ ! -d "$HOME"/.local/share/bash/ ] ; then
	_mordu "Could not find ~/.local/share/bash/.  Creating."
	mkdir -p "$HOME"/.local/share/bash
fi

HISTFILE="$HOME"/.local/share/bash/${HOST//\./_}_bash_history
export HISTFILE
# }}} === Configure HISTFILE Home ===

# {{{ === Source Posix-Common Env Vars ===
_mordu "Sourcing Env Vars from ~/.config/posix-common/env.sh."
source "$HOME"/.config/posix-common/env.sh
_location="bash/env.bash"
_mordu "Finished sourcing Env Vars from ~/.config/posix-common/env.sh."
# }}} === Source Posix-Common Env Vars ===

_mordu "Finished script." 
