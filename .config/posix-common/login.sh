#!/usr/bin/env sh
_location=".config/posix-common/login.sh"

# Environment variables that don't need to be set for every terminal you open,
# put here. These envrionment variables get set once upon login and that's it.

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

# {{{ === Personal Information ===
_mordu "Setting PIM data." 
NAME='Lord_Devi'
EMAIL='lord@mgk.one'
export NAME EMAIL
# }}} === Personal Information ===

# {{{ === Localizations ===
_mordu "Setting localization environment variables."
LANG='en_US.UTF-8'
LC_ALL=$LANG
LC_COLLATE=$LANG
LC_CTYPE=$LANG
LC_MESSAGES=$LANG
LC_MONETARY=$LANG
LC_NUMERIC=$LANG
LC_TIME=$LANG
export LANG LC_ALL LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC \
	LC_TIME
# }}} === Localizations ===

_mordu "Finished script."
