#!/usr/bin/env bash
_location=".config/bash/profile.bash"

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

# {{{ === Source env.bash ===
# 1. Ensure ~/.config/bash/env.bash gets run first
_mordu "Sourcing Env Vars from ~/.config/bash/env.bash."
source "$HOME"/.config/bash/env.bash
_location=".config/bash/profile.bash"
_mordu "Finished sourcing Env Vars from ~/.config/bash/env.bash."
# }}} === Source env.bash ===

# {{{ === Sanity Proof BASH_ENV. ===
# 2. Prevent BASH_ENV from being sourced later, since we need to use $BASH_ENV
# for non-login non-interactive shells.  We don't export it, as we may have a
# non-login non-interactive shell as a child.
_mordu "Sanity proofing BASH_ENV by setting it to nothing."
BASH_ENV=
# }}} === Sanity Proof BASH_ENV. ===

# {{{ === Source login.bash ===
_mordu "Sourcing Login Shell settings from ~/.config/bash/login.bash."
source "$HOME"/.config/bash/login.bash
_location=".config/bash/profile.bash"
_mordu "Finished sourcing Login Shell settings from ~/.config/bash/login.bash."
# }}} === Source login.bash ===

# {{{ === Source interactive.bash ===
# 4. Run ~/.config/etc/bash/interactive.bash if this is an interactive shell.
if [ "$PS1" ]; then
	_mordu "Sourcing Interactive Shell settings from ~/.config/bash/interactive.bash."
	source "$HOME"/.config/bash/interactive.bash
	_location=".config/bash/profile.bash"
	_mordu "Finished sourcing Interactive Shell settings from ~/.config/bash/interactive.bash."
fi
# }}} === Source interactive.bash ===

_mordu "Finished script."
