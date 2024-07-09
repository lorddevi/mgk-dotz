#!/usr/bin/env sh
_location=".config/posix-common/env_functions.sh"

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

# {{{ === PATH Management Functions ===
_mordu "Creating PATH management functions."
# Usage: indirect_expand PATH -> $PATH
indirect_expand () {
	env |sed -n "s/^$1=//p"
}

# Usage: pathremove /path/to/bin [PATH]
# Eg, to remove ~/bin from $PATH
#     pathremove ~/bin PATH
pathremove () {
	local IFS=':'
	local newpath
	local dir
	local var=${2:-PATH}
	# Bash has ${!var}, but this is not portable.
	for dir in $(indirect_expand "$var"); do
		IFS=''
		if [ "$dir" != "$1" ]; then
			newpath="$newpath:$dir"
		fi
	done
	export "$var"="${newpath#:}"
}

# Usage: pathprepend /path/to/bin [PATH]
# Eg, to prepend ~/bin to $PATH
#     pathprepend ~/bin PATH
pathprepend () {
	# if the path is already in the variable,
	# remove it so we can move it to the front
	pathremove "$1" "$2"
	#[ -d "${1}" ] || return
	local var="${2:-PATH}"
	local value=$(indirect_expand "$var")
	export "${var}=${1}${value:+:${value}}"
}

# Usage: pathappend /path/to/bin [PATH]
# Eg, to append ~/bin to $PATH
#     pathappend ~/bin PATH
pathappend () {
	pathremove "${1}" "${2}"
	#[ -d "${1}" ] || return
	var=${2:-PATH}
	value=$(indirect_expand "$var")
	export "$var=${value:+${value}:}${1}"
}
# }}} === PATH Management Functions ===

_mordu "Finished script."
