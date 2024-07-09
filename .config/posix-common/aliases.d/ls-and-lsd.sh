#!/usr/bin/env sh
_location=".config/posix-common/aliases.d/ls-and-lsd.sh"

# Generally speaking, put items that are intended for INTERACTIVE
# shells in here.  If it is a setting that might be needed by an piece
# of software that might get ran during non-interactive shells - put
# that in common-envs.sh instead.

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

# {{{ === Aliases: 'ls' Related ===
# 'ls' - Colorize if possible, and create shortcuts
if command -v lsd > /dev/null 2>&1; then # Typically I have this on Linux.
	_mordu "Found 'lsd', configuring aliases for it."
	alias ls='lsd -F --color=auto --icon=auto --date relative --size short'
	elif command -v colorls > /dev/null ; then # This is OpenBSD usually.
		alias ls='colorls -FGh'
	elif [ "$(uname)" = 'Linux' ]; then # If it is Linux we can assume gnu ls.
		alias ls='ls -Fh --color=auto --time-style=long-iso' # Set color to auto and enable classify.
	else
    alias ls='ls -Fh' # At least ensure --classify is on.
fi

_mordu "Creating 'ls' related aliases."
alias ll="exa -l"
alias la="exa -A"
alias lla="exa -lA"

# 'lt' Tree basically, but for all files minus '.' and '..'.
# Also with preference for 'lsd --tree' over 'tree -a'
if command -v lsd > /dev/null ; then # Typically I have this on Linux.
	_mordu "Creating tree related aliases using lsd'."
	alias lt='lsd --tree'
	alias lta='lt -A'
elif command -v tree > /dev/null ; then
	alias lt='tree'
	alias lta='lt -a'
fi
# }}} === Aliases: 'ls' Related ===

_mordu "Finished script."
